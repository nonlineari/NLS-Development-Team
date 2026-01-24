# Hardware Components

## Overview

This document provides detailed specifications for all hardware components used in the NLS Artist Systems tracker device. Components are organized by category with part numbers, specifications, and sourcing information.

## Processor & Memory

### Primary Processor

#### Option 1: ESP32-S3 (Recommended)
- **Part Number**: ESP32-S3-WROOM-1 or ESP32-S3-WROOM-1U
- **Architecture**: Dual-core Xtensa LX7 @ 240MHz
- **Memory**: 
  - RAM: 512KB SRAM
  - Flash: 4MB, 8MB, or 16MB (configurable)
- **Connectivity**: 
  - WiFi 6 (802.11 b/g/n)
  - Bluetooth 5.0 (BLE + Classic)
- **GPIO**: 45 programmable GPIO pins
- **Peripherals**: 
  - 3x UART, 2x I2C, 2x SPI, 1x I2S
  - 14x ADC channels (12-bit)
  - 10x touch sensors
- **Power**: 3.0V - 3.6V, ~80mA active, <5µA deep sleep
- **Package**: QFN 7x7mm or module
- **Manufacturer**: Espressif Systems
- **Datasheet**: [ESP32-S3 Datasheet](https://www.espressif.com/sites/default/files/documentation/esp32-s3_datasheet_en.pdf)

#### Option 2: ESP32-C6 (Low Power Alternative)
- **Part Number**: ESP32-C6-WROOM-1
- **Architecture**: RISC-V @ 160MHz
- **Memory**: 
  - RAM: 400KB SRAM
  - Flash: 4MB or 8MB
- **Connectivity**: 
  - WiFi 6 (802.11 b/g/n)
  - Bluetooth 5.0 (BLE)
- **GPIO**: 30 programmable GPIO pins
- **Power**: Lower power consumption than ESP32-S3
- **Manufacturer**: Espressif Systems

#### Option 3: Raspberry Pi Zero 2 W (Linux Option)
- **Part Number**: Raspberry Pi Zero 2 W
- **Architecture**: Quad-core ARM Cortex-A53 @ 1GHz
- **Memory**: 512MB LPDDR2 SDRAM
- **Storage**: MicroSD card slot
- **Connectivity**: 
  - WiFi 4 (802.11 b/g/n)
  - Bluetooth 4.2
- **GPIO**: 40-pin header
- **Power**: 5V via USB-C or GPIO header
- **Manufacturer**: Raspberry Pi Foundation

### External Memory (Optional)

#### Flash Memory
- **Part Number**: W25Q64JVSSIQ or AT25SF081
- **Type**: SPI Flash
- **Capacity**: 8MB (64Mbit)
- **Interface**: SPI
- **Speed**: Up to 104MHz
- **Use Case**: Additional storage for firmware, logs

#### eMMC Module (Linux Systems)
- **Part Number**: Various (Kingston, SanDisk)
- **Capacity**: 8GB - 32GB
- **Interface**: eMMC 5.1
- **Use Case**: Primary storage for Linux-based systems

## Communication Modules

### WiFi Module

#### ESP32-S3 Built-in WiFi
- **Standard**: IEEE 802.11 b/g/n (WiFi 4)
- **Bands**: 2.4GHz
- **Antenna**: PCB antenna or external connector
- **Range**: Up to 100m (open space)
- **Power**: Integrated in ESP32-S3

#### External WiFi Module (Optional)
- **Part Number**: ESP8266 or ESP32 as co-processor
- **Use Case**: Additional WiFi interface or WiFi 6 support

### Bluetooth Module

#### ESP32-S3 Built-in Bluetooth
- **Standard**: Bluetooth 5.0
- **Profiles**: BLE, Classic (optional)
- **Range**: Up to 10m (classic), up to 100m (BLE long range)
- **Power**: Integrated in ESP32-S3

### LoRaWAN Module (Optional)

#### SX1262 LoRa Module
- **Part Number**: SX1262 or E22-400T30D
- **Frequency**: 433MHz, 868MHz, or 915MHz (region dependent)
- **Range**: Up to 5km (line of sight)
- **Interface**: SPI
- **Power**: Low power, suitable for battery operation
- **Manufacturer**: Semtech or Ebyte

### Ethernet Module (Optional)

#### W5500 Ethernet Controller
- **Part Number**: W5500
- **Standard**: 10/100 Mbps Ethernet
- **Interface**: SPI
- **Power**: 3.3V, ~150mA
- **Use Case**: Wired network connection

## Sensors

### Inertial Measurement Unit (IMU)

#### MPU-6050 (6-DOF)
- **Part Number**: MPU-6050
- **Components**: 
  - 3-axis Accelerometer (±2g, ±4g, ±8g, ±16g)
  - 3-axis Gyroscope (±250°/s, ±500°/s, ±1000°/s, ±2000°/s)
- **Interface**: I2C
- **Sampling Rate**: Up to 1kHz
- **Power**: 3.3V, ~3.9mA active, ~5µA sleep
- **Manufacturer**: InvenSense (TDK)

#### MPU-9250 (9-DOF)
- **Part Number**: MPU-9250
- **Components**: 
  - 3-axis Accelerometer
  - 3-axis Gyroscope
  - 3-axis Magnetometer (±4800µT)
- **Interface**: I2C or SPI
- **Use Case**: Full orientation tracking with compass

#### BMI160 (Alternative)
- **Part Number**: BMI160
- **Components**: 
  - 3-axis Accelerometer (±2g to ±16g)
  - 3-axis Gyroscope (±125°/s to ±2000°/s)
- **Interface**: I2C or SPI
- **Power**: Lower power than MPU-6050
- **Manufacturer**: Bosch Sensortec

### GPS/GNSS Module (Optional)

#### u-blox M8N
- **Part Number**: NEO-M8N
- **Constellations**: GPS, GLONASS, BeiDou, Galileo
- **Interface**: UART
- **Update Rate**: Up to 10Hz
- **Power**: 3.3V, ~25mA active
- **Accuracy**: 2.5m CEP
- **Manufacturer**: u-blox

#### Quectel L76-L
- **Part Number**: L76-L
- **Constellations**: GPS, GLONASS, BeiDou, Galileo, QZSS
- **Interface**: UART
- **Power**: Lower power than M8N
- **Manufacturer**: Quectel

### Environmental Sensors (Optional)

#### Temperature & Humidity
- **Part Number**: DHT22 or SHT30
- **Range**: 
  - Temperature: -40°C to 80°C (DHT22), -40°C to 125°C (SHT30)
  - Humidity: 0-100% RH
- **Accuracy**: ±0.5°C, ±2% RH (SHT30)
- **Interface**: Digital (DHT22) or I2C (SHT30)

#### Barometric Pressure
- **Part Number**: BMP280 or MS5611
- **Range**: 300-1100 hPa
- **Accuracy**: ±1 hPa
- **Interface**: I2C or SPI
- **Use Case**: Altitude estimation, weather monitoring

#### Light Sensor
- **Part Number**: TSL2561 or BH1750
- **Range**: 0.1 to 40,000 lux
- **Interface**: I2C
- **Use Case**: Ambient light detection

## Display Modules

### OLED Display

#### SSD1306 OLED (0.96")
- **Part Number**: SSD1306 128x64 OLED
- **Size**: 0.96" diagonal
- **Resolution**: 128x64 pixels
- **Interface**: I2C or SPI
- **Color**: Monochrome (white/yellow/blue)
- **Power**: 3.3V, ~20mA active
- **Manufacturer**: Various (Adafruit, SparkFun)

#### SH1106 OLED (1.3")
- **Part Number**: SH1106 128x64 OLED
- **Size**: 1.3" diagonal
- **Resolution**: 128x64 pixels
- **Interface**: I2C or SPI
- **Use Case**: Larger display option

### E-Ink Display (Optional)

#### Waveshare 2.9" E-Ink
- **Part Number**: Waveshare 2.9inch e-Paper
- **Size**: 2.9" diagonal
- **Resolution**: 296x128 pixels
- **Interface**: SPI
- **Color**: Black and white
- **Power**: Very low power, only consumes power during updates
- **Use Case**: Low-power status display

## Audio Components

### Microphone

#### MEMS Microphone
- **Part Number**: INMP441 or SPH0645LM4H
- **Type**: Digital MEMS microphone
- **Interface**: I2S
- **Sensitivity**: -26dBFS
- **SNR**: 64dB
- **Power**: 3.3V, ~1.2mA
- **Use Case**: Audio input for sound-reactive features

### Audio Output

#### I2S DAC
- **Part Number**: MAX98357A or PCM5102A
- **Type**: I2S DAC with amplifier
- **Interface**: I2S
- **Output**: 3W (MAX98357A) or line-level (PCM5102A)
- **Power**: 5V, ~15mA
- **Use Case**: Audio output, headphone connection

## Power Management

### Power Management IC (PMIC)

#### TP4056 (Battery Charger)
- **Part Number**: TP4056
- **Function**: Li-ion/LiPo battery charger
- **Input**: 5V USB
- **Output**: 4.2V (battery charging)
- **Current**: Up to 1A charging current
- **Features**: Charge status LEDs, overcharge protection

#### MCP73831 (Alternative)
- **Part Number**: MCP73831
- **Function**: Li-ion/LiPo battery charger
- **Features**: Smaller package, lower cost

### Voltage Regulators

#### 3.3V Linear Regulator
- **Part Number**: AMS1117-3.3 or LD1117S33
- **Input**: 4.5V - 15V
- **Output**: 3.3V @ 1A
- **Use Case**: Main power rail

#### 5V Boost Converter (Optional)
- **Part Number**: MT3608 or XL6009
- **Input**: 3.7V (battery)
- **Output**: 5V @ 2A
- **Use Case**: USB power output, 5V peripherals

### Battery

#### LiPo Battery
- **Capacity**: 1000mAh - 5000mAh
- **Voltage**: 3.7V nominal (4.2V max)
- **Connector**: JST-PH 2-pin
- **Protection**: Built-in protection circuit recommended

#### Li-ion Battery (18650)
- **Capacity**: 2000mAh - 3500mAh
- **Voltage**: 3.7V nominal
- **Use Case**: Higher capacity option

## Connectors & Headers

### USB Connector
- **Type**: USB-C (recommended) or Micro-USB
- **Function**: Power input, data communication, programming
- **Standard**: USB 2.0

### Expansion Headers
- **Type**: 2.54mm pitch pin headers
- **Configuration**: 
  - 2x 20-pin headers (40 pins total)
  - GPIO, power, ground, I2C, SPI, UART

### Antenna Connectors
- **WiFi**: IPEX/U.FL connector (for external antenna)
- **LoRa**: SMA connector (for external antenna)

## Passive Components

### Resistors
- **Values**: Standard E24 series
- **Power**: 1/4W or 1/8W
- **Tolerance**: 1% or 5%

### Capacitors
- **Types**: 
  - Ceramic: 10pF - 100µF (decoupling, filtering)
  - Electrolytic: 10µF - 1000µF (power supply)
- **Voltage Rating**: 2x operating voltage minimum

### Crystals/Oscillators
- **32.768kHz**: Real-time clock (RTC)
- **Main Oscillator**: Integrated in ESP32-S3

## Enclosure & Mechanical

### Enclosure
- **Material**: 3D printed PLA/PETG or injection molded ABS
- **Mounting**: M3 mounting holes
- **Protection**: IP54 rating (optional)

### Mounting Hardware
- **Screws**: M3x6mm or M3x8mm
- **Standoffs**: M3 female-female, 6mm or 10mm height

## Component Selection Guide

### For Basic Tracker (Low Cost)
- ESP32-C6 or ESP32-S3
- MPU-6050 IMU
- Basic power management
- Minimal sensors

### For Standard Tracker (Recommended)
- ESP32-S3
- MPU-9250 IMU
- OLED display (SSD1306)
- MEMS microphone
- Battery power with charging

### For Advanced Tracker (Full Featured)
- Raspberry Pi Zero 2 W or ESP32-S3
- MPU-9250 IMU
- GPS module
- Environmental sensors
- E-ink display
- LoRaWAN module
- Full power management

## Sourcing Information

### Recommended Distributors
- **Digi-Key**: [www.digikey.com](https://www.digikey.com)
- **Mouser Electronics**: [www.mouser.com](https://www.mouser.com)
- **Adafruit**: [www.adafruit.com](https://www.adafruit.com) (modules and breakout boards)
- **SparkFun**: [www.sparkfun.com](https://www.sparkfun.com) (modules and breakout boards)
- **LCSC**: [www.lcsc.com](https://www.lcsc.com) (components, good for bulk orders)

### Module Suppliers
- **Espressif**: Official ESP32 modules
- **u-blox**: GPS modules
- **Waveshare**: Display modules
- **Seeed Studio**: Various modules and development boards

## Related Documentation

- [Hardware Architecture](./architecture.md) - System architecture overview
- [Connectivity](./connectivity.md) - Communication interface details
- [Power Management](./power-management.md) - Power system design
- [Bill of Materials](../assembly/bom.md) - Complete parts list with part numbers

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
