# MessagePack

## Overview

MessagePack is a binary serialization format that is more compact than JSON, making it ideal for high-frequency sensor data transmission and bandwidth-constrained applications.

## MessagePack Basics

### Characteristics
- **Binary Format**: More compact than JSON
- **Type System**: Supports various data types
- **Cross-Language**: Libraries available for many languages
- **Fast**: Efficient encoding/decoding

### Supported Types
- **Integer**: int8, int16, int32, int64, uint8, uint16, uint32, uint64
- **Float**: float32, float64
- **String**: UTF-8 strings
- **Binary**: Raw bytes
- **Array**: Ordered collections
- **Map**: Key-value pairs
- **Boolean**: true, false
- **Nil**: null value

## Implementation

### C/C++ (ESP-IDF)
```c
#include "msgpack.h"

// Encode sensor data
void encode_sensor_data(sensor_data_t *data, uint8_t *buffer, size_t *len) {
    msgpack_sbuffer sbuf;
    msgpack_sbuffer_init(&sbuf);
    
    msgpack_packer pk;
    msgpack_packer_init(&pk, &sbuf, msgpack_sbuffer_write);
    
    // Pack as map
    msgpack_pack_map(&pk, 4);
    
    // Pack timestamp
    msgpack_pack_str(&pk, 9);
    msgpack_pack_str_body(&pk, "timestamp", 9);
    msgpack_pack_uint64(&pk, data->timestamp);
    
    // Pack accelerometer
    msgpack_pack_str(&pk, 5);
    msgpack_pack_str_body(&pk, "accel", 5);
    msgpack_pack_array(&pk, 3);
    msgpack_pack_float(&pk, data->accel_x);
    msgpack_pack_float(&pk, data->accel_y);
    msgpack_pack_float(&pk, data->accel_z);
    
    // Copy to buffer
    memcpy(buffer, sbuf.data, sbuf.size);
    *len = sbuf.size;
    
    msgpack_sbuffer_destroy(&sbuf);
}
```

### Python
```python
import msgpack

# Encode sensor data
data = {
    'timestamp': 1641234567890,
    'accel': [0.1, 0.2, 9.8],
    'gyro': [0.0, 0.0, 0.0]
}

packed = msgpack.packb(data)
print(f"Size: {len(packed)} bytes")

# Decode
unpacked = msgpack.unpackb(packed)
print(unpacked)
```

### JavaScript
```javascript
const msgpack = require('msgpack-lite');

// Encode sensor data
const data = {
    timestamp: 1641234567890,
    accel: [0.1, 0.2, 9.8],
    gyro: [0.0, 0.0, 0.0]
};

const packed = msgpack.encode(data);
console.log(`Size: ${packed.length} bytes`);

// Decode
const unpacked = msgpack.decode(packed);
console.log(unpacked);
```

## Comparison with JSON

### Size Comparison
```json
// JSON (78 bytes)
{"timestamp":1641234567890,"accel":{"x":0.1,"y":0.2,"z":9.8}}

// MessagePack (approximately 35 bytes)
// Binary format, more compact
```

### Performance
- **Encoding**: MessagePack is typically 2-3x faster than JSON
- **Decoding**: MessagePack is typically 2-3x faster than JSON
- **Size**: MessagePack is typically 30-50% smaller than JSON

## Use Cases

### 1. High-Frequency Sensor Data
```c
// Send IMU data at 100Hz using MessagePack
void send_imu_data_mp(sensor_data_t *data) {
    uint8_t buffer[128];
    size_t len;
    
    encode_sensor_data(data, buffer, &len);
    mqtt_publish("nls/tracker/sensors/data", buffer, len, 0);
}
```

### 2. MQTT Binary Payload
```c
// Use MessagePack for MQTT binary payloads
esp_mqtt_client_publish(client, topic, (char *)buffer, len, 0, 0);
```

### 3. WebSocket Binary Messages
```javascript
// Send MessagePack via WebSocket
const ws = new WebSocket('ws://tracker.local/ws');
ws.binaryType = 'arraybuffer';

const data = {timestamp: Date.now(), accel: [0.1, 0.2, 9.8]};
const packed = msgpack.encode(data);
ws.send(packed);
```

## Best Practices

### 1. Type Selection
- Use appropriate integer types (int8 vs int32)
- Use float32 for sensor data (sufficient precision)
- Use binary for raw data

### 2. Structure Design
- Prefer maps over arrays for named fields
- Use arrays for homogeneous data
- Minimize nesting depth

### 3. Compression
- MessagePack is already compact
- Additional compression (gzip) may not be beneficial
- Consider for very large payloads

## Related Documentation

- [JSON Schemas](./json-schemas.md) - JSON format specifications
- [Protocol Buffers](./protobuf.md) - Alternative binary format
- [MQTT Protocol](../protocols/mqtt.md) - MQTT binary payloads

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
