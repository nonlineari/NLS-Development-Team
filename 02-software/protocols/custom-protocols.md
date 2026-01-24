# Custom Protocols

## Overview

This document describes custom communication protocols used by the NLS tracker device for specialized use cases, including NLS-specific protocols and optimized binary formats.

## NLS Binary Protocol

### Overview
A compact binary protocol for high-frequency sensor data transmission in NLS systems.

### Protocol Format
```
[Header][Data Payload][Checksum]
```

### Header Structure
```c
typedef struct {
    uint8_t magic;          // 0x4E ('N')
    uint8_t version;        // Protocol version
    uint8_t type;           // Message type
    uint16_t length;        // Payload length
    uint32_t timestamp;     // Timestamp (ms)
    uint16_t device_id;     // Device identifier
} nls_protocol_header_t;
```

### Message Types
```c
#define NLS_MSG_SENSOR_DATA   0x01
#define NLS_MSG_STATUS        0x02
#define NLS_MSG_COMMAND       0x03
#define NLS_MSG_CONFIG        0x04
```

### Sensor Data Payload
```c
typedef struct {
    float accel[3];         // Accelerometer (x, y, z)
    float gyro[3];          // Gyroscope (x, y, z)
    float mag[3];           // Magnetometer (x, y, z)
    float temperature;      // Temperature
    uint32_t sequence;      // Sequence number
} nls_sensor_data_t;
```

### Implementation
```c
void send_nls_binary(sensor_data_t *data) {
    nls_protocol_header_t header = {
        .magic = 0x4E,
        .version = 1,
        .type = NLS_MSG_SENSOR_DATA,
        .length = sizeof(nls_sensor_data_t),
        .timestamp = esp_timer_get_time() / 1000,
        .device_id = get_device_id()
    };
    
    nls_sensor_data_t payload = {
        .accel = {data->accel_x, data->accel_y, data->accel_z},
        .gyro = {data->gyro_x, data->gyro_y, data->gyro_z},
        .mag = {data->mag_x, data->mag_y, data->mag_z},
        .temperature = data->temperature,
        .sequence = get_sequence_number()
    };
    
    // Calculate checksum
    uint16_t checksum = calculate_checksum(&header, &payload);
    
    // Send via UDP
    send_udp_packet(&header, sizeof(header));
    send_udp_packet(&payload, sizeof(payload));
    send_udp_packet(&checksum, sizeof(checksum));
}
```

## Hyperfone P2P Protocol

### Overview
Protocol for peer-to-peer audio streaming in the Hyperfone system.

### Connection Establishment
```
1. Device A sends connection request to Device B
2. Device B responds with acceptance
3. Both devices exchange audio format information
4. Audio streaming begins
```

### Audio Packet Format
```c
typedef struct {
    uint32_t sequence;      // Packet sequence number
    uint32_t timestamp;     // Audio timestamp
    uint16_t sample_rate;  // Sample rate (Hz)
    uint16_t channels;     // Number of channels
    uint16_t samples;      // Number of samples
    uint8_t format;        // Audio format (PCM, Opus, etc.)
    uint8_t data[];        // Audio data
} hyperfone_audio_packet_t;
```

### Implementation
```c
void send_hyperfone_audio(audio_buffer_t *buffer) {
    hyperfone_audio_packet_t packet = {
        .sequence = get_audio_sequence(),
        .timestamp = get_audio_timestamp(),
        .sample_rate = 48000,
        .channels = 2,
        .samples = buffer->sample_count,
        .format = AUDIO_FORMAT_PCM_16BIT
    };
    
    // Copy audio data
    memcpy(packet.data, buffer->data, buffer->size);
    
    // Send to peer
    send_to_peer(peer_address, &packet, sizeof(packet) + buffer->size);
}
```

## Pulsar Agent Protocol

### Overview
Protocol for communication with the Pulsar Agent in the NLS interpretative grid system.

### Message Format
```c
typedef struct {
    uint8_t command;        // Command type
    uint16_t grid_x;        // Grid X coordinate
    uint16_t grid_y;        // Grid Y coordinate
    float value;            // Value to set
    uint32_t timestamp;     // Timestamp
} pulsar_agent_message_t;
```

### Commands
```c
#define PULSAR_CMD_SET_VALUE    0x01
#define PULSAR_CMD_GET_VALUE    0x02
#define PULSAR_CMD_RESET        0x03
#define PULSAR_CMD_SYNC         0x04
```

### Implementation
```c
void send_pulsar_command(uint8_t cmd, uint16_t x, uint16_t y, float value) {
    pulsar_agent_message_t msg = {
        .command = cmd,
        .grid_x = x,
        .grid_y = y,
        .value = value,
        .timestamp = esp_timer_get_time() / 1000
    };
    
    send_to_pulsar_agent(&msg, sizeof(msg));
}
```

## Polish Notation Protocol

### Overview
Protocol for transmitting Polish notation expressions for the NLS conceptual framework.

### Expression Format
```
Operator Operand1 Operand2 ...
```

### Binary Encoding
```c
typedef struct {
    uint8_t type;           // Token type (operator, operand)
    union {
        uint8_t op;         // Operator code
        float value;        // Operand value
        char symbol[16];     // Symbol name
    };
} polish_token_t;
```

### Implementation
```c
void send_polish_expression(const char *expression) {
    // Parse expression
    polish_token_t *tokens = parse_polish(expression);
    size_t token_count = count_tokens(tokens);
    
    // Send tokens
    for (size_t i = 0; i < token_count; i++) {
        send_token(&tokens[i]);
    }
}
```

## Tree Traversal Protocol

### Overview
Protocol for transmitting tree structures used in NLS conceptual framework.

### Tree Node Format
```c
typedef struct {
    uint8_t node_type;      // Node type
    uint16_t children_count; // Number of children
    uint32_t data_size;     // Data size
    uint8_t data[];         // Node data
} tree_node_t;
```

### Traversal Methods
- **Pre-order**: Root, Left, Right
- **In-order**: Left, Root, Right
- **Post-order**: Left, Right, Root

### Implementation
```c
void send_tree_preorder(tree_node_t *root) {
    if (root == NULL) return;
    
    // Send node
    send_node(root);
    
    // Send children
    for (int i = 0; i < root->children_count; i++) {
        send_tree_preorder(root->children[i]);
    }
}
```

## Compression Protocols

### Overview
Protocols for compressing sensor data to reduce bandwidth.

### Delta Encoding
```c
void send_delta_encoded(sensor_data_t *current, sensor_data_t *previous) {
    float delta_x = current->accel_x - previous->accel_x;
    float delta_y = current->accel_y - previous->accel_y;
    float delta_z = current->accel_z - previous->accel_z;
    
    // Send only deltas (smaller values, better compression)
    send_compressed_data(delta_x, delta_y, delta_z);
}
```

### Quantization
```c
void send_quantized(float value, float min, float max, uint8_t bits) {
    float range = max - min;
    uint16_t quantized = (uint16_t)((value - min) / range * ((1 << bits) - 1));
    send_uint16(quantized);
}
```

## Related Documentation

- [NLS Integration](../03-integration/nls-systems/) - NLS system integration
- [Data Formats](../data-formats/) - Data format specifications
- [Communication Manager](../firmware/core-components.md#3-communication-manager) - Component details

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
