# Connectivity Specifications

## Overview

This document details the communication interfaces and connectivity options for the NLS Artist Systems tracker device. The device supports multiple communication protocols to enable flexible integration with various systems and networks.

## WiFi Connectivity

### WiFi Standards

#### WiFi 4 (802.11n) - Standard
- **Frequency Bands**: 2.4GHz
- **Channels**: 1-14 (region dependent)
- **Data Rates**: Up to 150 Mbps (1x1 MIMO)
- **Range**: Up to 100m (open space), 30-50m (indoor)
- **Power Consumption**: ~80mA active, <5µA sleep
- **Implementation**: Built into ESP32-S3

#### WiFi 6 (802.11ax) - Optional
- **Frequency Bands**: 2.4GHz and 5GHz
- **Data Rates**: Up to 600 Mbps
- **Features**: OFDMA, MU-MIMO, Target Wake Time (TWT)
- **Power Consumption**: More efficient than WiFi 4
- **Implementation**: External module or ESP32-C6

### WiFi Configuration

#### Access Point (AP) Mode
- **Use Case**: Direct device-to-device communication
- **SSID**: Configurable (e.g., "NLS-Tracker-XXXX")
- **Security**: WPA2/WPA3
- **IP Range**: 192.168.4.x (default)

#### Station (STA) Mode
- **Use Case**: Connect to existing WiFi network
- **Configuration**: 
  - WPS (WiFi Protected Setup)
  - Manual SSID/password entry
  - Web-based configuration portal
- **IP Assignment**: DHCP or static IP

#### WiFi Direct (P2P)
- **Use Case**: Direct peer-to-peer communication
- **Range**: Up to 200m
- **Implementation**: ESP32 supports WiFi Direct

### WiFi Antenna Options

#### PCB Antenna (Integrated)
- **Type**: Printed circuit board antenna
- **Gain**: ~2 dBi
- **Range**: Good for indoor use
- **Cost**: Included in module

#### External Antenna
- **Type**: IPEX/U.FL connector
- **Antenna Options**:
  - 2.4GHz dipole antenna (~2-3 dBi)
  - Directional antenna (~8-12 dBi)
- **Range**: Extended range for outdoor use
- **Use Case**: Fixed installations, longer range

## Bluetooth Connectivity

### Bluetooth Standards

#### Bluetooth Low Energy (BLE) 5.0
- **Frequency**: 2.4GHz ISM band
- **Range**: 
  - Standard: Up to 10m
  - Long Range: Up to 100m (with coded PHY)
- **Data Rate**: Up to 2 Mbps
- **Power Consumption**: Very low (~10mA active, <1µA sleep)
- **Implementation**: Built into ESP32-S3

#### Bluetooth Classic (Optional)
- **Profiles**: A2DP, HFP, HSP, SPP
- **Range**: Up to 10m
- **Power Consumption**: Higher than BLE
- **Use Case**: Audio streaming, legacy device support

### BLE Services & Characteristics

#### Device Information Service
- **Service UUID**: 0x180A
- **Characteristics**:
  - Manufacturer Name
  - Model Number
  - Firmware Version
  - Serial Number

#### Custom NLS Service
- **Service UUID**: Custom (e.g., 0x1234-5678-9ABC-DEF0)
- **Characteristics**:
  - Sensor Data (notify)
  - Configuration (read/write)
  - Control Commands (write)
  - Status (notify)

### Bluetooth Pairing

#### Just Works (No Authentication)
- **Use Case**: Public data, low security requirements
- **Security**: None

#### Passkey Entry
- **Use Case**: User authentication
- **Security**: 6-digit PIN

#### Numeric Comparison
- **Use Case**: Device-to-device pairing
- **Security**: User confirmation

## Ethernet Connectivity (Optional)

### Ethernet Standards

#### 10/100 Mbps Ethernet
- **Standard**: IEEE 802.3
- **Interface**: SPI (via W5500 controller)
- **Connector**: RJ45
- **Cable**: Cat5e or better
- **Power**: Via PoE (Power over Ethernet) optional

#### Power over Ethernet (PoE)
- **Standard**: IEEE 802.3af (PoE) or 802.3at (PoE+)
- **Power**: 
  - PoE: 12.95W @ 48V
  - PoE+: 25.5W @ 48V
- **Use Case**: Fixed installations, network-powered devices

### Ethernet Configuration

#### Static IP
- **IP Address**: Configurable
- **Subnet Mask**: Configurable
- **Gateway**: Configurable
- **DNS**: Configurable

#### DHCP
- **Automatic Configuration**: IP, subnet, gateway, DNS
- **Use Case**: Standard network integration

## LoRaWAN Connectivity (Optional)

### LoRaWAN Standards

#### LoRaWAN 1.0.3
- **Frequency Bands**: 
  - EU868: 868.1-868.5 MHz
  - US915: 902-928 MHz
  - AS923: 923-925 MHz
- **Range**: Up to 5km (urban), up to 15km (rural)
- **Data Rate**: 0.3-50 kbps
- **Power Consumption**: Very low (~50mA TX, <1mA sleep)

### LoRaWAN Classes

#### Class A (Bidirectional)
- **Uplink**: Device-initiated
- **Downlink**: Two receive windows after uplink
- **Power**: Lowest power consumption
- **Use Case**: Battery-powered sensors

#### Class B (Beacon)
- **Uplink**: Device-initiated
- **Downlink**: Scheduled receive windows
- **Power**: Low power with scheduled reception
- **Use Case**: Time-synchronized applications

#### Class C (Continuous)
- **Uplink**: Device-initiated
- **Downlink**: Continuous reception
- **Power**: Higher power consumption
- **Use Case**: Mains-powered devices

### LoRaWAN Configuration

#### OTAA (Over-The-Air Activation)
- **AppEUI**: Application EUI
- **AppKey**: Application Key
- **DevEUI**: Device EUI
- **Use Case**: Production deployment

#### ABP (Activation By Personalization)
- **DevAddr**: Device Address
- **NwkSKey**: Network Session Key
- **AppSKey**: Application Session Key
- **Use Case**: Development and testing

## Communication Protocols

### MQTT

#### Overview
- **Purpose**: Telemetry and control
- **Port**: 1883 (non-TLS), 8883 (TLS)
- **QoS Levels**: 0, 1, 2
- **Keep Alive**: 60 seconds (configurable)

#### Topics Structure
```
nls/tracker/{device_id}/sensors/data
nls/tracker/{device_id}/sensors/status
nls/tracker/{device_id}/control/commands
nls/tracker/{device_id}/config/update
```

#### Message Format
- **Format**: JSON
- **Encoding**: UTF-8
- **Size**: Up to 256KB (configurable)

### WebSocket

#### Overview
- **Purpose**: Real-time bidirectional communication
- **Port**: 80 (HTTP), 443 (HTTPS)
- **Protocol**: WebSocket (RFC 6455)
- **Use Case**: Web applications, real-time dashboards

#### Message Format
- **Format**: JSON or binary
- **Frame Size**: Up to 64KB

### OSC (Open Sound Control)

#### Overview
- **Purpose**: Integration with audio/visual systems
- **Port**: 57120 (default), configurable
- **Protocol**: UDP or TCP
- **Use Case**: TidalCycles, SuperCollider, VDMX integration

#### Message Format
```
/sensor/accel/x float32
/sensor/accel/y float32
/sensor/accel/z float32
/sensor/gyro/x float32
/sensor/gyro/y float32
/sensor/gyro/z float32
/tracker/position/x float32
/tracker/position/y float32
/tracker/position/z float32
```

### HTTP/HTTPS

#### Overview
- **Purpose**: REST API, firmware updates, configuration
- **Port**: 80 (HTTP), 443 (HTTPS)
- **Methods**: GET, POST, PUT, DELETE
- **Use Case**: Web interface, API access

#### REST API Endpoints
```
GET  /api/v1/status
GET  /api/v1/sensors
POST /api/v1/config
GET  /api/v1/firmware/version
POST /api/v1/firmware/update
```

### CoAP (Constrained Application Protocol)

#### Overview
- **Purpose**: Lightweight IoT communication
- **Port**: 5683 (UDP)
- **Features**: RESTful, low overhead
- **Use Case**: Low-power sensor networks

## Network Security

### TLS/SSL

#### TLS Versions
- **TLS 1.2**: Minimum supported version
- **TLS 1.3**: Recommended (when available)

#### Certificate Management
- **CA Certificates**: Pre-installed or OTA update
- **Device Certificates**: 
  - Pre-provisioned (production)
  - Self-signed (development)
  - Certificate enrollment (enterprise)

### Authentication

#### API Keys
- **Format**: UUID or random string
- **Storage**: Secure storage (encrypted)
- **Use Case**: REST API authentication

#### OAuth 2.0 (Optional)
- **Grant Types**: Client credentials, device flow
- **Use Case**: Cloud service integration

### Encryption

#### Data Encryption
- **At Rest**: AES-256 (storage)
- **In Transit**: TLS 1.2/1.3 (network)
- **Key Management**: Hardware security module (HSM) optional

## Network Configuration

### Web Configuration Portal

#### Access
- **URL**: http://192.168.4.1 (AP mode)
- **Authentication**: None (initial setup), password (configured)

#### Configuration Options
- WiFi credentials
- Network settings (IP, DNS, gateway)
- Device name and identification
- Security settings
- Firmware update

### mDNS (Multicast DNS)

#### Service Discovery
- **Service Name**: `_nls-tracker._tcp.local`
- **Hostname**: `nls-tracker-{device_id}.local`
- **Use Case**: Automatic device discovery on local network

## Performance Specifications

### Latency

#### WiFi
- **Local Network**: <10ms
- **Internet**: Depends on connection

#### Bluetooth BLE
- **Connection Interval**: 7.5ms - 4s (configurable)
- **Latency**: Connection interval + processing time

#### LoRaWAN
- **Uplink**: 1-3 seconds (depending on data rate)
- **Downlink**: 1-3 seconds (Class A)

### Throughput

#### WiFi
- **TCP**: Up to 50 Mbps (practical)
- **UDP**: Up to 100 Mbps (practical)

#### Bluetooth BLE
- **Throughput**: Up to 1 Mbps (practical)

#### LoRaWAN
- **Throughput**: 0.3-50 kbps (depending on data rate and region)

### Range

#### WiFi
- **Indoor**: 30-50m
- **Outdoor**: Up to 100m

#### Bluetooth BLE
- **Standard**: Up to 10m
- **Long Range**: Up to 100m

#### LoRaWAN
- **Urban**: Up to 2-5km
- **Rural**: Up to 15km

## Related Documentation

- [Hardware Architecture](./architecture.md) - System architecture overview
- [Hardware Components](./components.md) - Component specifications
- [Power Management](./power-management.md) - Power system design
- [Software Protocols](../02-software/protocols/) - Protocol implementation details

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
