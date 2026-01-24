# Firmware Overview

## Introduction

The NLS Artist Systems tracker device firmware provides the core functionality for sensor data collection, communication, device management, and integration with NLS systems. This document provides an overview of the firmware architecture and components.

## Firmware Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────────────┐
│              Application Layer                   │
│  (NLS Integration, User Applications)            │
├─────────────────────────────────────────────────┤
│              Middleware Layer                    │
│  (Protocols, Data Processing, Device Mgmt)       │
├─────────────────────────────────────────────────┤
│              Hardware Abstraction Layer (HAL)    │
│  (Drivers, Sensor Interfaces, Communication)    │
├─────────────────────────────────────────────────┤
│              Operating System / RTOS            │
│  (FreeRTOS, ESP-IDF, or Linux)                  │
├─────────────────────────────────────────────────┤
│              Hardware                           │
│  (ESP32-S3, Sensors, Communication Modules)      │
└─────────────────────────────────────────────────┘
```

## Core Components

### 1. Device Management
- **Configuration Management**: Device settings, network configuration
- **OTA Updates**: Over-the-air firmware updates
- **Status Monitoring**: Device health, battery status, connectivity
- **Logging**: System logs, debug information

### 2. Sensor Management
- **Sensor Initialization**: Initialize and configure sensors
- **Data Collection**: Periodic or event-driven data collection
- **Data Processing**: Filtering, calibration, fusion
- **Data Storage**: Local caching, buffering

### 3. Communication Stack
- **WiFi**: Network connectivity, MQTT, HTTP
- **Bluetooth**: BLE services, device pairing
- **LoRaWAN**: Long-range communication (optional)
- **OSC**: Open Sound Control for audio integration

### 4. NLS Integration
- **TidalCycles Integration**: OSC message routing
- **Hyperfone System**: P2P audio streaming
- **Pulsar Agent**: Interpretative grid integration
- **Conceptual Framework**: Polish notation, tree traversal

## Operating System Options

### Option 1: ESP-IDF (Recommended for ESP32-S3)
- **Type**: Real-time operating system (FreeRTOS-based)
- **Features**: 
  - Low-level hardware control
  - Real-time performance
  - Low power consumption
  - Rich peripheral support
- **Use Case**: Production firmware, real-time applications

### Option 2: Arduino Framework
- **Type**: Simplified framework on ESP-IDF
- **Features**:
  - Easy to use
  - Large library ecosystem
  - Good for prototyping
- **Use Case**: Prototyping, simple applications

### Option 3: Embedded Linux (Raspberry Pi)
- **Type**: Full Linux distribution
- **Features**:
  - Full OS capabilities
  - Rich software ecosystem
  - Higher power consumption
- **Use Case**: Advanced features, complex integrations

## Firmware Structure

### Directory Structure
```
firmware/
├── main/
│   ├── main.c                 # Main application entry
│   ├── config.h               # Configuration settings
│   └── version.h              # Version information
├── components/
│   ├── device_mgmt/          # Device management
│   ├── sensors/              # Sensor drivers and processing
│   ├── communication/        # Communication protocols
│   ├── nls_integration/      # NLS system integration
│   └── storage/              # Data storage
├── drivers/
│   ├── imu/                  # IMU driver
│   ├── gps/                  # GPS driver
│   └── display/              # Display driver
├── hal/
│   ├── gpio.h                # GPIO abstraction
│   ├── i2c.h                 # I2C abstraction
│   └── spi.h                 # SPI abstraction
└── tests/
    ├── unit/                 # Unit tests
    └── integration/         # Integration tests
```

## Key Features

### Real-time Data Collection
- High-frequency sensor sampling (up to 1kHz)
- Low-latency data processing
- Deterministic timing

### Power Management
- Multiple power modes (active, light sleep, deep sleep)
- Dynamic power scaling
- Battery monitoring and management

### Network Connectivity
- WiFi with automatic reconnection
- Bluetooth Low Energy
- MQTT for telemetry
- WebSocket for real-time communication
- OSC for audio integration

### Data Processing
- Sensor fusion (IMU data)
- Calibration and filtering
- Data compression
- Local storage and caching

## Development Workflow

### 1. Setup Development Environment
See [Development Environment Guide](../04-development/getting-started/development-environment.md)

### 2. Build Firmware
```bash
# ESP-IDF
idf.py build

# Arduino
arduino-cli compile --fqbn esp32:esp32:esp32s3
```

### 3. Flash Firmware
```bash
# ESP-IDF
idf.py flash

# Arduino
arduino-cli upload --fqbn esp32:esp32:esp32s3 --port /dev/ttyUSB0
```

### 4. Monitor Output
```bash
# ESP-IDF
idf.py monitor

# Arduino
arduino-cli monitor --port /dev/ttyUSB0
```

## Configuration

### Build Configuration
- **Menuconfig**: ESP-IDF configuration system
- **Config Files**: JSON or YAML configuration files
- **Environment Variables**: Build-time configuration

### Runtime Configuration
- **Web Interface**: Configuration portal
- **Serial Interface**: Command-line configuration
- **OTA Configuration**: Remote configuration updates

## Versioning

### Version Format
- **Format**: `MAJOR.MINOR.PATCH`
- **Example**: `1.2.3`
- **MAJOR**: Breaking changes
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes

### Version Management
- Git tags for releases
- Version in firmware binary
- OTA update version checking

## Testing

### Unit Testing
- Test individual components
- Mock hardware interfaces
- Automated test execution

### Integration Testing
- Test component interactions
- Hardware-in-the-loop testing
- End-to-end testing

### Field Testing
- Real-world deployment testing
- Long-term stability testing
- Performance testing

## Security

### Secure Boot
- Verified boot process
- Firmware signature verification
- Secure storage for keys

### Encryption
- TLS for network communication
- Encrypted storage for sensitive data
- Secure key management

## Related Documentation

- [OS Selection](./os-selection.md) - Operating system comparison
- [Core Components](./core-components.md) - Detailed component documentation
- [OTA Updates](./ota-updates.md) - Over-the-air update system
- [Getting Started](../04-development/getting-started/) - Development setup

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
