# Ableton Live Integration

## Overview

This guide explains how to integrate the NLS tracker device with Ableton Live for real-time music production and performance.

## Integration Methods

### 1. OSC Integration
- **Port**: 9000 (default Ableton Live OSC port)
- **Protocol**: UDP
- **Format**: OSC messages

### 2. MIDI Integration
- **Protocol**: MIDI over USB or network
- **Messages**: CC (Control Change), Note messages

## OSC Implementation

### Sending Sensor Data
```c
void send_to_ableton(sensor_data_t *data) {
    lo_address target = lo_address_new("127.0.0.1", "9000");
    
    // Send as control values
    lo_send(target, "/tracker/accel/x", "f", data->accel_x);
    lo_send(target, "/tracker/accel/y", "f", data->accel_y);
    lo_send(target, "/tracker/accel/z", "data->accel_z);
    
    lo_address_free(target);
}
```

## Ableton Live Setup

### Max for Live Device
Create a Max for Live device to receive OSC messages and map to Ableton parameters.

### MIDI Mapping
Map sensor values to MIDI CC messages for control.

## Related Documentation

- [OSC Protocol](../02-software/protocols/osc.md) - OSC implementation

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
