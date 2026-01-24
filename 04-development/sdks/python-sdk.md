# Python SDK

## Overview

Python SDK for interacting with NLS tracker devices.

## Installation

```bash
pip install nls-tracker-sdk
```

## Usage

```python
from nls_tracker import Tracker

# Connect to device
tracker = Tracker("192.168.4.1")

# Get sensor data
data = tracker.get_sensor_data()
print(data)

# Subscribe to sensor updates
def on_sensor_data(data):
    print(f"Accel: {data['accel']}")

tracker.subscribe_sensors(on_sensor_data)
```

## API Reference

See SDK documentation for complete API reference.

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
