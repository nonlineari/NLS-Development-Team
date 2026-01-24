# JSON Schemas

## Overview

This document defines JSON schemas for all data formats used in the NLS tracker device, including sensor data, device configuration, status messages, and control commands.

## Sensor Data Schema

### IMU Data
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "timestamp": {
      "type": "integer",
      "description": "Unix timestamp in milliseconds"
    },
    "device_id": {
      "type": "string",
      "description": "Device identifier"
    },
    "accel": {
      "type": "object",
      "properties": {
        "x": {"type": "number"},
        "y": {"type": "number"},
        "z": {"type": "number"}
      },
      "required": ["x", "y", "z"]
    },
    "gyro": {
      "type": "object",
      "properties": {
        "x": {"type": "number"},
        "y": {"type": "number"},
        "z": {"type": "number"}
      },
      "required": ["x", "y", "z"]
    },
    "mag": {
      "type": "object",
      "properties": {
        "x": {"type": "number"},
        "y": {"type": "number"},
        "z": {"type": "number"}
      },
      "required": ["x", "y", "z"]
    }
  },
  "required": ["timestamp", "device_id", "accel", "gyro"]
}
```

### Example
```json
{
  "timestamp": 1641234567890,
  "device_id": "tracker-001",
  "accel": {"x": 0.1, "y": 0.2, "z": 9.8},
  "gyro": {"x": 0.0, "y": 0.0, "z": 0.0},
  "mag": {"x": 25.5, "y": -10.2, "z": 45.8}
}
```

## Device Configuration Schema

### Device Configuration
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "device": {
      "type": "object",
      "properties": {
        "id": {"type": "string"},
        "name": {"type": "string"},
        "version": {"type": "string"}
      },
      "required": ["id", "name"]
    },
    "wifi": {
      "type": "object",
      "properties": {
        "ssid": {"type": "string"},
        "password": {"type": "string"},
        "mode": {
          "type": "string",
          "enum": ["sta", "ap", "apsta"]
        }
      },
      "required": ["ssid"]
    },
    "sensors": {
      "type": "object",
      "properties": {
        "imu": {
          "type": "object",
          "properties": {
            "enabled": {"type": "boolean"},
            "sample_rate": {"type": "integer", "minimum": 1, "maximum": 1000}
          }
        },
        "gps": {
          "type": "object",
          "properties": {
            "enabled": {"type": "boolean"}
          }
        }
      }
    }
  },
  "required": ["device"]
}
```

### Example
```json
{
  "device": {
    "id": "tracker-001",
    "name": "NLS Tracker 1",
    "version": "1.0.0"
  },
  "wifi": {
    "ssid": "network",
    "password": "password",
    "mode": "sta"
  },
  "sensors": {
    "imu": {
      "enabled": true,
      "sample_rate": 100
    },
    "gps": {
      "enabled": false
    }
  }
}
```

## Status Message Schema

### Device Status
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "timestamp": {"type": "integer"},
    "device_id": {"type": "string"},
    "status": {
      "type": "object",
      "properties": {
        "battery": {
          "type": "object",
          "properties": {
            "voltage": {"type": "number"},
            "percentage": {"type": "integer", "minimum": 0, "maximum": 100},
            "charging": {"type": "boolean"}
          }
        },
        "connectivity": {
          "type": "object",
          "properties": {
            "wifi": {"type": "boolean"},
            "bluetooth": {"type": "boolean"},
            "mqtt": {"type": "boolean"}
          }
        },
        "health": {
          "type": "object",
          "properties": {
            "uptime": {"type": "integer"},
            "free_heap": {"type": "integer"},
            "temperature": {"type": "number"}
          }
        }
      }
    }
  },
  "required": ["timestamp", "device_id", "status"]
}
```

### Example
```json
{
  "timestamp": 1641234567890,
  "device_id": "tracker-001",
  "status": {
    "battery": {
      "voltage": 3.85,
      "percentage": 75,
      "charging": false
    },
    "connectivity": {
      "wifi": true,
      "bluetooth": true,
      "mqtt": true
    },
    "health": {
      "uptime": 3600,
      "free_heap": 50000,
      "temperature": 35.5
    }
  }
}
```

## Command Schema

### Control Command
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "command": {
      "type": "string",
      "enum": ["start", "stop", "reset", "config", "ota"]
    },
    "parameters": {
      "type": "object",
      "additionalProperties": true
    }
  },
  "required": ["command"]
}
```

### Example
```json
{
  "command": "config",
  "parameters": {
    "sensors": {
      "imu": {
        "sample_rate": 200
      }
    }
  }
}
```

## Validation

### JSON Schema Validation (Python)
```python
import jsonschema

schema = {
    "type": "object",
    "properties": {
        "timestamp": {"type": "integer"},
        "device_id": {"type": "string"}
    },
    "required": ["timestamp", "device_id"]
}

data = {
    "timestamp": 1641234567890,
    "device_id": "tracker-001"
}

try:
    jsonschema.validate(instance=data, schema=schema)
    print("Valid JSON")
except jsonschema.exceptions.ValidationError as e:
    print(f"Validation error: {e}")
```

### JSON Schema Validation (JavaScript)
```javascript
const Ajv = require('ajv');
const ajv = new Ajv();

const schema = {
    type: 'object',
    properties: {
        timestamp: {type: 'integer'},
        device_id: {type: 'string'}
    },
    required: ['timestamp', 'device_id']
};

const validate = ajv.compile(schema);
const data = {
    timestamp: 1641234567890,
    device_id: 'tracker-001'
};

if (validate(data)) {
    console.log('Valid JSON');
} else {
    console.log('Validation errors:', validate.errors);
}
```

## Related Documentation

- [MessagePack](./messagepack.md) - Binary serialization format
- [Protocol Buffers](./protobuf.md) - Structured data format
- [MQTT Protocol](../protocols/mqtt.md) - MQTT message format

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
