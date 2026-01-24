# Testing Procedures

## Overview

This document outlines comprehensive testing procedures for the NLS Artist Systems tracker device. Follow these procedures to verify hardware functionality, firmware operation, and system integration.

## Pre-Testing Checklist

### Safety Checks
- [ ] Verify no short circuits on power rails
- [ ] Check battery polarity and connections
- [ ] Ensure proper ventilation during testing
- [ ] Have fire extinguisher nearby (for battery testing)
- [ ] Verify all components are properly secured

### Equipment Required
- [ ] Multimeter (voltage, current, continuity)
- [ ] Oscilloscope (optional, for signal analysis)
- [ ] USB-C cable and power supply
- [ ] Computer with serial terminal
- [ ] WiFi network access
- [ ] Test firmware loaded on device

## Power System Testing

### 1. Power Rail Testing

#### 1.1 USB Power Input
1. Connect USB-C cable to device
2. Connect to computer or 5V power supply
3. Measure voltage on 3.3V rail:
   - **Expected**: 3.3V ± 0.1V
   - **Action if failed**: Check voltage regulator connections
4. Measure voltage on 5V rail (if present):
   - **Expected**: 5.0V ± 0.2V
   - **Action if failed**: Check boost converter or regulator

#### 1.2 Battery Power
1. **Important**: Verify battery is properly connected (correct polarity)
2. Measure battery voltage:
   - **Expected**: 3.7V - 4.2V (depending on charge level)
   - **Action if failed**: Check battery connections, verify battery is functional
3. Connect battery to device
4. Measure voltage on 3.3V rail:
   - **Expected**: 3.3V ± 0.1V
   - **Action if failed**: Check power management circuit

#### 1.3 Power Consumption
1. Connect multimeter in series with power supply
2. Measure current consumption in different modes:
   - **Active Mode**: ~80-150mA
   - **Light Sleep**: ~5-20mA
   - **Deep Sleep**: <100µA
   - **Action if failed**: Check for short circuits or faulty components

### 2. Battery Charging Testing

#### 2.1 Charging Circuit
1. Connect USB-C cable to device
2. Connect battery to device
3. Measure charging current:
   - **Expected**: 500mA - 1000mA (depending on configuration)
   - **Action if failed**: Check charger IC connections, verify charger IC is functional
4. Monitor battery voltage over time:
   - **Expected**: Voltage should increase from ~3.7V to 4.2V
   - **Action if failed**: Check charger IC, battery protection circuit

#### 2.2 Charging Indicators
1. Verify charging LED behavior:
   - **Red LED**: Should be on during charging
   - **Green LED**: Should turn on when charging complete
   - **Action if failed**: Check LED connections, charger IC status pins

#### 2.3 Charge Termination
1. Monitor charging until complete
2. Verify charging current drops to <10% of initial current
3. Verify battery voltage reaches 4.2V
4. **Action if failed**: Check charger IC termination logic

## Processor Testing

### 3. ESP32-S3 Module Testing

#### 3.1 Power and Reset
1. Apply power to device
2. Verify processor powers on (check status LED or serial output)
3. Press reset button:
   - **Expected**: Device should reset and restart
   - **Action if failed**: Check reset circuit, button connections

#### 3.2 Serial Communication
1. Connect device to computer via USB-C
2. Open serial terminal (115200 baud, 8N1)
3. Verify serial output:
   - **Expected**: Boot messages, debug output
   - **Action if failed**: Check USB connection, drivers, firmware

#### 3.3 Boot Mode
1. Press and hold boot button
2. Press and release reset button
3. Release boot button
4. Verify device enters bootloader mode:
   - **Expected**: Device recognized as USB serial device
   - **Action if failed**: Check boot button connections, boot mode circuit

### 4. Memory Testing

#### 4.1 Flash Memory
1. Upload test firmware
2. Verify firmware executes correctly
3. Test read/write operations:
   - **Expected**: Data can be written and read back correctly
   - **Action if failed**: Check flash connections, verify flash chip

#### 4.2 RAM Testing
1. Run memory test firmware
2. Verify RAM read/write operations:
   - **Expected**: All RAM locations accessible
   - **Action if failed**: Check processor connections, verify processor

## Communication Testing

### 5. WiFi Testing

#### 5.1 WiFi Initialization
1. Upload WiFi test firmware
2. Verify WiFi module initializes:
   - **Expected**: Serial output shows WiFi initialization messages
   - **Action if failed**: Check WiFi antenna, module connections

#### 5.2 WiFi Connection
1. Configure WiFi credentials (SSID, password)
2. Attempt to connect to WiFi network:
   - **Expected**: Device connects and obtains IP address
   - **Action if failed**: Check WiFi credentials, signal strength, antenna

#### 5.3 WiFi Range Testing
1. Connect device to WiFi network
2. Move device away from access point
3. Measure maximum range:
   - **Expected**: 30-50m indoor, 100m outdoor (with PCB antenna)
   - **Action if failed**: Check antenna connections, consider external antenna

### 6. Bluetooth Testing

#### 6.1 Bluetooth Initialization
1. Upload Bluetooth test firmware
2. Verify Bluetooth module initializes:
   - **Expected**: Serial output shows Bluetooth initialization
   - **Action if failed**: Check Bluetooth antenna, module connections

#### 6.2 Bluetooth Pairing
1. Enable Bluetooth on test device (phone/computer)
2. Scan for Bluetooth devices:
   - **Expected**: Tracker device appears in scan list
   - **Action if failed**: Check Bluetooth configuration, antenna

#### 6.3 Bluetooth Communication
1. Pair with tracker device
2. Send test data:
   - **Expected**: Data received correctly
   - **Action if failed**: Check Bluetooth service/characteristic configuration

### 7. LoRaWAN Testing (if applicable)

#### 7.1 LoRa Module Initialization
1. Upload LoRa test firmware
2. Verify LoRa module initializes:
   - **Expected**: Serial output shows LoRa initialization
   - **Action if failed**: Check LoRa module connections, SPI interface

#### 7.2 LoRa Communication
1. Configure LoRaWAN credentials (OTAA or ABP)
2. Join LoRaWAN network:
   - **Expected**: Device joins network successfully
   - **Action if failed**: Check credentials, antenna, signal strength

#### 7.3 LoRa Range Testing
1. Send test messages
2. Measure maximum range:
   - **Expected**: 2-5km urban, 15km rural (line of sight)
   - **Action if failed**: Check antenna, power settings, environment

## Sensor Testing

### 8. IMU Testing

#### 8.1 IMU Initialization
1. Upload IMU test firmware
2. Verify IMU initializes:
   - **Expected**: Serial output shows IMU initialization
   - **Action if failed**: Check I2C connections, IMU address, power

#### 8.2 Accelerometer Testing
1. Read accelerometer values
2. Tilt device in different orientations:
   - **Expected**: Values change according to orientation (±1g per axis)
   - **Action if failed**: Check IMU connections, calibration

#### 8.3 Gyroscope Testing
1. Read gyroscope values
2. Rotate device:
   - **Expected**: Values change during rotation
   - **Action if failed**: Check IMU connections, calibration

#### 8.4 Magnetometer Testing (if MPU-9250)
1. Read magnetometer values
2. Rotate device:
   - **Expected**: Values change with orientation
   - **Action if failed**: Check IMU connections, calibration, magnetic interference

### 9. GPS Testing (if applicable)

#### 9.1 GPS Initialization
1. Upload GPS test firmware
2. Verify GPS module initializes:
   - **Expected**: Serial output shows GPS initialization
   - **Action if failed**: Check UART connections, GPS power, antenna

#### 9.2 GPS Satellite Lock
1. Place device outdoors with clear sky view
2. Wait for satellite lock:
   - **Expected**: Lock within 30-60 seconds (cold start)
   - **Action if failed**: Check antenna placement, GPS module, environment

#### 9.3 GPS Accuracy Testing
1. Record GPS coordinates
2. Compare with known location:
   - **Expected**: Accuracy within 2-5 meters
   - **Action if failed**: Check antenna, signal strength, environment

### 10. Environmental Sensors Testing (if applicable)

#### 10.1 Temperature/Humidity Sensor
1. Read sensor values
2. Compare with reference sensor:
   - **Expected**: Values within ±2°C, ±5% RH
   - **Action if failed**: Check sensor connections, calibration

#### 10.2 Pressure Sensor
1. Read sensor values
2. Compare with reference sensor or weather data:
   - **Expected**: Values within ±1 hPa
   - **Action if failed**: Check sensor connections, calibration

#### 10.3 Light Sensor
1. Read sensor values
2. Vary light conditions:
   - **Expected**: Values change with light level
   - **Action if failed**: Check sensor connections, calibration

## Display Testing

### 11. OLED Display Testing

#### 11.1 Display Initialization
1. Upload display test firmware
2. Verify display initializes:
   - **Expected**: Display shows initialization pattern
   - **Action if failed**: Check I2C connections, display power, address

#### 11.2 Display Functionality
1. Display test pattern:
   - **Expected**: All pixels can be turned on/off
   - **Action if failed**: Check display connections, I2C communication

#### 11.3 Display Content
1. Display text and graphics:
   - **Expected**: Content displays correctly
   - **Action if failed**: Check display driver, I2C communication

### 12. E-Ink Display Testing (if applicable)

#### 12.1 Display Initialization
1. Upload e-ink test firmware
2. Verify display initializes:
   - **Expected**: Display updates (may take 1-2 seconds)
   - **Action if failed**: Check SPI connections, display power

#### 12.2 Display Updates
1. Update display content:
   - **Expected**: Content updates correctly
   - **Action if failed**: Check SPI communication, display driver

## Audio Testing

### 13. Microphone Testing (if applicable)

#### 13.1 Microphone Initialization
1. Upload microphone test firmware
2. Verify microphone initializes:
   - **Expected**: Serial output shows microphone initialization
   - **Action if failed**: Check I2S connections, microphone power

#### 13.2 Audio Capture
1. Capture audio samples
2. Analyze audio data:
   - **Expected**: Audio data changes with sound input
   - **Action if failed**: Check microphone connections, I2S configuration

### 14. Audio Output Testing (if applicable)

#### 14.1 DAC Initialization
1. Upload audio output test firmware
2. Verify DAC initializes:
   - **Expected**: Serial output shows DAC initialization
   - **Action if failed**: Check I2S connections, DAC power

#### 14.2 Audio Playback
1. Play test tone:
   - **Expected**: Audio output on speaker/headphones
   - **Action if failed**: Check DAC connections, amplifier, I2S configuration

## Integration Testing

### 15. Firmware Integration

#### 15.1 Complete Firmware Test
1. Upload complete firmware (all features)
2. Verify all systems work together:
   - **Expected**: All features functional
   - **Action if failed**: Check for resource conflicts, power consumption

#### 15.2 Stress Testing
1. Run device continuously for extended period (24+ hours)
2. Monitor for:
   - Memory leaks
   - Crashes or resets
   - Performance degradation
   - **Action if failed**: Debug firmware, check for resource issues

### 16. Network Integration

#### 16.1 MQTT Testing
1. Connect device to MQTT broker
2. Publish sensor data:
   - **Expected**: Data received on broker
   - **Action if failed**: Check MQTT configuration, network connectivity

#### 16.2 WebSocket Testing
1. Connect device via WebSocket
2. Send/receive data:
   - **Expected**: Bidirectional communication works
   - **Action if failed**: Check WebSocket configuration, network

#### 16.3 OSC Testing
1. Connect device to OSC-compatible software (TidalCycles, etc.)
2. Send OSC messages:
   - **Expected**: Messages received correctly
   - **Action if failed**: Check OSC configuration, network, port

## Performance Testing

### 17. Latency Testing

#### 17.1 Sensor Latency
1. Measure time from sensor event to data output:
   - **Expected**: <10ms for IMU, <100ms for GPS
   - **Action if failed**: Optimize firmware, check sensor configuration

#### 17.2 Communication Latency
1. Measure time from data generation to network transmission:
   - **Expected**: <50ms for WiFi, <100ms for Bluetooth
   - **Action if failed**: Optimize firmware, check network configuration

### 18. Throughput Testing

#### 18.1 Data Rate
1. Measure maximum data transmission rate:
   - **Expected**: Up to 50 Mbps (WiFi), 1 Mbps (Bluetooth)
   - **Action if failed**: Check network configuration, firmware optimization

## Environmental Testing

### 19. Temperature Testing

#### 19.1 Operating Temperature
1. Test device at different temperatures:
   - **Range**: 0°C to 50°C (operating)
   - **Expected**: Device functions normally
   - **Action if failed**: Check component specifications, thermal management

### 20. Vibration Testing (Optional)

#### 20.1 Mechanical Stress
1. Subject device to vibration:
   - **Expected**: No component failures, connections remain intact
   - **Action if failed**: Improve mechanical design, component mounting

## Documentation

### Test Results Recording

For each test:
- **Date**: Test date
- **Tester**: Person performing test
- **Device ID**: Serial number or identifier
- **Firmware Version**: Firmware version tested
- **Results**: Pass/Fail with notes
- **Issues**: Any problems encountered
- **Actions Taken**: Corrective actions

### Test Report Template

```
Test Report: NLS Tracker Device
Date: YYYY-MM-DD
Device ID: XXX
Firmware Version: X.X.X

Test Section | Test Item | Result | Notes
-------------|-----------|--------|-------
Power        | 3.3V Rail | PASS   | 3.31V measured
Power        | Battery   | PASS   | 3.85V, charging OK
Processor    | Boot      | PASS   | Serial output OK
WiFi         | Connect   | PASS   | Connected to network
IMU          | Accel     | PASS   | Values correct
...

Issues Found:
- None

Actions Taken:
- None
```

## Related Documentation

- [Assembly Guide](./assembly-guide.md) - Hardware assembly instructions
- [Bill of Materials](./bom.md) - Component list
- [Hardware Architecture](../specifications/architecture.md) - System design
- [Firmware Documentation](../../02-software/firmware/) - Firmware testing

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
