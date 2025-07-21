# RaziTV

RaziTV turns a Raspberry Pi into a self-configuring kiosk device. On first boot, it starts a WiFi hotspot and serves a local configuration page. Once connected to WiFi, it launches a full-screen browser with a device-specific activation URL.

## 💡 Features

- Automatic WiFi detection and setup
- Local hotspot mode for first-time setup
- Web-based interface to enter SSID and password
- Launches Chromium in full-screen kiosk mode to a unique activation page
- Designed for use with Razi Title’s activation flow

## ⚡ Getting Started

### 1. Download the Image

Head to the [Releases](https://github.com/YOUR_USERNAME/razitv/releases) page and download the latest `.zip` file containing the `.img` disk image.

### 2. Flash the Image to an SD Card

Use one of the following tools:

- [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
- [balenaEtcher](https://www.balena.io/etcher/)

> Select the `.img` file from the downloaded `.zip` and write it to a microSD card (8GB or larger recommended).

### 3. Boot the Pi

Insert the flashed SD card into your Raspberry Pi and power it on.

- If the Pi doesn't detect a known WiFi network, it will start a hotspot: `RaziTV-Setup`.
- Connect to that network with your phone or laptop.
- Open a browser and go to [http://192.168.4.1](http://192.168.4.1) to enter your WiFi credentials.
- Once configured, the Pi will reboot and connect to WiFi automatically.

### 4. Automatic Activation

Once online, the Pi will display a browser pointed to:

```

[https://razititle.com/activate/](https://razititle.com/activate/)\<DEVICE\_ID>

```

where `<DEVICE_ID>` is the Pi’s unique serial number.


Made with ❤️ by the Razi team.
