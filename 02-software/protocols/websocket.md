# WebSocket Protocol

## Overview

WebSocket provides full-duplex communication between the tracker device and web applications, enabling real-time bidirectional data exchange for dashboards, control interfaces, and live data visualization.

## WebSocket Basics

### Protocol Characteristics
- **Full-Duplex**: Bidirectional communication
- **Low Latency**: Real-time data exchange
- **Text and Binary**: Support for both message types
- **Persistent Connection**: Long-lived connections
- **Standard Protocol**: RFC 6455

### Connection Parameters
- **Port**: 80 (HTTP), 443 (HTTPS/WSS)
- **Protocol**: WebSocket (ws://) or Secure WebSocket (wss://)
- **Handshake**: HTTP upgrade request

## Implementation

### ESP-IDF WebSocket Server
```c
#include "esp_http_server.h"
#include "esp_http_server.h"

httpd_handle_t start_websocket_server(void) {
    httpd_config_t config = HTTPD_DEFAULT_CONFIG();
    config.server_port = 80;
    
    httpd_handle_t server = NULL;
    if (httpd_start(&server, &config) == ESP_OK) {
        // Register WebSocket handler
        httpd_uri_t ws = {
            .uri = "/ws",
            .method = HTTP_GET,
            .handler = websocket_handler,
            .user_ctx = NULL,
            .is_websocket = true
        };
        httpd_register_uri_handler(server, &ws);
    }
    
    return server;
}
```

### WebSocket Handler
```c
static esp_err_t websocket_handler(httpd_req_t *req) {
    if (req->method == HTTP_GET) {
        // WebSocket handshake
        return ESP_OK;
    }
    
    // WebSocket frame handling
    uint8_t buf[128];
    int len = httpd_ws_recv_frame(req, buf, sizeof(buf));
    
    if (len > 0) {
        // Process received message
        handle_websocket_message(buf, len);
        
        // Send response
        httpd_ws_frame_t ws_pkt = {
            .payload = (uint8_t *)"OK",
            .len = 2,
            .type = HTTPD_WS_TYPE_TEXT
        };
        httpd_ws_send_frame(req, &ws_pkt);
    }
    
    return ESP_OK;
}
```

## Message Format

### Text Messages (JSON)
```json
{
  "type": "sensor_data",
  "timestamp": 1641234567890,
  "data": {
    "accel": {"x": 0.1, "y": 0.2, "z": 9.8},
    "gyro": {"x": 0.0, "y": 0.0, "z": 0.0}
  }
}
```

### Binary Messages
- **Format**: MessagePack, Protocol Buffers, or custom binary
- **Use Case**: High-frequency data, bandwidth optimization

## Client Implementation

### JavaScript Client
```javascript
const ws = new WebSocket('ws://tracker.local/ws');

ws.onopen = () => {
    console.log('WebSocket connected');
    // Subscribe to sensor data
    ws.send(JSON.stringify({
        type: 'subscribe',
        topic: 'sensors'
    }));
};

ws.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log('Received:', data);
    // Update UI with sensor data
};

ws.onerror = (error) => {
    console.error('WebSocket error:', error);
};

ws.onclose = () => {
    console.log('WebSocket closed');
    // Reconnect logic
};
```

## Use Cases

### 1. Real-Time Dashboard
- Live sensor data visualization
- Device status monitoring
- Control interface

### 2. Data Streaming
- High-frequency sensor data
- Real-time position tracking
- Audio/video streaming

### 3. Remote Control
- Device configuration
- Command execution
- Firmware updates

## Security

### WSS (WebSocket Secure)
```c
httpd_config_t config = HTTPD_DEFAULT_CONFIG();
config.server_port = 443;
config.transport_mode = HTTPD_SSL_TRANSPORT_STRICT;
config.cacert_pem = server_cert_pem;
config.cacert_len = server_cert_pem_len;
config.prvtkey_pem = server_key_pem;
config.prvtkey_len = server_key_pem_len;
```

### Authentication
- **Token-based**: JWT in WebSocket handshake
- **API Key**: Query parameter or header
- **Basic Auth**: HTTP authentication

## Best Practices

### 1. Connection Management
- Implement heartbeat/ping-pong
- Handle reconnection automatically
- Clean up on disconnect

### 2. Message Format
- Use JSON for text messages
- Use binary for high-frequency data
- Include message type in payload

### 3. Error Handling
- Handle connection failures
- Implement timeout handling
- Log errors for debugging

### 4. Performance
- Limit message size
- Batch multiple updates
- Use compression if needed

## Related Documentation

- [MQTT Protocol](./mqtt.md) - MQTT implementation
- [OSC Protocol](./osc.md) - Open Sound Control
- [REST API](../04-development/api/rest-api.md) - HTTP REST API

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
