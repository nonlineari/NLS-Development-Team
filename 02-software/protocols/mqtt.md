# MQTT Protocol

## Overview

MQTT (Message Queuing Telemetry Transport) is a lightweight messaging protocol used for telemetry data, device control, and real-time communication in the NLS tracker device.

## MQTT Basics

### Protocol Characteristics
- **Lightweight**: Small packet overhead
- **Publish-Subscribe**: Topic-based messaging
- **QoS Levels**: 0, 1, 2 (quality of service)
- **Retain Messages**: Last known value
- **Will Messages**: Notification on disconnect

### Connection Parameters
- **Port**: 1883 (non-TLS), 8883 (TLS)
- **Keep Alive**: 60 seconds (configurable)
- **Clean Session**: true/false
- **Client ID**: Unique per device

## Topic Structure

### Topic Naming Convention
```
nls/tracker/{device_id}/{category}/{action}
```

### Standard Topics

#### Sensor Data
```
nls/tracker/{device_id}/sensors/data
nls/tracker/{device_id}/sensors/imu
nls/tracker/{device_id}/sensors/gps
nls/tracker/{device_id}/sensors/environmental
```

#### Device Status
```
nls/tracker/{device_id}/status
nls/tracker/{device_id}/status/battery
nls/tracker/{device_id}/status/connectivity
nls/tracker/{device_id}/status/health
```

#### Device Control
```
nls/tracker/{device_id}/control/commands
nls/tracker/{device_id}/control/config
nls/tracker/{device_id}/control/ota
```

#### Configuration
```
nls/tracker/{device_id}/config/update
nls/tracker/{device_id}/config/request
```

## Message Format

### JSON Message Format
```json
{
  "timestamp": 1641234567890,
  "device_id": "tracker-001",
  "data": {
    "accel": {"x": 0.1, "y": 0.2, "z": 9.8},
    "gyro": {"x": 0.0, "y": 0.0, "z": 0.0},
    "temperature": 25.5
  }
}
```

### Binary Message Format
- **Format**: MessagePack or Protocol Buffers
- **Use Case**: High-frequency data, bandwidth optimization

## Implementation

### ESP-IDF MQTT Client
```c
#include "mqtt_client.h"

esp_mqtt_client_config_t mqtt_cfg = {
    .uri = "mqtt://broker.example.com",
    .port = 1883,
    .username = "device_user",
    .password = "device_password",
    .client_id = "tracker-001",
    .keepalive = 60,
};

esp_mqtt_client_handle_t client = esp_mqtt_client_init(&mqtt_cfg);
esp_mqtt_client_register_event(client, MQTT_EVENT_ANY, mqtt_event_handler, NULL);
esp_mqtt_client_start(client);
```

### Publishing Messages
```c
// Publish sensor data
char topic[64];
snprintf(topic, sizeof(topic), "nls/tracker/%s/sensors/data", device_id);

char payload[256];
snprintf(payload, sizeof(payload),
    "{\"timestamp\":%lld,\"accel\":{\"x\":%.2f,\"y\":%.2f,\"z\":%.2f}}",
    timestamp, accel_x, accel_y, accel_z);

esp_mqtt_client_publish(client, topic, payload, 0, 1, 0);
```

### Subscribing to Topics
```c
// Subscribe to control commands
char topic[64];
snprintf(topic, sizeof(topic), "nls/tracker/%s/control/commands", device_id);

esp_mqtt_client_subscribe(client, topic, 1);
```

### Event Handler
```c
static void mqtt_event_handler(void *handler_args, esp_event_base_t base,
                                int32_t event_id, void *event_data) {
    esp_mqtt_event_handle_t event = event_data;
    
    switch (event->event_id) {
        case MQTT_EVENT_CONNECTED:
            ESP_LOGI(TAG, "MQTT Connected");
            // Subscribe to topics
            break;
            
        case MQTT_EVENT_DISCONNECTED:
            ESP_LOGI(TAG, "MQTT Disconnected");
            break;
            
        case MQTT_EVENT_DATA:
            ESP_LOGI(TAG, "MQTT Data: %.*s", event->data_len, event->data);
            // Process received message
            handle_mqtt_message(event->topic, event->data, event->data_len);
            break;
            
        default:
            break;
    }
}
```

## QoS Levels

### QoS 0 - At Most Once
- **Delivery**: Best effort, no acknowledgment
- **Use Case**: Non-critical data, high-frequency updates
- **Example**: Sensor data streaming

### QoS 1 - At Least Once
- **Delivery**: Guaranteed at least once, may duplicate
- **Use Case**: Important data, commands
- **Example**: Configuration updates, commands

### QoS 2 - Exactly Once
- **Delivery**: Guaranteed exactly once
- **Use Case**: Critical data, transactions
- **Example**: Firmware updates, critical commands

## Security

### TLS/SSL
```c
esp_mqtt_client_config_t mqtt_cfg = {
    .uri = "mqtts://broker.example.com",
    .port = 8883,
    .transport = MQTT_TRANSPORT_OVER_SSL,
    .cert_pem = server_cert_pem,
};
```

### Authentication
- **Username/Password**: Basic authentication
- **Client Certificates**: Mutual TLS authentication
- **Token-based**: JWT or custom tokens

## Best Practices

### 1. Topic Design
- Use hierarchical topic structure
- Include device ID in topics
- Keep topics concise but descriptive

### 2. Message Size
- Keep messages small (< 1KB recommended)
- Use binary format for large data
- Batch multiple readings if needed

### 3. QoS Selection
- Use QoS 0 for high-frequency, non-critical data
- Use QoS 1 for commands and configuration
- Use QoS 2 sparingly (higher overhead)

### 4. Connection Management
- Implement automatic reconnection
- Handle network interruptions gracefully
- Use keep-alive to detect disconnections

### 5. Error Handling
- Handle connection failures
- Implement retry logic
- Log errors for debugging

## Related Documentation

- [WebSocket Protocol](./websocket.md) - WebSocket implementation
- [OSC Protocol](./osc.md) - Open Sound Control
- [Communication Manager](../firmware/core-components.md#3-communication-manager) - Component details

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
