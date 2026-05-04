# Kinetic Energy Storage System (KESS)

[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
[![Factorio Version](https://img.shields.io/badge/Factorio-2.0-blue.svg)](https://www.factorio.com/)

A high-capacity late-game energy storage solution for Factorio 2.0 (Space Age). This mod introduces a massive 3x3 flywheel accumulator designed to handle the extreme power demands of interstellar factories.

## Features

- **Massive Capacity**: Stores up to **10 Gigajoules (GJ)** of energy.
- **High Power Flow**: Supports **100 Megawatts (MW)** of input and output power.
- **Full Circuit Support**: Seamlessly integrate with your power management systems.
- **Configurable Energy Decay**: Simulates real-world mechanical friction and air resistance (self-discharge).

## Energy Decay Mechanic

To reflect the physical reality of flywheel storage, KESS units experience a gradual loss of energy over time (Internal Leak).

- **Default Rate**: 0.5% of total capacity lost per hour.
- **Shadow Drain**: Implemented using a high-performance "shadow proxy" system that ensures perfectly smooth power graphs and zero UPS impact.
- **Configurable**: Both the feature toggle and the decay rate can be adjusted in the **Startup Mod Settings**.

## Crafting Requirements

- 5000x Steel Plate
- 2000x Copper Plate
- 100x Electric Engine Unit
- 100x Advanced Circuit
- 100x Carbon Fiber

## Research

Unlocked via the **Kinetic Energy Storage System** technology, which requires:
- Electric Energy Distribution 2
- Electric Engine
- Carbon Fiber

## Installation

### Method 1: In-Game Mod Manager (Recommended)
1. Open Factorio and click on **Install Mods** in the main menu.
2. Search for **Kinetic Energy Storage System (KESS)**.
3. Click **Install** and restart the game when prompted.

### Method 2: Factorio Mod Portal
1. Visit the [Kinetic Energy Storage System (KESS) on the Mod Portal](https://mods.factorio.com/mod/KESS).
2. Download the mod and place the `.zip` file into your Factorio `mods` directory.
3. Launch Factorio.

### Method 3: Manual (GitHub)
1. Download or clone this repository into your Factorio `mods` folder.
2. Ensure the directory is named `KESS`.
3. Launch Factorio and enable the mod.

## Credits & License

- **Design & Code**: Developed with Gemini CLI.
- **Graphics**: Generated using **Nanobanana 2** (background and cropping adjusted by the user).
- **License**: This mod is released under the **BSD 3-Clause License**. See the `LICENSE` file for more details.

---
*Built for Factorio 2.0 (Space Age).*
