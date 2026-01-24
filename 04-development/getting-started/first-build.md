# First Build

## Overview

This guide walks you through building your first project with the NLS tracker device.

## Prerequisites

- Development environment set up
- Device connected via USB
- Basic C/C++ knowledge

## Build Steps

### 1. Create Project
```bash
mkdir my-tracker-project
cd my-tracker-project
cp -r ../firmware/template/* .
```

### 2. Configure Project
```bash
idf.py menuconfig
```

### 3. Build
```bash
idf.py build
```

### 4. Flash
```bash
idf.py flash
```

### 5. Monitor
```bash
idf.py monitor
```

## Example Code

```c
#include "esp_log.h"

static const char *TAG = "my_project";

void app_main(void) {
    ESP_LOGI(TAG, "Hello from NLS Tracker!");
}
```

## Next Steps

- [API Documentation](../api/) - Learn the API
- [SDK Documentation](../sdks/) - Use SDKs

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
