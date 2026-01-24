# REST API

## Overview

REST API provides HTTP/HTTPS access to device functionality.

## Base URL

```
http://192.168.4.1/api/v1
https://device.local/api/v1
```

## Endpoints

### Device Status
```
GET /status
Response: {
  "device_id": "tracker-001",
  "status": "online",
  "uptime": 3600,
  "battery": {"voltage": 3.85, "percentage": 75}
}
```

### Sensor Data
```
GET /sensors
Response: {
  "accel": {"x": 0.1, "y": 0.2, "z": 9.8},
  "gyro": {"x": 0.0, "y": 0.0, "z": 0.0}
}
```

### Configuration
```
GET /config
POST /config
Body: {
  "sensors": {
    "imu": {"sample_rate": 100}
  }
}
```

## Authentication

- API key in header: `X-API-Key: your-key`
- Basic authentication
- Token-based authentication

## Related Documentation

- [WebSocket API](./websocket-api.md)
- [API Overview](./overview.md)

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
