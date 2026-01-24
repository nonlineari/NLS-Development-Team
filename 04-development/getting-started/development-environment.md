# Development Environment

## Overview

This guide explains how to set up a development environment for the NLS tracker device.

## Required Tools

### 1. ESP-IDF
- **Version**: v5.0 or later
- **Installation**: See [ESP-IDF Setup Guide](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/)

### 2. Python
- **Version**: 3.8 or later
- **Required Packages**: See requirements.txt

### 3. Code Editor
- **VS Code** with ESP-IDF extension (recommended)
- **PlatformIO** (alternative)

## Setup Steps

### 1. Install ESP-IDF
```bash
git clone --recursive https://github.com/espressif/esp-idf.git
cd esp-idf
./install.sh
. ./export.sh
```

### 2. Clone Repository
```bash
git clone https://github.com/nonlineari/toplap-nls.git
cd toplap-nls/firmware
```

### 3. Configure Project
```bash
idf.py menuconfig
```

### 4. Build Project
```bash
idf.py build
```

### 5. Flash Device
```bash
idf.py flash
```

### 6. Monitor Output
```bash
idf.py monitor
```

## Next Steps

- [First Build](./first-build.md) - Build your first project
- [API Documentation](../api/) - API reference

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
