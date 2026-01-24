# VDMX Integration

## Overview

This guide explains how to integrate the NLS tracker device with VDMX for real-time video manipulation and visual performance.

## VDMX Setup

### OSC Integration
- **Port**: 7000 (default VDMX OSC port)
- **Protocol**: UDP
- **Format**: OSC messages

## Implementation

### Sending Position Data
```c
void send_to_vdmx(tracker_position_t *pos) {
    lo_address target = lo_address_new("127.0.0.1", "7000");
    
    // Send position for video manipulation
    lo_send(target, "/tracker/position/x", "f", pos->x);
    lo_send(target, "/tracker/position/y", "f", pos->y);
    lo_send(target, "/tracker/position/z", "f", pos->z);
    
    lo_address_free(target);
}
```

## VDMX Configuration

### OSC Mapping
Map tracker OSC messages to VDMX parameters for video effects.

## Related Documentation

- [OSC Protocol](../02-software/protocols/osc.md) - OSC implementation

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
