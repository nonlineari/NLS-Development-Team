# JavaScript SDK

## Overview

JavaScript/Node.js SDK for NLS tracker devices.

## Installation

```bash
npm install nls-tracker-sdk
```

## Usage

```javascript
const Tracker = require('nls-tracker-sdk');

// Connect to device
const tracker = new Tracker('192.168.4.1');

// Get sensor data
tracker.getSensorData().then(data => {
    console.log(data);
});

// Subscribe to updates
tracker.subscribeSensors(data => {
    console.log('Accel:', data.accel);
});
```

## Browser Usage

```html
<script src="nls-tracker-sdk.js"></script>
<script>
    const tracker = new NLSTracker('ws://device.local/ws');
    tracker.onSensorData(data => {
        console.log(data);
    });
</script>
```

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
