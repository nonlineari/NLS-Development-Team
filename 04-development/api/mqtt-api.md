# MQTT API

## Overview

MQTT API provides publish-subscribe messaging.

## Topics

### Sensor Data
```
nls/tracker/{device_id}/sensors/data
```

### Device Status
```
nls/tracker/{device_id}/status
```

### Commands
```
nls/tracker/{device_id}/control/commands
```

## Message Format

JSON or MessagePack format.

## Related Documentation

- [MQTT Protocol](../../02-software/protocols/mqtt.md)
- [REST API](./rest-api.md)

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
