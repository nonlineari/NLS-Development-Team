# WebSocket API

## Overview

WebSocket API provides real-time bidirectional communication.

## Connection

```
ws://192.168.4.1/ws
wss://device.local/ws
```

## Message Format

### Text Messages (JSON)
```json
{
  "type": "sensor_data",
  "data": {
    "accel": {"x": 0.1, "y": 0.2, "z": 9.8}
  }
}
```

### Binary Messages
- MessagePack format
- Protocol Buffers format

## Message Types

- `sensor_data` - Sensor readings
- `status` - Device status
- `command` - Control commands
- `config` - Configuration updates

## Related Documentation

- [REST API](./rest-api.md)
- [WebSocket Protocol](../../02-software/protocols/websocket.md)

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
