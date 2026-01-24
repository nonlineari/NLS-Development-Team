# Assembly Guide

## Overview

This guide provides step-by-step instructions for assembling the NLS Artist Systems tracker device. Follow these instructions carefully to ensure proper assembly and functionality.

## Prerequisites

### Tools Required
- **Soldering Iron**: Temperature-controlled, 60W recommended
- **Solder**: Lead-free solder (0.8mm diameter recommended)
- **Flux**: Rosin flux (optional but recommended)
- **Multimeter**: For testing continuity and voltage
- **Tweezers**: Fine-point tweezers for small components
- **Wire Cutters**: For trimming component leads
- **Desoldering Braid/Wick**: For correcting mistakes
- **Magnifying Glass/Loupe**: For inspecting solder joints
- **Heat Gun**: For heat shrink tubing (optional)

### Materials Required
- **PCB**: Fabricated PCB (see PCB design files)
- **Components**: All components from BOM
- **Enclosure**: 3D printed or purchased enclosure
- **Screws**: M3x6mm or M3x8mm (4x)
- **Standoffs**: M3 female-female standoffs (4x, optional)

### Safety Precautions
- **Work in well-ventilated area**: Solder fumes can be harmful
- **Use eye protection**: When cutting leads or soldering
- **Avoid static electricity**: Use anti-static mat and wrist strap
- **Handle batteries carefully**: LiPo batteries can be dangerous if mishandled
- **Check polarity**: Always verify component orientation before soldering

## Assembly Steps

### Step 1: Prepare the PCB

#### 1.1 Inspect PCB
- Check for any visible defects or damage
- Verify all pads and traces are intact
- Clean PCB with isopropyl alcohol if needed

#### 1.2 Apply Solder Paste (Optional, for SMT components)
- Use stencil if available
- Apply solder paste to pads
- Use reflow oven or hot plate for SMT assembly

**Note**: This guide assumes hand soldering. For production, consider SMT assembly.

### Step 2: Solder Passive Components

#### 2.1 Resistors
1. Identify resistor values using color codes or markings
2. Place resistors on PCB according to silkscreen markings
3. Bend leads to hold component in place
4. Solder one lead, then the other
5. Trim excess leads close to PCB

**Order**: Start with smallest/lowest profile components first.

#### 2.2 Capacitors
1. **Ceramic Capacitors**: 
   - Non-polarized, can be placed either direction
   - Solder and trim leads
2. **Electrolytic Capacitors** (if used):
   - **Important**: Check polarity! Negative lead marked with stripe
   - Place negative lead in pad marked with "-" or stripe
   - Solder and trim leads

#### 2.3 Inductors (if used)
1. Place inductor on PCB
2. Solder both leads
3. Trim excess leads

### Step 3: Solder Power Management Components

#### 3.1 Voltage Regulators
1. **AMS1117-3.3**:
   - Identify pinout (input, ground, output)
   - Place on PCB with correct orientation
   - Solder all pins
   - Attach heatsink if needed (for high current)

2. **TP4056 Battery Charger**:
   - Identify pinout (see datasheet)
   - Place on PCB with correct orientation
   - Solder all pins

#### 3.2 Power Connectors
1. **USB-C Connector**:
   - Place on PCB
   - Solder all pins (check for proper alignment)
   - Verify mechanical stability

2. **Battery Connector (JST-PH)**:
   - Place on PCB
   - **Important**: Verify polarity! Red = positive, Black = negative
   - Solder both pins

### Step 4: Solder Main Processor

#### 4.1 ESP32-S3 Module
1. **Important**: Handle carefully to avoid static damage
2. Place module on PCB with correct orientation
3. Align all pins with pads
4. Solder one corner pin first to hold in place
5. Check alignment, then solder remaining pins
6. **Tip**: Use fine-tip soldering iron and small amount of solder

**Alternative**: If using module with castellated holes, use hot air rework station.

### Step 5: Solder Communication Modules

#### 5.1 WiFi/Bluetooth Antenna (if external)
1. Place IPEX/U.FL connector on PCB
2. Solder connector
3. Connect antenna cable (if using external antenna)

#### 5.2 LoRa Module (if used)
1. Place LoRa module on PCB or use breakout board
2. Connect via SPI interface
3. Solder connections

#### 5.3 Ethernet Module (if used)
1. Place W5500 module on PCB
2. Connect via SPI interface
3. Solder RJ45 connector with magnetics

### Step 6: Solder Sensors

#### 6.1 IMU (MPU-6050 or MPU-9250)
1. Place IMU module on PCB or use breakout board
2. Connect via I2C interface
3. **Important**: Verify I2C address (usually 0x68 or 0x69)
4. Solder connections

#### 6.2 GPS Module (if used)
1. Place GPS module on PCB
2. Connect via UART interface
3. Ensure good antenna placement (away from metal)
4. Solder connections

#### 6.3 Environmental Sensors (if used)
1. Place sensors on PCB or use breakout boards
2. Connect via I2C or SPI
3. Solder connections

### Step 7: Solder Display

#### 7.1 OLED Display (SSD1306)
1. Place display module on PCB or use breakout board
2. Connect via I2C interface
3. **Important**: Verify I2C address (usually 0x3C or 0x3D)
4. Solder connections

#### 7.2 E-Ink Display (if used)
1. Place display module on PCB
2. Connect via SPI interface
3. Solder connections

### Step 8: Solder Audio Components

#### 8.1 Microphone (INMP441)
1. Place microphone module on PCB
2. Connect via I2S interface
3. **Important**: Verify pinout (VDD, GND, WS, SCK, SD)
4. Solder connections

#### 8.2 Audio Output (if used)
1. Place DAC/amplifier module on PCB
2. Connect via I2S interface
3. Solder connections

### Step 9: Solder Connectors and Headers

#### 9.1 Expansion Headers
1. Place pin headers on PCB
2. Solder all pins
3. **Tip**: Use header as support while soldering

#### 9.2 Status LEDs
1. Place LEDs on PCB
2. **Important**: Check polarity! Long lead = positive (anode)
3. Solder and trim leads
4. Add current-limiting resistors if not on PCB

#### 9.3 Switches/Buttons
1. Place tactile switches on PCB
2. Solder all pins
3. Test button action

### Step 10: Final Assembly

#### 10.1 Visual Inspection
- Check all solder joints for quality
- Look for cold solder joints, bridges, or missing connections
- Verify component orientation
- Check for any damaged components

#### 10.2 Continuity Testing
- Use multimeter to test:
  - Power rails (no shorts to ground)
  - Signal connections (as applicable)
  - Component connections

#### 10.3 Install in Enclosure
1. Place PCB in bottom enclosure
2. Align mounting holes
3. Install standoffs (if used)
4. Secure with screws
5. Attach top enclosure
6. **Important**: Ensure no shorts between PCB and enclosure

#### 10.4 Install Battery
1. **Important**: Verify battery polarity before connecting!
2. Connect battery to JST-PH connector
3. Secure battery in enclosure (use double-sided tape or holder)
4. **Safety**: Ensure battery cannot short circuit

## Testing After Assembly

### Initial Power-On Test

#### 1. Connect USB-C Cable
- Connect USB-C cable to computer or power supply
- **Do not connect battery yet**
- Check for any smoke, heat, or unusual behavior

#### 2. Check Power Rails
- Use multimeter to verify:
  - 3.3V rail: Should read ~3.3V
  - 5V rail (if present): Should read ~5V
  - Battery voltage: Should read ~3.7V (if battery connected)

#### 3. Check Status LEDs
- Power LED should light up
- Charging LED should indicate charging status (if battery connected)

### Functional Testing

#### 1. Firmware Upload
- Connect to computer via USB
- Upload test firmware (blink LED, serial output)
- Verify device is recognized

#### 2. Sensor Testing
- Test IMU: Check for data output
- Test GPS: Verify satellite lock (outdoors)
- Test other sensors: Verify data output

#### 3. Communication Testing
- WiFi: Connect to network, verify connectivity
- Bluetooth: Pair with device, verify connection
- LoRaWAN: Test communication (if applicable)

#### 4. Display Testing
- OLED: Display test pattern
- E-Ink: Update display (if applicable)

## Troubleshooting

### Common Issues

#### No Power
- **Check**: USB cable connection
- **Check**: Power switch (if present)
- **Check**: Voltage regulator connections
- **Check**: Short circuits on power rails

#### Components Not Working
- **Check**: Solder joints (reflow if needed)
- **Check**: Component orientation
- **Check**: Connections (continuity test)
- **Check**: Power supply to component

#### Communication Issues
- **Check**: Antenna connections
- **Check**: Pull-up resistors on I2C/SPI
- **Check**: Signal integrity (oscilloscope if available)

#### Battery Not Charging
- **Check**: Battery polarity
- **Check**: Charger IC connections
- **Check**: Charging current setting
- **Check**: Battery protection circuit

## Safety Notes

### Battery Safety
- **Never short circuit** LiPo battery terminals
- **Never overcharge** battery (use proper charger)
- **Never puncture** or damage battery
- **Store** battery in fireproof container when not in use
- **Dispose** of battery properly (recycling center)

### Soldering Safety
- **Ventilation**: Work in well-ventilated area
- **Eye Protection**: Wear safety glasses
- **Heat**: Be careful with hot soldering iron
- **Burns**: Allow components to cool before handling

## Next Steps

After successful assembly:
1. Upload firmware (see software documentation)
2. Configure device (see configuration guide)
3. Test all features (see testing procedures)
4. Deploy device (see deployment guide)

## Related Documentation

- [Bill of Materials](./bom.md) - Complete parts list
- [Testing Procedures](./testing-procedures.md) - Detailed testing guide
- [Hardware Architecture](../specifications/architecture.md) - System design
- [Hardware Components](../specifications/components.md) - Component details

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
