# ArcadeInterface

IoT-Enabled Arcade Button Array for API Event Orchestration. A modular system for detecting illuminated arcade button presses via microcontroller/SBC and triggering configurable API calls.

## Overview

This project provides:
- **Hardware design** for interfacing arcade buttons with ESP32 or Raspberry Pi
- **Firmware/software** for event detection and HTTP API orchestration
- **CI/CD pipeline** for automated testing and deployment
- **Scalable architecture** supporting 10-40+ buttons with <50ms latency

## Quick Start

### Installation

**Clone the repository:**
```bash
git clone https://github.com/MatthewPChapdelaine/ArcadeInterface.git
cd ArcadeInterface
```

**Option 1: Raspberry Pi (Recommended)**

```bash
# Install Python package with dev dependencies
pip install -e ".[dev]"

# Install GPIO dependencies
pip install gpiozero requests

# Run the button orchestrator
python -m arcade_interface.orchestrator
```

**Option 2: Node.js**

```bash
npm install
npm test
```

### Build & Test

```bash
# Run all builds and tests
make all

# Build only
make build

# Test only
make test

# Clean artifacts
make clean

# Run CI pipeline
make ci
```

## Architecture

### Three-Tier Design (ESP32 + Host)

1. **Edge Tier**: Arcade buttons wired to microcontroller GPIOs
2. **Gateway Tier**: ESP32 detects presses and sends JSON via WiFi
3. **Host Tier**: Python middleware receives events and invokes APIs

### Standalone Design (Raspberry Pi)

Single-device architecture where the Pi directly:
- Detects button presses via GPIO
- Invokes API endpoints asynchronously
- Logs events and handles errors

## Configuration

Edit your button pins and API endpoint in the configuration file before running:

```python
BUTTON_PINS = [2, 3, 4, 5]  # GPIO pins
API_URL = "https://your-api-endpoint.com/trigger"
DEBOUNCE_TIME = 0.2  # Seconds
```

## API Integration

When a button is pressed, the system sends:
```json
{
  "button_id": 1,
  "event": "button_1_pressed",
  "timestamp": "2025-12-26T10:30:45Z"
}
```

Customize the payload in the orchestrator to match your API expectations.

## Documentation

- See [Professional Developer Design Document](Professional%20Developer%20Design%20Document_%20IoT-Enabled%20Arcade%20Button%20Array%20for%20API%20Event%20Orchestration.md) for detailed architecture, hardware specs, and procurement links
- Includes both ESP32 and Raspberry Pi design alternatives

## Project Structure

```
.
├── Makefile                    # Build targets
├── package.json                # Node.js configuration
├── pyproject.toml              # Python package configuration
├── src/                        # Node.js source
├── test/                       # Node.js tests
├── arcade_interface/           # Python package
│   ├── __init__.py
│   └── orchestrator.py         # Main event handler (Raspberry Pi)
├── tests/                      # Python tests
└── .github/workflows/
    └── build.yml               # GitHub Actions CI/CD
```

## Hardware Requirements

### Raspberry Pi Option
- Raspberry Pi 5 (8GB recommended; ~$80)
- Illuminated arcade buttons (5V LEDs; ~$50 for 20-button kit)
- Breadboard + wiring (~$10)

### ESP32 Option
- ESP32 microcontroller (~$10)
- Illuminated arcade buttons (5V LEDs)
- Host PC with Python Flask middleware

**Total prototype cost: <$150**

## Deployment

### Local Network (LAN)

```bash
# On Raspberry Pi
python -m arcade_interface.orchestrator --host 0.0.0.0 --port 5000
```

### As a Systemd Service

```bash
sudo nano /etc/systemd/system/arcade-interface.service
```

Add:
```ini
[Unit]
Description=ArcadeInterface Button Orchestrator
After=network.target

[Service]
Type=simple
User=pi
WorkingDirectory=/home/pi/ArcadeInterface
ExecStart=/usr/bin/python3 -m arcade_interface.orchestrator
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable and start:
```bash
sudo systemctl enable arcade-interface.service
sudo systemctl start arcade-interface.service
```

## Testing

```bash
# Python tests
pytest tests/

# Node.js tests
npm test

# Manual test
python -c "from arcade_interface import hello; print(hello())"
```

## CI/CD

GitHub Actions workflow automatically:
- Installs dependencies (Node 18.x, 20.x; Python 3.9, 3.11)
- Runs `make build` and `make test` on every push/PR
- Reports results

## License

MIT

## Author

Matthew Chapdelaine

## See Also

- [Raspberry Pi GPIO Documentation](https://www.raspberrypi.com/documentation/computers/gpio.html)
- [gpiozero Library](https://gpiozero.readthedocs.io/)
- [ESP32 Arduino Core](https://github.com/espressif/arduino-esp32)
