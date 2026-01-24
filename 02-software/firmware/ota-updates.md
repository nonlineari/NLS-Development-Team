# Over-The-Air (OTA) Updates

## Overview

This document describes the Over-The-Air (OTA) firmware update system for the NLS Artist Systems tracker device, enabling remote firmware updates without physical access to the device.

## OTA Update Architecture

### Update Flow
```
1. Device checks for updates (periodic or manual)
2. Download firmware from server
3. Verify firmware signature
4. Write to OTA partition
5. Set boot partition to OTA
6. Reboot device
7. New firmware runs
```

### Partition Layout
```
┌─────────────────────────────────────┐
│     Partition Table                 │
├─────────────────────────────────────┤
│  Bootloader (32KB)                  │
├─────────────────────────────────────┤
│  Factory App (1.5MB)                │
├─────────────────────────────────────┤
│  OTA_0 App (1.5MB)                  │
├─────────────────────────────────────┤
│  OTA_1 App (1.5MB)                  │
├─────────────────────────────────────┤
│  NVS (16KB) - Configuration         │
├─────────────────────────────────────┤
│  Storage (SPIFFS/LittleFS)           │
└─────────────────────────────────────┘
```

## OTA Methods

### 1. HTTP/HTTPS OTA

#### Overview
Download firmware from HTTP/HTTPS server.

#### Implementation
```c
#include "esp_https_ota.h"

esp_err_t ota_update_http(const char *url) {
    esp_http_client_config_t config = {
        .url = url,
        .cert_pem = server_cert_pem_start,
    };
    
    esp_https_ota_config_t ota_config = {
        .http_config = &config,
    };
    
    return esp_https_ota(&ota_config);
}
```

#### Server Requirements
- HTTP/HTTPS server hosting firmware binaries
- Firmware version endpoint
- Firmware binary endpoint

### 2. MQTT OTA

#### Overview
Receive firmware updates via MQTT messages.

#### Implementation
```c
void mqtt_ota_callback(const char *topic, const char *data) {
    if (strcmp(topic, "device/ota/url") == 0) {
        // Extract URL from MQTT message
        ota_update_http(data);
    }
}
```

#### MQTT Topics
- `device/{device_id}/ota/url` - Firmware URL
- `device/{device_id}/ota/status` - Update status
- `device/{device_id}/ota/version` - Current version

### 3. WebSocket OTA

#### Overview
Stream firmware updates via WebSocket connection.

#### Implementation
```c
void ws_ota_handler(websocket_frame_t *frame) {
    if (frame->opcode == WS_OPCODE_BINARY) {
        // Write firmware chunk to OTA partition
        esp_ota_write(ota_handle, frame->payload, frame->payload_len);
    }
}
```

## Security

### Firmware Signing

#### Overview
Verify firmware authenticity using digital signatures.

#### Implementation
```c
#include "esp_ota_ops.h"

esp_err_t verify_firmware_signature(const uint8_t *signature, size_t sig_len) {
    // Verify signature using public key
    mbedtls_pk_context pk;
    mbedtls_pk_init(&pk);
    
    // Load public key
    mbedtls_pk_parse_public_key(&pk, public_key, public_key_len);
    
    // Verify signature
    return mbedtls_pk_verify(&pk, MBEDTLS_MD_SHA256,
                             hash, hash_len,
                             signature, sig_len);
}
```

### Secure Boot

#### Overview
Verify bootloader and firmware at boot time.

#### Configuration
```bash
# Enable secure boot
idf.py menuconfig
# Security features → Enable hardware Secure Boot
```

### TLS/SSL

#### Overview
Use TLS for secure firmware downloads.

#### Implementation
```c
esp_http_client_config_t config = {
    .url = "https://firmware.example.com/update.bin",
    .cert_pem = server_cert_pem,
    .skip_cert_common_name_check = false,
};
```

## Update Process

### 1. Check for Updates

#### Periodic Check
```c
void ota_check_task(void *pvParameters) {
    while (1) {
        // Check for updates every hour
        vTaskDelay(pdMS_TO_TICKS(3600000));
        
        esp_err_t err = ota_check_update();
        if (err == ESP_OK) {
            ESP_LOGI(TAG, "Update available");
        }
    }
}
```

#### Manual Check
```c
// Via API
esp_err_t ota_check_update(void);

// Via MQTT
// Publish to: device/{device_id}/ota/check
```

### 2. Download Firmware

#### Progress Callback
```c
void ota_progress_callback(int current, int total) {
    int percentage = (current * 100) / total;
    ESP_LOGI(TAG, "OTA Progress: %d%%", percentage);
    
    // Publish progress via MQTT
    char progress_msg[32];
    snprintf(progress_msg, sizeof(progress_msg), "{\"progress\":%d}", percentage);
    mqtt_publish("device/ota/progress", progress_msg);
}
```

### 3. Verify Firmware

#### Version Check
```c
esp_app_desc_t running_app_info;
esp_ota_get_partition_description(running_handle, &running_app_info);

esp_app_desc_t new_app_info;
esp_ota_get_partition_description(new_handle, &new_app_info);

if (strcmp(new_app_info.version, running_app_info.version) == 0) {
    ESP_LOGW(TAG, "Same version, skipping update");
    return ESP_ERR_INVALID_VERSION;
}
```

#### Signature Verification
```c
esp_err_t verify_firmware(const uint8_t *firmware, size_t len) {
    // Calculate hash
    uint8_t hash[32];
    mbedtls_sha256(firmware, len, hash, 0);
    
    // Verify signature
    return verify_firmware_signature(signature, signature_len);
}
```

### 4. Install Firmware

#### Write to OTA Partition
```c
esp_ota_handle_t ota_handle;
esp_err_t err = esp_ota_begin(ota_partition, OTA_SIZE_UNKNOWN, &ota_handle);
if (err != ESP_OK) {
    ESP_LOGE(TAG, "esp_ota_begin failed: %s", esp_err_to_name(err));
    return err;
}

// Write firmware in chunks
err = esp_ota_write(ota_handle, firmware_chunk, chunk_size);
if (err != ESP_OK) {
    ESP_LOGE(TAG, "esp_ota_write failed: %s", esp_err_to_name(err));
    return err;
}

// Finalize
err = esp_ota_end(ota_handle);
if (err != ESP_OK) {
    ESP_LOGE(TAG, "esp_ota_end failed: %s", esp_err_to_name(err));
    return err;
}
```

#### Set Boot Partition
```c
err = esp_ota_set_boot_partition(ota_partition);
if (err != ESP_OK) {
    ESP_LOGE(TAG, "esp_ota_set_boot_partition failed: %s", esp_err_to_name(err));
    return err;
}
```

### 5. Reboot Device

#### Reboot
```c
ESP_LOGI(TAG, "Rebooting to new firmware...");
esp_restart();
```

## Rollback Mechanism

### Automatic Rollback

#### Overview
Automatically rollback to previous firmware if new firmware fails.

#### Implementation
```c
void app_main(void) {
    // Check if boot was successful
    if (!boot_successful()) {
        ESP_LOGW(TAG, "Boot failed, rolling back...");
        esp_ota_set_boot_partition(factory_partition);
        esp_restart();
    }
    
    // Mark boot as successful
    mark_boot_successful();
}
```

### Manual Rollback

#### Via API
```c
esp_err_t ota_rollback(void) {
    const esp_partition_t *factory = esp_partition_find_first(
        ESP_PARTITION_TYPE_APP, ESP_PARTITION_SUBTYPE_APP_FACTORY, NULL);
    
    return esp_ota_set_boot_partition(factory);
}
```

## Update Server

### Server Requirements

#### HTTP Server
- Host firmware binaries
- Provide version information
- Support range requests for resumable downloads

#### Example Server Endpoints
```
GET /firmware/version
Response: {"version": "1.2.3", "url": "/firmware/v1.2.3.bin"}

GET /firmware/v1.2.3.bin
Response: Firmware binary file
```

### Firmware Versioning

#### Version Format
- **Format**: `MAJOR.MINOR.PATCH`
- **Example**: `1.2.3`

#### Version Comparison
```c
int compare_versions(const char *v1, const char *v2) {
    int major1, minor1, patch1;
    int major2, minor2, patch2;
    
    sscanf(v1, "%d.%d.%d", &major1, &minor1, &patch1);
    sscanf(v2, "%d.%d.%d", &major2, &minor2, &patch2);
    
    if (major1 != major2) return major1 - major2;
    if (minor1 != minor2) return minor1 - minor2;
    return patch1 - patch2;
}
```

## Configuration

### OTA Configuration
```c
typedef struct {
    bool enabled;                    // Enable OTA updates
    uint32_t check_interval_ms;      // Check interval
    const char *update_url;          // Update server URL
    bool verify_signature;           // Verify firmware signature
    bool auto_reboot;                // Auto reboot after update
    uint32_t timeout_ms;             // Download timeout
} ota_config_t;
```

### Partition Configuration
```csv
# partitions.csv
# Name,   Type, SubType, Offset,  Size, Flags
nvs,      data, nvs,     0x9000,  0x4000,
otadata,  data, ota,     0xd000,  0x2000,
phy_init, data, phy,     0xf000,  0x1000,
factory,  app,  factory, 0x10000, 1M,
ota_0,    app,  ota_0,   ,       1M,
ota_1,    app,  ota_1,   ,       1M,
storage,  data, spiffs,  ,       512K,
```

## Error Handling

### Common Errors

#### Download Failed
```c
if (err == ESP_ERR_HTTP_FETCH_HEADER) {
    ESP_LOGE(TAG, "Failed to fetch header");
    // Retry or notify user
}
```

#### Verification Failed
```c
if (err == ESP_ERR_INVALID_SIGNATURE) {
    ESP_LOGE(TAG, "Invalid firmware signature");
    // Abort update, keep current firmware
}
```

#### Insufficient Space
```c
if (err == ESP_ERR_NO_MEM) {
    ESP_LOGE(TAG, "Insufficient space for OTA");
    // Clean up storage or notify user
}
```

## Best Practices

### 1. Always Verify Firmware
- Check version before updating
- Verify signature
- Validate firmware size

### 2. Provide User Feedback
- Show update progress
- Notify on completion/failure
- Allow user to cancel (if possible)

### 3. Handle Interruptions
- Support resumable downloads
- Handle network disconnections
- Implement timeout handling

### 4. Test Updates
- Test on development devices first
- Staged rollout (beta → production)
- Monitor for issues

## Related Documentation

- [Firmware Overview](./overview.md) - Firmware architecture
- [Core Components](./core-components.md) - Component details
- [Device Management](../04-development/api/) - Device management API

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
