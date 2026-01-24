# Hardware Architecture

## Overview

The NLS Artist Systems tracker device is designed as a modular, open source hardware platform optimized for real-time tracking, sensor data collection, and integration with live coding environments. The architecture emphasizes low latency, power efficiency, and extensibility.

## System Architecture

### High-Level Block Diagram

```
┌─────────────────────────────────────────────────────────┐
│                   Tracker Device                        │
├─────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐ │
│  │   Processor  │  │   Memory     │  │  Storage    │ │
│  │   (SoC/MCU)  │◄─┤   (RAM/Flash)│◄─┤  (eMMC/SD)  │ │
│  └──────┬───────┘  └──────────────┘  └─────────────┘ │
│         │                                              │
│  ┌──────▼──────────────────────────────────────────┐  │
│  │         Communication Interfaces                 │  │
│  │  WiFi  │  Bluetooth  │  Ethernet  │  LoRaWAN   │  │
│  └──────┬──────────────────────────────────────────┘  │
│         │                                              │
│  ┌──────▼──────────────────────────────────────────┐  │
│  │              Sensor Array                         │  │
│  │  IMU  │  GPS  │  Environmental  │  Custom      │  │
│  └──────┬──────────────────────────────────────────┘  │
│         │                                              │
│  ┌──────▼──────┐  ┌──────────────┐  ┌─────────────┐ │
│  │   Display   │  │   Audio I/O  │  │  Expansion  │ │
│  │  (OLED/eInk)│  │   (I2S/DAC)  │  │   (GPIO)    │ │
│  └─────────────┘  └──────────────┘  └─────────────┘ │
│                                                       │
│  ┌─────────────────────────────────────────────────┐ │
│  │         Power Management System                  │ │
│  │  Battery │  USB-C │  PoE │  Power Monitoring   │ │
│  └─────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────┘
```

## Core Components

### 1. Processor Unit

**Recommended Options:**

#### Option A: ARM-based SoC (Recommended for Full-Featured)
- **ESP32-S3** or **ESP32-C6**
  - Dual-core Xtensa LX7 @ 240MHz (ESP32-S3)
  - RISC-V @ 160MHz (ESP32-C6)
  - Built-in WiFi 6 and Bluetooth 5.x
  - Low power consumption
  - Rich GPIO and peripheral support

#### Option B: RISC-V MCU (Recommended for Low Power)
- **BL602/BL604** or **SiFive FE310**
  - RISC-V architecture
  - Ultra-low power consumption
  - WiFi and Bluetooth support
  - Suitable for battery-powered applications

#### Option C: Linux-capable SoC (Recommended for Advanced Features)
- **Raspberry Pi Zero 2 W** or **Rockchip RK3566**
  - Full Linux support
  - More processing power
  - Better for complex integrations
  - Higher power consumption

**Selection Criteria:**
- Processing requirements (real-time vs. batch processing)
- Power constraints (battery vs. mains powered)
- Integration complexity (simple MCU vs. full OS)
- Cost considerations

### 2. Memory Architecture

#### RAM Requirements
- **Minimum**: 512KB (for basic MCU implementations)
- **Recommended**: 4-8MB (for ESP32-S3)
- **Advanced**: 512MB-1GB (for Linux-based systems)

#### Storage Requirements
- **Flash**: 4-16MB (for firmware and configuration)
- **External Storage**: 
  - eMMC: 8-32GB (for Linux systems)
  - SD Card: Up to 512GB (expandable)
  - Purpose: Logs, cached data, firmware updates

### 3. Communication Interfaces

#### WiFi
- **Standard**: IEEE 802.11 b/g/n/ac/ax (WiFi 6)
- **Bands**: 2.4GHz and 5GHz (dual-band)
- **Use Cases**: 
  - High-bandwidth data streaming
  - Real-time synchronization
  - OTA firmware updates

#### Bluetooth
- **Standard**: Bluetooth 5.x (BLE)
- **Profiles**: BLE, Classic (optional)
- **Use Cases**:
  - Low-power sensor data transmission
  - Device pairing and configuration
  - Short-range communication

#### Ethernet (Optional)
- **Standard**: 10/100/1000 Mbps
- **Use Cases**:
  - Stable, wired connections
  - PoE power delivery
  - High-reliability installations

#### LoRaWAN (Optional)
- **Standard**: LoRaWAN 1.0.3
- **Use Cases**:
  - Long-range, low-power communication
  - Remote installations
  - Battery-powered deployments

### 4. Sensor Array

#### Inertial Measurement Unit (IMU)
- **Components**: Accelerometer, Gyroscope, Magnetometer
- **Specifications**:
  - Accelerometer: ±16g range, 3-axis
  - Gyroscope: ±2000°/s range, 3-axis
  - Magnetometer: ±4900µT range, 3-axis
- **Sampling Rate**: Up to 1kHz
- **Use Cases**: Motion tracking, orientation detection

#### GPS/GNSS (Optional)
- **Modules**: u-blox M8/M9 or Quectel L76
- **Features**: Multi-constellation support (GPS, GLONASS, BeiDou, Galileo)
- **Use Cases**: Absolute positioning, geolocation

#### Environmental Sensors (Optional)
- **Temperature/Humidity**: DHT22, SHT30
- **Pressure**: BMP280, MS5611
- **Light**: TSL2561, BH1750
- **Use Cases**: Environmental monitoring, context-aware tracking

### 5. Display Options

#### OLED Display (Recommended)
- **Size**: 0.96" to 2.4"
- **Resolution**: 128x64 to 240x320
- **Interface**: I2C or SPI
- **Use Cases**: Status display, basic visualization

#### E-Ink Display (Optional)
- **Size**: 2.9" to 7.5"
- **Resolution**: 296x128 to 800x480
- **Interface**: SPI
- **Use Cases**: Low-power status display, outdoor visibility

#### LED Matrix (Optional)
- **Size**: 8x8 to 32x32
- **Interface**: SPI
- **Use Cases**: Visual feedback, artistic displays

### 6. Audio I/O

#### Audio Input
- **Microphone**: MEMS microphone (I2S interface)
- **ADC**: 16-bit, 48kHz sampling
- **Use Cases**: Audio tracking, sound-reactive features

#### Audio Output
- **DAC**: I2S DAC or PWM audio
- **Amplifier**: Optional headphone amplifier
- **Use Cases**: Audio feedback, integration with audio systems

### 7. Expansion Ports

#### GPIO Pins
- **Digital I/O**: 10-20 pins (configurable)
- **Analog Input**: 4-8 channels (12-bit ADC)
- **PWM Output**: 4-8 channels
- **I2C**: 1-2 buses
- **SPI**: 1-2 buses
- **UART**: 1-2 serial ports

#### Expansion Headers
- **Standard**: 2.54mm pitch headers
- **Purpose**: Custom sensor modules, shields, add-ons

## Power Management

### Power Sources

#### Battery Power
- **Type**: LiPo or Li-ion
- **Capacity**: 1000-5000mAh
- **Voltage**: 3.7V nominal
- **Charging**: USB-C or dedicated charger IC

#### USB-C Power
- **Standard**: USB-C PD (Power Delivery)
- **Voltage**: 5V, 9V, 12V, 15V, 20V
- **Current**: Up to 3A (15W) or 5A (100W with PD)

#### PoE (Power over Ethernet)
- **Standard**: IEEE 802.3af/at (PoE/PoE+)
- **Power**: 12.95W (PoE) or 25.5W (PoE+)
- **Use Cases**: Fixed installations, network-powered devices

### Power Management IC (PMIC)

**Features:**
- Multiple voltage rails (1.8V, 3.3V, 5V)
- Battery charging management
- Power sequencing
- Low-power modes
- Power monitoring

## Form Factor

### Physical Dimensions
- **Base Unit**: 50mm x 50mm x 15mm (compact)
- **With Enclosure**: 60mm x 60mm x 20mm
- **Weight**: 20-50g (without battery)

### Enclosure Design
- **Material**: 3D printed PLA/PETG or injection molded ABS
- **Mounting**: Standard M3 mounting holes
- **Protection**: IP54 (dust and water resistant)
- **Ventilation**: Optional cooling vents for high-power operation

## Design Principles

### 1. Modularity
- Modular sensor modules
- Swappable communication modules
- Expandable via standard interfaces

### 2. Open Source
- Open hardware designs (KiCad/Eagle)
- Open firmware and software
- Community-driven development

### 3. Power Efficiency
- Low-power components
- Sleep modes and power gating
- Efficient power management

### 4. Real-time Performance
- Low-latency communication
- Fast sensor sampling
- Deterministic timing

### 5. Extensibility
- Standard interfaces (I2C, SPI, UART)
- Expansion headers
- Modular firmware architecture

## Related Documentation

- [Hardware Components](./components.md) - Detailed component specifications
- [Connectivity](./connectivity.md) - Communication interface details
- [Power Management](./power-management.md) - Power system design
- [Bill of Materials](../assembly/bom.md) - Complete parts list
- [Assembly Guide](../assembly/assembly-guide.md) - Build instructions

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
