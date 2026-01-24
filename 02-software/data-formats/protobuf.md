# Protocol Buffers

## Overview

Protocol Buffers (protobuf) is a language-neutral, platform-neutral serialization format developed by Google. It provides structured data serialization with schema evolution support.

## Protocol Buffers Basics

### Characteristics
- **Schema-Based**: Define data structures in .proto files
- **Language-Neutral**: Code generation for multiple languages
- **Efficient**: Compact binary format
- **Backward Compatible**: Schema evolution support
- **Type-Safe**: Strong typing

## Schema Definition

### Sensor Data Proto
```protobuf
syntax = "proto3";

package nls.tracker;

message SensorData {
    int64 timestamp = 1;
    string device_id = 2;
    
    message Accelerometer {
        float x = 1;
        float y = 2;
        float z = 3;
    }
    
    message Gyroscope {
        float x = 1;
        float y = 2;
        float z = 3;
    }
    
    Accelerometer accel = 3;
    Gyroscope gyro = 4;
    float temperature = 5;
}
```

### Device Status Proto
```protobuf
syntax = "proto3";

package nls.tracker;

message DeviceStatus {
    int64 timestamp = 1;
    string device_id = 2;
    
    message Battery {
        float voltage = 1;
        int32 percentage = 2;
        bool charging = 3;
    }
    
    message Connectivity {
        bool wifi = 1;
        bool bluetooth = 2;
        bool mqtt = 3;
    }
    
    Battery battery = 3;
    Connectivity connectivity = 4;
}
```

## Implementation

### C/C++ (ESP-IDF)
```c
#include "sensor_data.pb.h"
#include "pb_encode.h"
#include "pb_decode.h"

// Encode sensor data
void encode_sensor_data(sensor_data_t *data, uint8_t *buffer, size_t *len) {
    SensorData msg = SensorData_init_zero;
    
    msg.timestamp = data->timestamp;
    strcpy(msg.device_id, data->device_id);
    
    msg.accel.x = data->accel_x;
    msg.accel.y = data->accel_y;
    msg.accel.z = data->accel_z;
    
    msg.gyro.x = data->gyro_x;
    msg.gyro.y = data->gyro_y;
    msg.gyro.z = data->gyro_z;
    
    msg.temperature = data->temperature;
    
    pb_ostream_t stream = pb_ostream_from_buffer(buffer, *len);
    if (!pb_encode(&stream, SensorData_fields, &msg)) {
        ESP_LOGE(TAG, "Encoding failed");
        return;
    }
    
    *len = stream.bytes_written;
}

// Decode sensor data
void decode_sensor_data(uint8_t *buffer, size_t len, sensor_data_t *data) {
    SensorData msg = SensorData_init_zero;
    
    pb_istream_t stream = pb_istream_from_buffer(buffer, len);
    if (!pb_decode(&stream, SensorData_fields, &msg)) {
        ESP_LOGE(TAG, "Decoding failed");
        return;
    }
    
    data->timestamp = msg.timestamp;
    strcpy(data->device_id, msg.device_id);
    data->accel_x = msg.accel.x;
    data->accel_y = msg.accel.y;
    data->accel_z = msg.accel.z;
    data->gyro_x = msg.gyro.x;
    data->gyro_y = msg.gyro.y;
    data->gyro_z = msg.gyro.z;
    data->temperature = msg.temperature;
}
```

### Python
```python
import sensor_data_pb2

# Encode sensor data
data = sensor_data_pb2.SensorData()
data.timestamp = 1641234567890
data.device_id = "tracker-001"
data.accel.x = 0.1
data.accel.y = 0.2
data.accel.z = 9.8
data.gyro.x = 0.0
data.gyro.y = 0.0
data.gyro.z = 0.0
data.temperature = 25.5

packed = data.SerializeToString()
print(f"Size: {len(packed)} bytes")

# Decode
decoded = sensor_data_pb2.SensorData()
decoded.ParseFromString(packed)
print(decoded)
```

### JavaScript
```javascript
const protobuf = require('protobufjs');

// Load schema
const root = protobuf.loadSync('sensor_data.proto');
const SensorData = root.lookupType('nls.tracker.SensorData');

// Encode
const data = {
    timestamp: 1641234567890,
    deviceId: 'tracker-001',
    accel: {x: 0.1, y: 0.2, z: 9.8},
    gyro: {x: 0.0, y: 0.0, z: 0.0},
    temperature: 25.5
};

const errMsg = SensorData.verify(data);
if (errMsg) throw Error(errMsg);

const buffer = SensorData.encode(data).finish();
console.log(`Size: ${buffer.length} bytes`);

// Decode
const decoded = SensorData.decode(buffer);
console.log(decoded);
```

## Code Generation

### Generate C Code
```bash
# Install nanopb (protobuf for embedded systems)
git clone https://github.com/nanopb/nanopb.git

# Generate C code
python nanopb/generator/nanopb_generator.py sensor_data.proto
```

### Generate Python Code
```bash
# Install protoc compiler
pip install protobuf

# Generate Python code
protoc --python_out=. sensor_data.proto
```

### Generate JavaScript Code
```bash
# Install protobufjs
npm install protobufjs

# Generate JavaScript code
pbjs -t static-module -w commonjs -o sensor_data.js sensor_data.proto
```

## Schema Evolution

### Backward Compatibility
- **Add New Fields**: Use new field numbers, mark as optional
- **Remove Fields**: Deprecate, don't reuse field numbers
- **Change Types**: Not recommended (breaks compatibility)

### Example Evolution
```protobuf
// Version 1
message SensorData {
    int64 timestamp = 1;
    float temperature = 2;
}

// Version 2 (backward compatible)
message SensorData {
    int64 timestamp = 1;
    float temperature = 2;
    float humidity = 3;  // New field, optional
}
```

## Comparison

### vs JSON
- **Size**: Protobuf is 30-50% smaller
- **Performance**: Protobuf is 2-3x faster
- **Schema**: Protobuf requires schema, JSON is schema-less
- **Human-Readable**: JSON is readable, Protobuf is binary

### vs MessagePack
- **Schema**: Protobuf has schema, MessagePack is schema-less
- **Evolution**: Protobuf supports schema evolution
- **Size**: Similar sizes
- **Performance**: Similar performance

## Best Practices

### 1. Field Numbering
- Use field numbers 1-15 for frequently used fields (1 byte)
- Use field numbers 16-2047 for less frequent fields (2 bytes)
- Don't reuse field numbers

### 2. Optional vs Required
- Use optional for new fields (backward compatibility)
- Mark deprecated fields as optional

### 3. Naming
- Use camelCase for field names
- Use descriptive names
- Follow language conventions

## Related Documentation

- [JSON Schemas](./json-schemas.md) - JSON format specifications
- [MessagePack](./messagepack.md) - Binary serialization format
- [Data Formats Overview](../firmware/core-components.md#4-data-storage) - Storage formats

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
