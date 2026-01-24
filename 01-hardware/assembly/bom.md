# Bill of Materials (BOM)

## Overview

This document provides a complete Bill of Materials (BOM) for building the NLS Artist Systems tracker device. The BOM is organized by functional sections with part numbers, quantities, and sourcing information.

## BOM Versions

### Basic Tracker (Low Cost)
Minimal components for basic functionality.

### Standard Tracker (Recommended)
Full-featured tracker with all standard components.

### Advanced Tracker (Full Featured)
Includes all optional components for maximum functionality.

## Core Components

### Processor & Memory

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | ESP32-S3-WROOM-1 | ESP32-S3 WiFi/Bluetooth Module | Espressif | 4MB Flash, PCB antenna |
| 1 | W25Q64JVSSIQ | 8MB SPI Flash (optional) | Winbond | Additional storage |

**Alternative Options:**
- ESP32-C6-WROOM-1 (lower power, RISC-V)
- Raspberry Pi Zero 2 W (Linux option)

### Power Management

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | TP4056 | Li-ion Battery Charger IC | Various | SOP-8 package |
| 1 | AMS1117-3.3 | 3.3V Linear Regulator | Advanced Monolithic | SOT-223 package |
| 1 | MT3608 | 5V Boost Converter (optional) | Various | SOT-23-6 package |
| 1 | INA219 | Current/Power Monitor (optional) | Texas Instruments | I2C interface |

### Battery

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | Custom | LiPo Battery 2000mAh | Various | 3.7V, JST-PH connector |
| 1 | JST-PH-2 | Battery Connector | JST | 2-pin connector |

**Alternative Options:**
- 1000mAh (smaller, lighter)
- 5000mAh (longer runtime)
- 18650 Li-ion cell (replaceable)

## Communication Modules

### WiFi & Bluetooth
- **Integrated**: ESP32-S3 includes WiFi and Bluetooth
- **External Antenna** (optional): IPEX/U.FL connector for external antenna

### LoRaWAN Module (Optional)

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | E22-400T30D | LoRa Module 433MHz | Ebyte | SPI interface, or |
| 1 | SX1262 | LoRa Module | Semtech | With breakout board |

### Ethernet Module (Optional)

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | W5500 | Ethernet Controller | WIZnet | SPI interface |
| 1 | HR911105A | RJ45 Connector with Magnetics | HanRun | Integrated magnetics |

## Sensors

### Inertial Measurement Unit (IMU)

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | MPU-6050 | 6-DOF IMU (Accel + Gyro) | TDK InvenSense | I2C interface, or |
| 1 | MPU-9250 | 9-DOF IMU (Accel + Gyro + Mag) | TDK InvenSense | I2C/SPI interface |

**Alternative Options:**
- BMI160 (Bosch, lower power)
- LSM6DS3 (STMicroelectronics)

### GPS Module (Optional)

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | NEO-M8N | GPS/GNSS Module | u-blox | UART interface, or |
| 1 | L76-L | GPS/GNSS Module | Quectel | Lower power |

### Environmental Sensors (Optional)

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | SHT30 | Temperature & Humidity | Sensirion | I2C interface |
| 1 | BMP280 | Barometric Pressure | Bosch | I2C/SPI interface |
| 1 | TSL2561 | Light Sensor | AMS | I2C interface |

## Display Modules

### OLED Display

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | SSD1306 | 0.96" OLED 128x64 | Various | I2C interface, or |
| 1 | SH1106 | 1.3" OLED 128x64 | Various | I2C/SPI interface |

### E-Ink Display (Optional)

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | Waveshare 2.9" | E-Ink Display 296x128 | Waveshare | SPI interface |

## Audio Components

### Microphone

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | INMP441 | MEMS Microphone | InvenSense | I2S interface, or |
| 1 | SPH0645LM4H | MEMS Microphone | Knowles | I2S interface |

### Audio Output (Optional)

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | MAX98357A | I2S DAC with Amplifier | Maxim Integrated | 3W output, or |
| 1 | PCM5102A | I2S DAC | Texas Instruments | Line-level output |

## Connectors & Headers

### USB Connector

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | USB-C-31-M-12 | USB-C Connector | Various | Surface mount, or |
| 1 | Micro-USB-B | Micro-USB Connector | Various | Lower cost option |

### Expansion Headers

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 2 | 2.54mm Header | 20-pin Header (male) | Various | 2x 20-pin = 40 pins total |
| 2 | 2.54mm Socket | 20-pin Socket (female) | Various | Optional, for stacking |

### Antenna Connectors

| Qty | Part Number | Description | Manufacturer | Notes |
|-----|-------------|-------------|--------------|-------|
| 1 | IPEX/U.FL | WiFi Antenna Connector | Various | For external antenna (optional) |
| 1 | SMA | LoRa Antenna Connector | Various | For LoRa module (optional) |

## Passive Components

### Resistors

| Qty | Value | Tolerance | Power | Description | Notes |
|-----|-------|-----------|-------|-------------|-------|
| 2 | 10kΩ | 1% | 1/8W | Pull-up resistors | I2C bus |
| 2 | 4.7kΩ | 1% | 1/8W | Pull-up resistors | Alternative I2C |
| 2 | 1kΩ | 5% | 1/8W | Current limiting | LEDs, status |
| 1 | 2.2kΩ | 1% | 1/8W | Voltage divider | Battery monitoring |
| 1 | 4.7kΩ | 1% | 1/8W | Voltage divider | Battery monitoring |
| 1 | 10kΩ | 5% | 1/8W | Pull-down | Reset, enable pins |

### Capacitors

| Qty | Value | Voltage | Type | Description | Notes |
|-----|-------|---------|------|-------------|-------|
| 2 | 10µF | 16V | Ceramic | Decoupling | Power rails |
| 4 | 100nF | 50V | Ceramic | Decoupling | IC power pins |
| 2 | 22pF | 50V | Ceramic | Crystal load | 32.768kHz crystal |
| 1 | 1000µF | 10V | Electrolytic | Power supply | Bulk capacitance (optional) |
| 1 | 10µF | 25V | Tantalum | Power supply | Low ESR (optional) |

### Inductors

| Qty | Value | Current | Description | Notes |
|-----|-------|---------|-------------|-------|
| 1 | 4.7µH | 2A | Boost converter | For 5V boost (optional) |
| 1 | 10µH | 1A | Power supply | Filtering (optional) |

### Crystals/Oscillators

| Qty | Part Number | Frequency | Description | Notes |
|-----|-------------|-----------|-------------|-------|
| 1 | 32.768kHz | 32.768kHz | RTC Crystal | Real-time clock (optional) |

**Note**: ESP32-S3 has internal oscillators, external crystal optional for RTC.

## LEDs & Indicators

| Qty | Part Number | Color | Description | Notes |
|-----|-------------|-------|-------------|-------|
| 1 | Standard LED | Red | Power/Status | 3mm or 5mm |
| 1 | Standard LED | Green | Charging Complete | 3mm or 5mm |
| 1 | Standard LED | Blue | Activity/Status | 3mm or 5mm (optional) |

## Switches & Buttons

| Qty | Part Number | Description | Notes |
|-----|-------------|-------------|-------|
| 1 | Tactile Switch | Reset Button | 6mm x 6mm |
| 1 | Tactile Switch | Boot/Flash Button | 6mm x 6mm |
| 1 | Toggle Switch | Power Switch (optional) | For battery power |

## Mechanical Components

### Enclosure

| Qty | Description | Material | Notes |
|-----|-------------|----------|-------|
| 1 | Enclosure Top | 3D Printed PLA/PETG | Custom design |
| 1 | Enclosure Bottom | 3D Printed PLA/PETG | Custom design |

### Mounting Hardware

| Qty | Part Number | Description | Notes |
|-----|-------------|-------------|-------|
| 4 | M3x6mm | Machine Screws | Enclosure assembly |
| 4 | M3x8mm | Machine Screws | Alternative length |
| 4 | M3 Standoff | Female-Female Standoffs | 6mm or 10mm height |
| 4 | M3 Nut | Hex Nuts | For standoffs |

## PCB Components

### PCB Specifications
- **Layers**: 2-layer (minimum), 4-layer (recommended)
- **Thickness**: 1.6mm (standard)
- **Copper Weight**: 1oz (35µm)
- **Surface Finish**: HASL (lead-free) or ENIG
- **Solder Mask**: Green (standard) or custom color
- **Silkscreen**: White (standard)

### PCB Size
- **Dimensions**: 50mm x 50mm (compact) or 60mm x 60mm (with more components)
- **Mounting Holes**: 4x M3 holes at corners

## Complete BOM Summary

### Basic Tracker BOM
- Processor: ESP32-S3
- Power: TP4056, AMS1117-3.3, Battery
- Sensors: MPU-6050
- Passives: Resistors, capacitors
- **Total Components**: ~30-40 parts
- **Estimated Cost**: $15-25 (single unit)

### Standard Tracker BOM
- All Basic components
- Display: SSD1306 OLED
- Audio: INMP441 microphone
- Additional sensors: Optional
- **Total Components**: ~50-60 parts
- **Estimated Cost**: $25-40 (single unit)

### Advanced Tracker BOM
- All Standard components
- GPS: NEO-M8N
- LoRaWAN: E22-400T30D
- Environmental sensors: SHT30, BMP280
- E-Ink display: Optional
- **Total Components**: ~70-80 parts
- **Estimated Cost**: $50-80 (single unit)

## Sourcing Information

### Recommended Distributors

#### North America
- **Digi-Key**: [www.digikey.com](https://www.digikey.com) - Wide selection, fast shipping
- **Mouser Electronics**: [www.mouser.com](https://www.mouser.com) - Good for small quantities
- **Adafruit**: [www.adafruit.com](https://www.adafruit.com) - Modules and breakout boards
- **SparkFun**: [www.sparkfun.com](https://www.sparkfun.com) - Modules and development boards

#### Europe
- **Farnell/Element14**: [www.farnell.com](https://www.farnell.com)
- **RS Components**: [www.rs-online.com](https://www.rs-online.com)
- **Mouser Electronics**: European warehouse

#### Asia
- **LCSC**: [www.lcsc.com](https://www.lcsc.com) - Good for bulk orders
- **Seeed Studio**: [www.seeedstudio.com](https://www.seeedstudio.com) - Modules and PCBs
- **AliExpress**: Various sellers (verify authenticity)

### Module Suppliers
- **Espressif**: Official ESP32 modules
- **u-blox**: GPS modules
- **Waveshare**: Display modules
- **Ebyte**: LoRa modules

## BOM Management

### Version Control
- **BOM Version**: Track changes and revisions
- **Date**: Last updated date
- **Author**: BOM creator/maintainer

### Part Substitution
- **Alternatives**: Document alternative part numbers
- **Compatibility**: Verify pin compatibility
- **Testing**: Test substitutions before production

### Cost Optimization
- **Volume Pricing**: Negotiate for larger quantities
- **Alternative Suppliers**: Compare prices across distributors
- **Component Selection**: Balance cost vs. features

## Related Documentation

- [Hardware Architecture](../specifications/architecture.md) - System architecture
- [Hardware Components](../specifications/components.md) - Detailed component specifications
- [Assembly Guide](./assembly-guide.md) - Step-by-step assembly instructions
- [Testing Procedures](./testing-procedures.md) - Testing and validation

---

**BOM Version**: 1.0.0  
**Last Updated**: 2025-02-02  
**Maintainer**: NLS Artist Systems Hardware Team
