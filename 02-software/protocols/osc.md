# OSC (Open Sound Control) Protocol

## Overview

OSC (Open Sound Control) is a protocol for communication among computers, sound synthesizers, and other multimedia devices. It is essential for integrating the NLS tracker device with TidalCycles, SuperCollider, and other live coding environments.

## OSC Basics

### Protocol Characteristics
- **UDP-based**: Fast, low-latency communication
- **Message-based**: Structured message format
- **Type System**: Strong typing (int32, float32, string, etc.)
- **Pattern Matching**: Address pattern matching
- **Bundle Support**: Multiple messages in one packet

### Connection Parameters
- **Port**: 57120 (default SuperCollider), configurable
- **Transport**: UDP (standard), TCP (optional)
- **Address Format**: `/path/to/address`

## Message Format

### OSC Address Pattern
```
/sensor/accel/x
/sensor/accel/y
/sensor/accel/z
/tracker/position/x
/tracker/position/y
/tracker/position/z
```

### OSC Message Structure
```
Address Pattern: /sensor/accel/x
Type Tag: f (float32)
Value: 0.123
```

### Bundle Format
```
#bundle
  timetag
  /sensor/accel/x f 0.123
  /sensor/accel/y f 0.456
  /sensor/accel/z f 9.8
```

## Implementation

### OSC Library (lo_osc)
```c
#include "lo/lo.h"

// Create OSC address
lo_address target = lo_address_new("192.168.1.100", "57120");

// Send OSC message
lo_send(target, "/sensor/accel/x", "f", accel_x);
lo_send(target, "/sensor/accel/y", "f", accel_y);
lo_send(target, "/sensor/accel/z", "f", accel_z);
```

### Sending Sensor Data
```c
void send_sensor_data_osc(sensor_data_t *data) {
    lo_address target = lo_address_new(osc_host, osc_port);
    
    // Send accelerometer data
    lo_send(target, "/sensor/accel/x", "f", data->accel_x);
    lo_send(target, "/sensor/accel/y", "f", data->accel_y);
    lo_send(target, "/sensor/accel/z", "f", data->accel_z);
    
    // Send gyroscope data
    lo_send(target, "/sensor/gyro/x", "f", data->gyro_x);
    lo_send(target, "/sensor/gyro/y", "f", data->gyro_y);
    lo_send(target, "/sensor/gyro/z", "f", data->gyro_z);
    
    lo_address_free(target);
}
```

### Sending Bundles
```c
void send_sensor_bundle_osc(sensor_data_t *data) {
    lo_address target = lo_address_new(osc_host, osc_port);
    lo_bundle bundle = lo_bundle_new(LO_TT_IMMEDIATE);
    
    // Add messages to bundle
    lo_message msg = lo_message_new();
    lo_message_add_float(msg, data->accel_x);
    lo_bundle_add_message(bundle, "/sensor/accel/x", msg);
    
    // Send bundle
    lo_send_bundle(target, bundle);
    
    lo_bundle_free(bundle);
    lo_address_free(target);
}
```

## OSC Server (Receiving)

### OSC Server Setup
```c
lo_server_thread server = lo_server_thread_new("57120", osc_error_handler);

// Register message handlers
lo_server_thread_add_method(server, "/control/start", "", control_start_handler, NULL);
lo_server_thread_add_method(server, "/control/stop", "", control_stop_handler, NULL);
lo_server_thread_add_method(server, "/config/sample_rate", "i", config_sample_rate_handler, NULL);

// Start server
lo_server_thread_start(server);
```

### Message Handlers
```c
int control_start_handler(const char *path, const char *types, 
                         lo_arg **argv, int argc, void *data, void *user_data) {
    ESP_LOGI(TAG, "Received start command");
    sensor_mgr_start();
    return 0;
}

int config_sample_rate_handler(const char *path, const char *types,
                              lo_arg **argv, int argc, void *data, void *user_data) {
    int sample_rate = argv[0]->i;
    ESP_LOGI(TAG, "Setting sample rate to %d", sample_rate);
    sensor_mgr_set_sample_rate(sample_rate);
    return 0;
}
```

## TidalCycles Integration

### TidalCycles OSC Setup
```haskell
-- In TidalCycles
d1 $ s "bd" # gain (cF 0.5 "accel_x")
```

### Sending Data to TidalCycles
```c
// Map sensor data to TidalCycles control values
void send_to_tidalcycles(sensor_data_t *data) {
    lo_address target = lo_address_new("127.0.0.1", "6010"); // TidalCycles default port
    
    // Send as control values (0.0 to 1.0 range)
    float accel_x_norm = normalize_accel(data->accel_x);
    lo_send(target, "/ctrl/accel_x", "f", accel_x_norm);
    
    lo_address_free(target);
}
```

### TidalCycles Address Patterns
```
/ctrl/accel_x    - Accelerometer X axis
/ctrl/accel_y    - Accelerometer Y axis
/ctrl/accel_z    - Accelerometer Z axis
/ctrl/gyro_x     - Gyroscope X axis
/ctrl/gyro_y     - Gyroscope Y axis
/ctrl/gyro_z     - Gyroscope Z axis
/ctrl/temperature - Temperature
```

## SuperCollider Integration

### SuperCollider OSC Setup
```supercollider
// In SuperCollider
OSCdef(\accel, { |msg|
    var accel_x = msg[1];
    // Use accel_x in synthesis
}, '/sensor/accel/x');
```

### Sending to SuperCollider
```c
void send_to_supercollider(sensor_data_t *data) {
    lo_address target = lo_address_new("127.0.0.1", "57120"); // SuperCollider default port
    
    lo_send(target, "/sensor/accel/x", "f", data->accel_x);
    lo_send(target, "/sensor/accel/y", "f", data->accel_y);
    lo_send(target, "/sensor/accel/z", "f", data->accel_z);
    
    lo_address_free(target);
}
```

## Message Types

### Type Tags
- **i**: int32
- **f**: float32
- **s**: string (null-terminated)
- **b**: blob (binary data)
- **h**: int64
- **d**: double (float64)
- **t**: timetag
- **T**: True
- **F**: False
- **N**: Nil
- **I**: Impulse

### Example Messages
```c
// Integer
lo_send(target, "/control/value", "i", 42);

// Float
lo_send(target, "/sensor/temperature", "f", 25.5);

// String
lo_send(target, "/device/name", "s", "tracker-001");

// Multiple values
lo_send(target, "/sensor/accel", "fff", accel_x, accel_y, accel_z);
```

## Best Practices

### 1. Address Naming
- Use hierarchical address patterns
- Be consistent with naming conventions
- Include device ID if multiple devices

### 2. Message Frequency
- Limit message rate to avoid network congestion
- Use bundles for multiple related values
- Consider data rate requirements

### 3. Type Safety
- Use appropriate types (float32 for sensor data)
- Validate received messages
- Handle type mismatches gracefully

### 4. Error Handling
- Handle network errors
- Implement timeout handling
- Log errors for debugging

## Related Documentation

- [TidalCycles Integration](../03-integration/nls-systems/tidalcycles.md) - TidalCycles integration guide
- [NLS Integration](../firmware/core-components.md#6-nls-integration) - NLS system integration
- [MQTT Protocol](./mqtt.md) - MQTT implementation

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
