# TidalCycles Integration

## Overview

This guide explains how to integrate the NLS tracker device with TidalCycles, a live coding environment for creating patterns with code.

## TidalCycles Setup

### Installation
```bash
# Install TidalCycles
cabal update
cabal install tidal

# Or use stack
stack install tidal
```

### SuperDirt Setup
TidalCycles requires SuperDirt (SuperCollider) for audio output.

## OSC Communication

### TidalCycles OSC Port
- **Default Port**: 6010
- **Protocol**: UDP
- **Format**: OSC messages

### Sending Sensor Data to TidalCycles
```c
// Send accelerometer data as control values
void send_to_tidalcycles(sensor_data_t *data) {
    lo_address target = lo_address_new("127.0.0.1", "6010");
    
    // Normalize values to 0.0-1.0 range
    float accel_x_norm = normalize_to_range(data->accel_x, -2.0, 2.0, 0.0, 1.0);
    float accel_y_norm = normalize_to_range(data->accel_y, -2.0, 2.0, 0.0, 1.0);
    float accel_z_norm = normalize_to_range(data->accel_z, -2.0, 2.0, 0.0, 1.0);
    
    // Send as control values
    lo_send(target, "/ctrl/accel_x", "f", accel_x_norm);
    lo_send(target, "/ctrl/accel_y", "f", accel_y_norm);
    lo_send(target, "/ctrl/accel_z", "f", accel_z_norm);
    
    lo_address_free(target);
}
```

## TidalCycles Patterns

### Basic Pattern
```haskell
-- Use accelerometer X axis to control gain
d1 $ s "bd" # gain (cF 0.5 "accel_x")
```

### Multiple Controls
```haskell
-- Use multiple sensor values
d1 $ s "bd*4" 
  # gain (cF 0.5 "accel_x")
  # speed (cF 1 "accel_y")
  # pan (cF 0 "accel_z")
```

### Pattern Transformation
```haskell
-- Transform pattern based on sensor data
d1 $ s "bd*4" 
  # gain (cF 0.5 "accel_x")
  # whenmod (cI 4 "gyro_z") 8 (rev)
```

## Control Mapping

### Accelerometer Mapping
- **X-axis**: Left-right movement → Pan, Speed
- **Y-axis**: Forward-backward → Gain, Filter
- **Z-axis**: Up-down → Reverb, Delay

### Gyroscope Mapping
- **X-axis**: Roll → Pattern rotation
- **Y-axis**: Pitch → Transposition
- **Z-axis**: Yaw → Time manipulation

## Related Documentation

- [OSC Protocol](../02-software/protocols/osc.md) - OSC implementation
- [Hyperfone Integration](./hyperfone.md) - P2P audio integration

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
