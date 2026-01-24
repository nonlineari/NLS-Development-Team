# Software Setup

## Overview

This guide explains how to set up the software environment for the NLS tracker device.

## Prerequisites

- Hardware setup completed
- Computer with development tools
- Network connectivity

## Software Installation

### 1. Install ESP-IDF
```bash
# Clone ESP-IDF
git clone --recursive https://github.com/espressif/esp-idf.git
cd esp-idf

# Install
./install.sh

# Set up environment
. ./export.sh
```

### 2. Install Firmware
- Download latest firmware
- Flash to device via USB

### 3. Configure Device
- Access web interface
- Configure settings
- Test connectivity

## Next Steps

- [Development Environment](./development-environment.md) - Development setup
- [First Build](./first-build.md) - Build your first project

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
