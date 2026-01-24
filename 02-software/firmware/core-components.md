# Core Firmware Components

## Overview

This document describes the core firmware components of the NLS Artist Systems tracker device, including their functionality, APIs, and usage.

## Component Architecture

### Component List
1. **Device Management** - Configuration, status, OTA updates
2. **Sensor Manager** - Sensor initialization, data collection, processing
3. **Communication Manager** - WiFi, Bluetooth, network protocols
4. **Data Storage** - Local storage, caching, buffering
5. **Power Management** - Power modes, battery management
6. **NLS Integration** - TidalCycles, Hyperfone, Pulsar Agent

## 1. Device Management

### Overview
Manages device configuration, status monitoring, and firmware updates.

### Features
- Configuration management (persistent storage)
- Device status and health monitoring
- OTA firmware updates
- Logging and debugging
- Device identification

### API Example
```c
// Initialize device management
esp_err_t device_mgmt_init(void);

// Get device status
device_status_t device_mgmt_get_status(void);

// Update configuration
esp_err_t device_mgmt_update_config(config_t *config);

// Trigger OTA update
esp_err_t device_mgmt_ota_update(const char *url);
```

### Configuration Structure
```c
typedef struct {
    char device_id[32];
    char device_name[64];
    wifi_config_t wifi;
    mqtt_config_t mqtt;
    sensor_config_t sensors;
    power_config_t power;
} device_config_t;
```

## 2. Sensor Manager

### Overview
Manages sensor initialization, data collection, and processing.

### Features
- Multi-sensor support (IMU, GPS, environmental)
- Sensor calibration
- Data fusion (sensor fusion algorithms)
- Filtering and smoothing
- Event-driven and periodic sampling

### API Example
```c
// Initialize sensor manager
esp_err_t sensor_mgr_init(void);

// Register sensor
esp_err_t sensor_mgr_register(sensor_t *sensor);

// Start data collection
esp_err_t sensor_mgr_start(void);

// Get sensor data
esp_err_t sensor_mgr_get_data(sensor_id_t id, sensor_data_t *data);

// Calibrate sensor
esp_err_t sensor_mgr_calibrate(sensor_id_t id);
```

### Sensor Data Structure
```c
typedef struct {
    uint64_t timestamp;
    float accel_x, accel_y, accel_z;
    float gyro_x, gyro_y, gyro_z;
    float mag_x, mag_y, mag_z;
    float temperature;
    float pressure;
    float humidity;
} sensor_data_t;
```

### Sensor Fusion
- **IMU Fusion**: Complementary filter, Kalman filter
- **GPS/IMU Fusion**: Extended Kalman filter
- **Orientation Estimation**: Quaternion, Euler angles

## 3. Communication Manager

### Overview
Manages all communication interfaces and protocols.

### Features
- WiFi connectivity and management
- Bluetooth Low Energy (BLE)
- MQTT client
- WebSocket server/client
- OSC (Open Sound Control)
- HTTP/HTTPS client

### API Example
```c
// Initialize communication manager
esp_err_t comm_mgr_init(void);

// Connect to WiFi
esp_err_t comm_mgr_wifi_connect(const char *ssid, const char *password);

// Publish MQTT message
esp_err_t comm_mgr_mqtt_publish(const char *topic, const char *data);

// Send OSC message
esp_err_t comm_mgr_osc_send(const char *path, float *values, size_t count);

// Start WebSocket server
esp_err_t comm_mgr_ws_start(uint16_t port);
```

### Protocol Handlers
```c
// MQTT callback
typedef void (*mqtt_callback_t)(const char *topic, const char *data);

// WebSocket callback
typedef void (*ws_callback_t)(const char *message);

// OSC callback
typedef void (*osc_callback_t)(const char *path, float *values, size_t count);
```

## 4. Data Storage

### Overview
Manages local data storage, caching, and buffering.

### Features
- Flash storage (SPIFFS, LittleFS)
- Data buffering for network outages
- Data compression
- Storage management (cleanup, rotation)

### API Example
```c
// Initialize storage
esp_err_t storage_init(void);

// Write data
esp_err_t storage_write(const char *key, const void *data, size_t len);

// Read data
esp_err_t storage_read(const char *key, void *data, size_t *len);

// Delete data
esp_err_t storage_delete(const char *key);

// List keys
esp_err_t storage_list_keys(char **keys, size_t *count);
```

### Storage Structure
```
/storage/
├── config/
│   ├── device.json
│   └── network.json
├── data/
│   ├── sensor_data_001.bin
│   └── sensor_data_002.bin
└── logs/
    └── system.log
```

## 5. Power Management

### Overview
Manages power modes, battery monitoring, and power optimization.

### Features
- Multiple power modes (active, light sleep, deep sleep)
- Battery monitoring and charging
- Power consumption optimization
- Wake-up sources configuration

### API Example
```c
// Initialize power management
esp_err_t power_mgmt_init(void);

// Get battery status
battery_status_t power_mgmt_get_battery(void);

// Enter sleep mode
esp_err_t power_mgmt_sleep(sleep_mode_t mode, uint32_t duration_ms);

// Register wake-up source
esp_err_t power_mgmt_register_wakeup(wakeup_source_t source);
```

### Power Modes
```c
typedef enum {
    POWER_MODE_ACTIVE,      // Full operation
    POWER_MODE_LIGHT_SLEEP, // CPU suspended, peripherals active
    POWER_MODE_DEEP_SLEEP,  // Minimal power consumption
    POWER_MODE_HIBERNATION  // Lowest power (optional)
} sleep_mode_t;
```

### Battery Status
```c
typedef struct {
    float voltage;          // Battery voltage (V)
    float current;          // Current draw (mA)
    uint8_t percentage;     // Battery percentage (0-100)
    bool charging;          // Charging status
    bool low_battery;       // Low battery warning
} battery_status_t;
```

## 6. NLS Integration

### Overview
Provides integration with NLS Artist Systems (TidalCycles, Hyperfone, Pulsar Agent).

### Features
- TidalCycles OSC integration
- Hyperfone P2P audio streaming
- Pulsar Agent integration
- Polish notation parser
- Tree traversal algorithms

### API Example
```c
// Initialize NLS integration
esp_err_t nls_integration_init(void);

// Send TidalCycles pattern
esp_err_t nls_send_tidal_pattern(const char *pattern);

// Connect to Hyperfone
esp_err_t nls_hyperfone_connect(const char *peer_id);

// Process Polish notation
esp_err_t nls_polish_eval(const char *expression, float *result);
```

### TidalCycles Integration
```c
// OSC message format for TidalCycles
// /sensor/accel/x float32
// /sensor/accel/y float32
// /sensor/accel/z float32

// Send sensor data to TidalCycles
esp_err_t nls_tidal_send_sensor(sensor_data_t *data);
```

### Hyperfone Integration
```c
// P2P audio streaming
typedef struct {
    char peer_id[64];
    uint16_t audio_port;
    audio_format_t format;
} hyperfone_connection_t;

esp_err_t nls_hyperfone_stream_start(hyperfone_connection_t *conn);
```

## Component Interaction

### Data Flow
```
Sensors → Sensor Manager → Data Storage
                              ↓
                    Communication Manager
                              ↓
                    NLS Integration / Network
```

### Event Flow
```
Hardware Event → Interrupt Handler → Component Handler
                                          ↓
                                    Event Queue
                                          ↓
                                    Application Handler
```

## Configuration

### Component Configuration
Each component can be configured via:
- **Configuration File**: JSON/YAML configuration
- **Menuconfig**: ESP-IDF menuconfig system
- **Runtime API**: Configuration functions

### Example Configuration
```json
{
  "device": {
    "id": "tracker-001",
    "name": "NLS Tracker 1"
  },
  "sensors": {
    "imu": {
      "enabled": true,
      "sample_rate": 100
    },
    "gps": {
      "enabled": false
    }
  },
  "communication": {
    "wifi": {
      "ssid": "network",
      "password": "password"
    },
    "mqtt": {
      "broker": "mqtt.example.com",
      "port": 1883
    }
  }
}
```

## Error Handling

### Error Codes
```c
#define ESP_OK                   0
#define ESP_ERR_INVALID_ARG     0x102
#define ESP_ERR_NO_MEM          0x101
#define ESP_ERR_NOT_FOUND       0x105
#define ESP_ERR_TIMEOUT         0x107
```

### Error Handling Pattern
```c
esp_err_t err = sensor_mgr_init();
if (err != ESP_OK) {
    ESP_LOGE(TAG, "Failed to initialize sensor manager: %s", esp_err_to_name(err));
    return err;
}
```

## Threading Model

### Task Priorities
- **High Priority**: Real-time sensor processing
- **Medium Priority**: Communication, data processing
- **Low Priority**: Logging, non-critical tasks

### Task Structure
```c
// High priority sensor task
void sensor_task(void *pvParameters) {
    while (1) {
        sensor_data_t data;
        sensor_mgr_get_data(SENSOR_IMU, &data);
        // Process data
        vTaskDelay(pdMS_TO_TICKS(10)); // 100Hz
    }
}
```

## Related Documentation

- [Firmware Overview](./overview.md) - Firmware architecture
- [OS Selection](./os-selection.md) - Operating system comparison
- [OTA Updates](./ota-updates.md) - Firmware update system
- [API Documentation](../04-development/api/) - Detailed API reference

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
