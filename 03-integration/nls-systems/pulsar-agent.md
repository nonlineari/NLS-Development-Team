# Pulsar Agent Integration

## Overview

Pulsar Agent is part of the NLS interpretative grid system, providing grid-based pattern generation and manipulation.

## Pulsar Agent Architecture

### Grid System
- **Grid Dimensions**: Configurable (e.g., 16x16, 32x32)
- **Cell Values**: Float values (0.0 to 1.0)
- **Update Rate**: Configurable frequency

## Implementation

### Setting Grid Values
```c
void pulsar_set_value(uint16_t x, uint16_t y, float value) {
    pulsar_agent_message_t msg = {
        .command = PULSAR_CMD_SET_VALUE,
        .grid_x = x,
        .grid_y = y,
        .value = value,
        .timestamp = esp_timer_get_time() / 1000
    };
    
    send_to_pulsar_agent(&msg, sizeof(msg));
}
```

### Mapping Sensor Data to Grid
```c
void map_sensor_to_grid(sensor_data_t *data) {
    // Map accelerometer to grid position
    uint16_t grid_x = map_value(data->accel_x, -2.0, 2.0, 0, 15);
    uint16_t grid_y = map_value(data->accel_y, -2.0, 2.0, 0, 15);
    float value = normalize_value(data->accel_z, -2.0, 2.0);
    
    pulsar_set_value(grid_x, grid_y, value);
}
```

## Related Documentation

- [Custom Protocols](../02-software/protocols/custom-protocols.md) - Pulsar protocol
- [Conceptual Framework](./conceptual-framework.md) - Grid concepts

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
