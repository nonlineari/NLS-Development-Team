# Network Installation Guide

## Overview

This guide provides step-by-step instructions for installing and configuring the NLS tracker device on a network, including WiFi setup, network configuration, and connectivity verification.

## Prerequisites

- Assembled NLS tracker device
- USB-C cable (for initial setup)
- WiFi network with SSID and password
- Computer or mobile device for configuration
- Network access (for cloud features)

## Installation Methods

### Method 1: WiFi Access Point (AP) Mode (Initial Setup)

#### Step 1: Power On Device
1. Connect USB-C cable to device
2. Connect to computer or power supply
3. Wait for device to boot (LED indicators will show status)

#### Step 2: Connect to Device WiFi
1. On your computer/mobile device, scan for WiFi networks
2. Look for network named: `NLS-Tracker-XXXX` (where XXXX is device ID)
3. Connect to this network
4. **Note**: No password required for initial setup (AP mode)

#### Step 3: Access Web Interface
1. Open web browser
2. Navigate to: `http://192.168.4.1`
3. You should see the device configuration interface

#### Step 4: Configure WiFi Connection
1. Navigate to **Network Settings**
2. Select **WiFi Station (STA) Mode**
3. Enter your WiFi network credentials:
   - **SSID**: Your WiFi network name
   - **Password**: Your WiFi password
4. Click **Save and Connect**

#### Step 5: Verify Connection
1. Device will disconnect from AP mode
2. Device will connect to your WiFi network
3. Check device status LED (should show connected)
4. Note the device's IP address (displayed on web interface)

### Method 2: Direct WiFi Configuration (If AP Mode Not Available)

#### Step 1: Serial Configuration
1. Connect device via USB-C to computer
2. Open serial terminal (115200 baud):
   ```bash
   # Linux/Mac
   screen /dev/ttyUSB0 115200
   
   # Windows
   # Use PuTTY or Arduino Serial Monitor
   ```

#### Step 2: Enter Configuration Mode
1. Press `Enter` to get command prompt
2. Type: `config wifi`
3. Follow prompts to enter SSID and password

#### Step 3: Save and Reboot
1. Type: `config save`
2. Type: `reboot`
3. Device will connect to WiFi network

### Method 3: WPS (WiFi Protected Setup)

#### Step 1: Enable WPS on Router
1. Press WPS button on your WiFi router
2. Router will enter WPS pairing mode (usually 2 minutes)

#### Step 2: Trigger WPS on Device
1. Access device web interface (via AP mode or serial)
2. Navigate to **Network Settings**
3. Click **WPS Connect**
4. Device will automatically connect via WPS

## Network Configuration

### Static IP Configuration (Optional)

#### Via Web Interface
1. Navigate to **Network Settings** → **Advanced**
2. Select **Static IP**
3. Enter:
   - **IP Address**: e.g., `192.168.1.100`
   - **Subnet Mask**: e.g., `255.255.255.0`
   - **Gateway**: e.g., `192.168.1.1`
   - **DNS Server**: e.g., `8.8.8.8`
4. Click **Save**

#### Via Serial/CLI
```bash
config network static
IP: 192.168.1.100
Subnet: 255.255.255.0
Gateway: 192.168.1.1
DNS: 8.8.8.8
config save
reboot
```

### DHCP Configuration (Default)

Device uses DHCP by default. No configuration needed if your network provides DHCP.

## Network Services Configuration

### MQTT Broker Configuration

#### Step 1: Access MQTT Settings
1. Navigate to **Communication** → **MQTT**
2. Enter MQTT broker details:
   - **Broker Address**: e.g., `mqtt.example.com` or `192.168.1.10`
   - **Port**: `1883` (non-TLS) or `8883` (TLS)
   - **Username**: (if required)
   - **Password**: (if required)
   - **Client ID**: Auto-generated or custom

#### Step 2: Enable TLS (Optional but Recommended)
1. Check **Enable TLS**
2. Upload CA certificate (if using self-signed certificate)
3. Click **Save and Connect**

#### Step 3: Verify Connection
1. Check connection status indicator
2. Device should show "Connected" status
3. Test by publishing a test message

### WebSocket Server Configuration

#### Step 1: Enable WebSocket
1. Navigate to **Communication** → **WebSocket**
2. Enable **WebSocket Server**
3. Set **Port**: Default `80` (HTTP) or `443` (HTTPS)

#### Step 2: Configure Security (Optional)
1. Enable **TLS/SSL** for secure WebSocket (WSS)
2. Upload SSL certificate and key
3. Set port to `443`

### OSC Configuration

#### Step 1: Configure OSC
1. Navigate to **Integration** → **OSC**
2. Enable **OSC Output**
3. Enter target address:
   - **Host**: e.g., `127.0.0.1` (local) or IP address
   - **Port**: e.g., `57120` (SuperCollider) or `6010` (TidalCycles)

#### Step 2: Configure OSC Messages
1. Set message address patterns:
   - Accelerometer: `/sensor/accel/x`, `/sensor/accel/y`, `/sensor/accel/z`
   - Gyroscope: `/sensor/gyro/x`, `/sensor/gyro/y`, `/sensor/gyro/z`
2. Set update rate (Hz)
3. Click **Save**

## Network Verification

### Test Connectivity

#### Ping Test
```bash
# From computer on same network
ping 192.168.1.100  # Replace with device IP
```

#### HTTP Test
```bash
# Test web interface
curl http://192.168.1.100/api/v1/status
```

#### MQTT Test
```bash
# Using mosquitto client
mosquitto_sub -h 192.168.1.100 -t "nls/tracker/+/sensors/data"
```

### Check Device Status

#### Via Web Interface
1. Navigate to `http://<device-ip>/status`
2. Check:
   - WiFi connection status
   - IP address
   - Signal strength
   - MQTT connection status
   - Network uptime

#### Via Serial/CLI
```bash
status network
# Shows: IP, Gateway, DNS, Signal Strength, Connection Status
```

## Troubleshooting Network Issues

### Device Not Appearing in WiFi Scan

**Possible Causes:**
- Device not powered on
- Device in STA mode (not AP mode)
- WiFi module not initialized

**Solutions:**
1. Check power LED
2. Reset device (hold reset button 5 seconds)
3. Device should enter AP mode on first boot
4. Check serial output for errors

### Cannot Connect to WiFi Network

**Possible Causes:**
- Incorrect SSID or password
- WiFi network not in range
- Network security incompatible (WPA3 only, etc.)
- MAC address filtering enabled

**Solutions:**
1. Double-check SSID and password (case-sensitive)
2. Move device closer to router
3. Check router security settings
4. Add device MAC address to router whitelist

### Device Connects but No Internet

**Possible Causes:**
- Router not providing internet
- DNS server not configured
- Firewall blocking device

**Solutions:**
1. Test internet on other devices
2. Configure DNS server (8.8.8.8, 1.1.1.1)
3. Check router firewall rules
4. Verify gateway IP address

### MQTT Connection Fails

**Possible Causes:**
- Incorrect broker address
- Firewall blocking port 1883/8883
- Authentication failed
- TLS certificate issues

**Solutions:**
1. Verify broker address and port
2. Check firewall rules
3. Verify username/password
4. Check TLS certificate validity
5. Test with `mosquitto_pub` command

### WebSocket Connection Fails

**Possible Causes:**
- Port blocked by firewall
- TLS certificate issues
- CORS issues (for web clients)

**Solutions:**
1. Check firewall rules for port 80/443
2. Verify SSL certificate
3. Configure CORS headers if needed
4. Test with WebSocket client tool

## Advanced Network Configuration

### Port Forwarding (For Remote Access)

If you need to access device from outside local network:

1. **Router Configuration:**
   - Port forward: External port → Device IP:Port
   - Example: `8080 → 192.168.1.100:80`

2. **Device Configuration:**
   - Use static IP (recommended)
   - Configure firewall rules if applicable

### VPN Configuration (For Secure Remote Access)

1. Set up VPN server (OpenVPN, WireGuard, etc.)
2. Configure device to connect via VPN
3. Access device through VPN tunnel

### mDNS/Bonjour (For Automatic Discovery)

Device supports mDNS for automatic discovery:

- **Service Name**: `_nls-tracker._tcp.local`
- **Hostname**: `nls-tracker-<device-id>.local`

Access device via: `http://nls-tracker-XXXX.local`

## Network Security Best Practices

### 1. Use Strong WiFi Password
- Minimum 12 characters
- Mix of letters, numbers, symbols
- Avoid common passwords

### 2. Enable WPA3 or WPA2
- Use latest WiFi security standard
- Avoid WEP (insecure)

### 3. Use TLS for MQTT
- Enable TLS/SSL for MQTT connections
- Use port 8883 instead of 1883

### 4. Use HTTPS for Web Interface
- Enable SSL/TLS for web interface
- Use port 443 instead of 80

### 5. Network Segmentation
- Place device on separate VLAN if possible
- Use firewall rules to restrict access
- Only allow necessary ports

### 6. Regular Updates
- Keep device firmware updated
- Update router firmware
- Monitor for security advisories

## Network Monitoring

### Device Network Statistics

Access via web interface or API:
```
GET /api/v1/network/stats
Response: {
  "wifi": {
    "ssid": "MyNetwork",
    "signal_strength": -45,
    "connected": true,
    "ip": "192.168.1.100"
  },
  "mqtt": {
    "connected": true,
    "messages_sent": 1234,
    "messages_received": 56
  },
  "uptime": 3600
}
```

### Log Monitoring

Check network logs via serial or web interface:
```bash
# Serial
log network

# Web interface
Navigate to: System → Logs → Network
```

## Related Documentation

- [Hardware Setup](./hardware-setup.md) - Initial hardware setup
- [Software Setup](./software-setup.md) - Software installation
- [MQTT Protocol](../../02-software/protocols/mqtt.md) - MQTT details
- [WebSocket Protocol](../../02-software/protocols/websocket.md) - WebSocket details
- [OSC Protocol](../../02-software/protocols/osc.md) - OSC configuration
- [Network Troubleshooting](../../08-troubleshooting/software-issues/network-problems.md) - Network issue resolution

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
