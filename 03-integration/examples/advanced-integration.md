# Advanced Integration Example

## Overview

This guide provides examples for advanced integration scenarios with multiple systems.

## Multi-System Integration

### TidalCycles + VDMX
```c
// Send to both TidalCycles and VDMX
void send_multi_system(sensor_data_t *data) {
    send_to_tidalcycles(data);
    send_to_vdmx(data);
}
```

## Related Documentation

- [TidalCycles Integration](../nls-systems/tidalcycles.md)
- [VDMX Integration](../external/vdmx.md)

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
