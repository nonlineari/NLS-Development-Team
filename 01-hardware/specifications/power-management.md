# Power Management

## Overview

This document describes the power management system for the NLS Artist Systems tracker device. The system is designed to support multiple power sources, efficient power conversion, battery management, and low-power operation modes.

## Power Architecture

### Power Sources

#### 1. Battery Power (Primary for Portable Use)
- **Type**: LiPo or Li-ion
- **Voltage**: 3.7V nominal (4.2V fully charged, 3.0V minimum)
- **Capacity**: 1000mAh - 5000mAh (depending on use case)
- **Connector**: JST-PH 2-pin
- **Protection**: Built-in protection circuit (PCM) recommended

#### 2. USB-C Power (Primary for Development/Charging)
- **Standard**: USB-C Power Delivery (PD) 2.0/3.0
- **Voltage Options**: 5V, 9V, 12V, 15V, 20V
- **Current**: Up to 3A (standard), up to 5A (with PD)
- **Power**: Up to 100W (with PD)
- **Use Case**: 
  - Device power when connected
  - Battery charging
  - Firmware updates and debugging

#### 3. Power over Ethernet (PoE) - Optional
- **Standard**: IEEE 802.3af (PoE) or 802.3at (PoE+)
- **Power**: 
  - PoE: 12.95W @ 48V
  - PoE+: 25.5W @ 48V
- **Voltage Conversion**: 48V to 5V/3.3V via PoE module
- **Use Case**: Fixed installations, network-powered devices

#### 4. External Power Supply
- **Input**: 5V - 12V DC
- **Connector**: DC barrel jack or terminal block
- **Use Case**: Fixed installations, mains power

### Power Management IC (PMIC)

#### Recommended: TP4056 (Battery Charger)
- **Part Number**: TP4056
- **Function**: Li-ion/LiPo battery charger
- **Input Voltage**: 4.5V - 8V
- **Charging Current**: Programmable (up to 1A)
- **Features**:
  - Constant current/constant voltage (CC/CV) charging
  - Charge status LEDs
  - Overcharge protection
  - Thermal protection
- **Package**: SOP-8

#### Alternative: MCP73831
- **Part Number**: MCP73831
- **Function**: Li-ion/LiPo battery charger
- **Features**: Smaller package, lower cost
- **Charging Current**: Up to 500mA

### Voltage Regulation

#### 3.3V Main Rail (Primary)
- **Regulator**: AMS1117-3.3 or LD1117S33
- **Input**: 4.5V - 15V
- **Output**: 3.3V @ 1A
- **Load**: Processor, sensors, communication modules
- **Efficiency**: ~70-80% (linear regulator)

#### 5V Rail (Optional)
- **Regulator**: MT3608 (boost) or AMS1117-5.0 (linear)
- **Input**: 3.7V (battery) or 5V+ (USB/external)
- **Output**: 5V @ 2A (boost) or 1A (linear)
- **Load**: USB peripherals, 5V modules
- **Efficiency**: ~85-90% (boost), ~70-80% (linear)

#### 1.8V Rail (Optional, for Advanced Processors)
- **Regulator**: AMS1117-1.8 or switching regulator
- **Output**: 1.8V @ 500mA
- **Load**: Processor core, memory

### Power Distribution

```
Power Source (Battery/USB/PoE)
    │
    ├─► PMIC (Battery Charger)
    │       └─► Battery
    │
    ├─► 5V Regulator (if needed)
    │       └─► 5V Peripherals
    │
    └─► 3.3V Regulator
            ├─► Processor (ESP32-S3)
            ├─► Sensors (IMU, GPS, etc.)
            ├─► Communication (WiFi, Bluetooth)
            └─► Display, Audio
```

## Battery Management

### Battery Specifications

#### LiPo Battery (Recommended)
- **Capacity**: 1000mAh - 5000mAh
- **Voltage**: 3.7V nominal (4.2V max, 3.0V min)
- **C-Rating**: 1C minimum (2C recommended)
- **Connector**: JST-PH 2-pin
- **Dimensions**: Varies by capacity

#### Li-ion Battery (18650) - Alternative
- **Capacity**: 2000mAh - 3500mAh
- **Voltage**: 3.7V nominal
- **Form Factor**: Cylindrical (18mm x 65mm)
- **Use Case**: Higher capacity, replaceable cells

### Battery Protection

#### Protection Circuit Module (PCM)
- **Overcharge Protection**: 4.25V ± 0.05V
- **Overdischarge Protection**: 2.5V ± 0.1V
- **Overcurrent Protection**: 3A - 10A (depending on battery)
- **Short Circuit Protection**: <10µs response time
- **Temperature Protection**: Optional

### Battery Monitoring

#### Voltage Monitoring
- **ADC Channel**: 12-bit ADC
- **Voltage Divider**: 2:1 ratio (for 0-8.4V range)
- **Accuracy**: ±1% with calibration
- **Sampling Rate**: 1Hz (normal), 10Hz (during charging)

#### Current Monitoring (Optional)
- **Current Sensor**: INA219 or ACS712
- **Range**: ±3.2A (INA219) or ±30A (ACS712)
- **Interface**: I2C (INA219) or analog (ACS712)
- **Use Case**: Power consumption analysis, battery capacity estimation

#### State of Charge (SoC) Estimation
- **Method**: Voltage-based or coulomb counting
- **Accuracy**: ±5% (voltage-based), ±2% (coulomb counting)
- **Implementation**: Software-based algorithm

## Power Modes

### Active Mode
- **Power Consumption**: 80-150mA @ 3.3V
- **Components Active**: All systems operational
- **Use Case**: Normal operation, data collection, communication

### Light Sleep Mode
- **Power Consumption**: 10-20mA @ 3.3V
- **Components Active**: 
  - CPU: Suspended
  - WiFi: Disabled
  - Sensors: Periodic sampling
  - RTC: Active
- **Wake Sources**: Timer, GPIO interrupt
- **Wake Time**: <1ms

### Deep Sleep Mode
- **Power Consumption**: <100µA @ 3.3V
- **Components Active**: 
  - CPU: Off
  - WiFi/Bluetooth: Off
  - Sensors: Off
  - RTC: Active (optional)
- **Wake Sources**: Timer, GPIO interrupt, RTC alarm
- **Wake Time**: 100-500ms
- **Use Case**: Battery-powered operation, long-term deployments

### Hibernation Mode (Optional)
- **Power Consumption**: <10µA @ 3.3V
- **Components Active**: None (power gated)
- **Wake Sources**: External interrupt, power button
- **Wake Time**: 1-2 seconds
- **Use Case**: Extended battery life, shipping mode

## Power Optimization Strategies

### Hardware Optimization

#### Power Gating
- **Unused Peripherals**: Disabled when not in use
- **External Modules**: Power gated via MOSFET switches
- **Sensors**: Enabled only during sampling

#### Clock Gating
- **CPU Frequency**: Reduced during low activity
- **Peripheral Clocks**: Disabled when not in use

#### Voltage Scaling
- **CPU Voltage**: Reduced at lower frequencies
- **Implementation**: Dynamic voltage and frequency scaling (DVFS)

### Software Optimization

#### Sleep Scheduling
- **Strategy**: Periodic wake-up for data collection
- **Interval**: Configurable (1s - 1 hour)
- **Duty Cycle**: <1% for battery operation

#### Communication Optimization
- **WiFi**: Disabled when not needed
- **Bluetooth**: Advertising interval increased
- **Data Batching**: Multiple samples sent together

#### Sensor Optimization
- **Sampling Rate**: Reduced when possible
- **Sensor Selection**: Lower power sensors preferred
- **Data Filtering**: On-device processing to reduce transmission

## Power Consumption Estimates

### Typical Power Consumption

#### Active Operation (WiFi Connected)
- **CPU**: 40mA
- **WiFi**: 50mA
- **Sensors**: 10mA
- **Display**: 20mA (if active)
- **Total**: ~120mA @ 3.3V = 396mW

#### Light Sleep (Periodic Sampling)
- **CPU**: 0mA (suspended)
- **WiFi**: 0mA (disabled)
- **Sensors**: 5mA (periodic)
- **RTC**: 5µA
- **Total**: ~5mA @ 3.3V = 16.5mW

#### Deep Sleep
- **CPU**: 0mA
- **WiFi**: 0mA
- **Sensors**: 0mA
- **RTC**: 10µA
- **Total**: ~10µA @ 3.3V = 33µW

### Battery Life Estimates

#### 2000mAh Battery
- **Active Mode**: ~16 hours (120mA)
- **Light Sleep (1s interval)**: ~400 hours (5mA average)
- **Deep Sleep**: ~22,000 hours (10µA)

#### 5000mAh Battery
- **Active Mode**: ~40 hours (120mA)
- **Light Sleep (1s interval)**: ~1000 hours (5mA average)
- **Deep Sleep**: ~55,000 hours (10µA)

## Charging System

### Charging Specifications

#### Charging Current
- **Standard**: 500mA (USB 2.0)
- **Fast**: 1000mA (USB 3.0 or dedicated charger)
- **Programmable**: Via PMIC configuration

#### Charging Voltage
- **Constant Current Phase**: 4.2V (current limited)
- **Constant Voltage Phase**: 4.2V (voltage limited)
- **Termination**: Current drops to 10% of initial current

#### Charging Time
- **500mA**: ~4 hours (2000mAh battery)
- **1000mA**: ~2 hours (2000mAh battery)

### Charging Indicators

#### LED Indicators
- **Red**: Charging in progress
- **Green**: Charging complete
- **Blinking**: Error condition

#### Status Monitoring
- **Voltage**: Real-time battery voltage
- **Current**: Charging current (if monitored)
- **Temperature**: Battery temperature (if monitored)

## Power Safety

### Overcurrent Protection
- **Fuse**: Resettable fuse (PTC) or standard fuse
- **Rating**: 2A - 5A (depending on design)
- **Response Time**: <1 second

### Overvoltage Protection
- **TVS Diode**: Transient voltage suppressor
- **Voltage Rating**: 5.5V (for 5V rail)
- **Response Time**: <1 nanosecond

### Reverse Polarity Protection
- **Method**: Schottky diode or MOSFET
- **Implementation**: On power input

### Thermal Protection
- **Temperature Sensor**: NTC thermistor
- **Shutdown Temperature**: 70°C - 85°C
- **Implementation**: Hardware or software

## Power Monitoring & Diagnostics

### Real-time Monitoring
- **Voltage**: Battery and rail voltages
- **Current**: Power consumption (if monitored)
- **Power**: Calculated (V × I)
- **Temperature**: Battery and board temperature

### Power Profiling
- **Data Collection**: Per-mode power consumption
- **Analysis**: Identify power-hungry components
- **Optimization**: Target high-consumption areas

### Low Battery Handling
- **Warning Threshold**: 3.3V (configurable)
- **Critical Threshold**: 3.0V (configurable)
- **Actions**:
  - Reduce sampling rate
  - Disable non-essential features
  - Enter deep sleep more frequently
  - Send low battery alert

## Related Documentation

- [Hardware Architecture](./architecture.md) - System architecture overview
- [Hardware Components](./components.md) - Component specifications including power components
- [Connectivity](./connectivity.md) - Communication interfaces and power requirements
- [Assembly Guide](../assembly/assembly-guide.md) - Power system assembly instructions

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
