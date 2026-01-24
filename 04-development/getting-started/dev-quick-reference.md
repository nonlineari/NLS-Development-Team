# Developer Quick Reference

## Quick Setup Checklist

### Initial Device Setup
- [ ] Power on device (USB-C)
- [ ] Connect to AP: `NLS-Tracker-XXXX`
- [ ] Access: `http://192.168.4.1`
- [ ] Configure WiFi (STA mode)
- [ ] Note device IP address

### Development Tools

#### Required Tools
```bash
# ESP-IDF
git clone --recursive https://github.com/espressif/esp-idf.git
cd esp-idf && ./install.sh && . ./export.sh

# Python 3.8+
python3 --version

# Serial Monitor
# Linux: screen /dev/ttyUSB0 115200
# Mac: screen /dev/tty.usbserial-* 115200
# Windows: PuTTY or Arduino Serial Monitor
```

#### Development Commands
```bash
# Build
idf.py build

# Flash
idf.py flash

# Monitor
idf.py monitor

# Flash + Monitor
idf.py flash monitor

# Clean build
idf.py fullclean
```

### AP Mode (Access Point) - Development

#### Enable AP Mode
```bash
# Via CLI/Serial
config wifi ap
SSID: NLS-Dev-XXXX
Password: (optional)
config save
reboot
```

#### AP Configuration
- **SSID**: `NLS-Dev-{device-id}`
- **IP**: `192.168.4.1`
- **Password**: Optional (recommended for security)
- **Use Case**: Development, testing, initial setup

### Terminal/CLI Installation

#### Serial Access
```bash
# Linux
screen /dev/ttyUSB0 115200
# or
minicom -D /dev/ttyUSB0 -b 115200

# Mac
screen /dev/tty.usbserial-* 115200
# or
cu -l /dev/tty.usbserial-* -s 115200

# Windows
# Use PuTTY: Serial, COM port, 115200 baud
```

#### CLI Commands
```bash
# Device info
status
version
device_id

# Network
wifi scan
wifi connect <ssid> <password>
wifi ap
network status

# Configuration
config get
config set <key> <value>
config save
config reset

# Sensors
sensors list
sensors enable <sensor>
sensors disable <sensor>
sensors test

# System
reboot
factory_reset
ota_update <url>
```

### Automated Installation (Answer File)

#### Create `install.conf`
```ini
# WiFi Configuration
wifi.ssid=YourNetwork
wifi.password=YourPassword
wifi.mode=sta

# Device Configuration
device.name=Tracker-001
device.id=tracker-001

# MQTT Configuration
mqtt.broker=mqtt.example.com
mqtt.port=1883
mqtt.username=
mqtt.password=

# Sensor Configuration
sensors.imu.enabled=true
sensors.imu.sample_rate=100
sensors.gps.enabled=false
```

#### Automated Installation Script
```bash
#!/bin/bash
# install.sh - Automated installation script

DEVICE_IP="192.168.4.1"
CONFIG_FILE="install.conf"

# Upload configuration
curl -X POST http://${DEVICE_IP}/api/v1/config \
  -H "Content-Type: application/json" \
  -d @${CONFIG_FILE}

# Verify installation
curl http://${DEVICE_IP}/api/v1/status
```

#### Python Installation Script
```python
#!/usr/bin/env python3
import requests
import json

DEVICE_IP = "192.168.4.1"
CONFIG = {
    "wifi": {
        "ssid": "YourNetwork",
        "password": "YourPassword",
        "mode": "sta"
    },
    "device": {
        "name": "Tracker-001",
        "id": "tracker-001"
    }
}

# Upload configuration
response = requests.post(
    f"http://{DEVICE_IP}/api/v1/config",
    json=CONFIG
)

# Verify
status = requests.get(f"http://{DEVICE_IP}/api/v1/status")
print(status.json())
```

### Sandbox/Testing Environment

#### Docker Sandbox
```bash
# Run device emulator in Docker
docker run -it --rm \
  -p 1883:1883 \
  -p 80:80 \
  -p 443:443 \
  nls-tracker-emulator
```

#### Virtual Device Testing
```bash
# Use QEMU or similar for testing
qemu-system-arm -M esp32 -kernel firmware.bin
```

### Development Tools

#### Code Editors
- **VS Code**: Install ESP-IDF extension
- **PlatformIO**: Alternative IDE
- **Vim/Emacs**: With ESP-IDF support

#### Debugging Tools
```bash
# GDB Debugging
idf.py openocd
idf.py gdb

# Log Analysis
idf.py monitor | tee device.log
grep ERROR device.log

# Network Tools
# MQTT Client
mosquitto_sub -h <broker> -t "nls/tracker/+/#"
mosquitto_pub -h <broker> -t "nls/tracker/+/control" -m "test"

# WebSocket Test
wscat -c ws://<device-ip>/ws
```

#### Testing Tools
```bash
# Unit Tests
idf.py test

# Integration Tests
pytest tests/integration/

# Hardware Tests
python scripts/test_hardware.py
```

### Quick Commands Reference

| Task | Command |
|------|---------|
| Build | `idf.py build` |
| Flash | `idf.py flash` |
| Monitor | `idf.py monitor` |
| Flash+Monitor | `idf.py flash monitor` |
| Menuconfig | `idf.py menuconfig` |
| Clean | `idf.py fullclean` |
| Size | `idf.py size` |
| Size Components | `idf.py size-components` |

### Network Quick Setup

#### AP Mode (Development)
```bash
# Enable AP
config wifi ap "NLS-Dev" "password123"
config save
reboot

# Access: http://192.168.4.1
```

#### STA Mode (Production)
```bash
# Connect to WiFi
config wifi sta "YourSSID" "YourPassword"
config save
reboot

# Check IP
status network
```

### Troubleshooting Quick Fixes

| Issue | Quick Fix |
|-------|-----------|
| Device not found | Check USB connection, try different port |
| Build fails | `idf.py fullclean && idf.py build` |
| Flash fails | Hold BOOT button, press RESET, release BOOT |
| No serial output | Check baud rate (115200), check USB drivers |
| WiFi not connecting | Check SSID/password, signal strength |
| AP not appearing | Reset device, check serial for errors |

### Development Workflow

```bash
# 1. Setup
git clone <repo>
cd firmware
idf.py menuconfig  # Configure

# 2. Develop
# Edit code...

# 3. Build & Test
idf.py build
idf.py flash monitor

# 4. Debug
idf.py monitor  # View logs
# Check serial output

# 5. Deploy
idf.py flash
# Or OTA update
```

### Environment Variables

```bash
# ESP-IDF
export IDF_PATH=~/esp/esp-idf
. $IDF_PATH/export.sh

# Device IP (for scripts)
export DEVICE_IP=192.168.1.100

# MQTT Broker
export MQTT_BROKER=mqtt.example.com
```

### Useful Scripts

#### Flash Multiple Devices
```bash
#!/bin/bash
# flash_all.sh
for port in /dev/ttyUSB*; do
    idf.py -p $port flash
done
```

#### Monitor All Devices
```bash
#!/bin/bash
# monitor_all.sh
for port in /dev/ttyUSB*; do
    screen -dmS "device-$(basename $port)" \
        screen $port 115200
done
```

## Related Documentation

- [Hardware Setup](./hardware-setup.md)
- [Software Setup](./software-setup.md)
- [Network Installation](./network-installation.md)
- [Development Environment](./development-environment.md)

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
