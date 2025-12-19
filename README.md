# toplap-nls

**TidalCycles Live Coding Environment with Visual Music Integration**

A comprehensive resource repository for audio-visual live coding using TidalCycles, SuperCollider, and computer vision integration. Created by Jimmy Howe / NLS Records.

[![TidalCycles](https://img.shields.io/badge/TidalCycles-v1.9.5-blue)](https://tidalcycles.org)
[![SuperCollider](https://img.shields.io/badge/SuperCollider-3.13-orange)](https://supercollider.github.io)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

---

## Overview

This repository provides:
- **Comprehensive TidalCycles documentation** - 10 learning manuals from beginner to advanced
- **Installation and setup guides** - For VS Code, SuperCollider, and multimodal environments
- **Project templates** - Ready-to-use templates for live coding sessions
- **Visual detection integration** - Object detection with Darknet/YOLO for reactive performances
- **THE FORMAT™ framework** - Executive and infrastructure documentation for web3 music events

---

## Quick Start

### Prerequisites

- **macOS** (tested on Sequoia)
- **Homebrew** package manager
- **Git** version control

### Installation

1. **Clone this repository**
   ```bash
   git clone https://github.com/nonlineari/toplap-nls.git
   cd toplap-nls
   ```

2. **Install core dependencies**
   ```bash
   # Install Haskell (GHCup)
   curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
   
   # Install SuperCollider
   brew install --cask supercollider
   
   # Install TidalCycles
   cabal update
   cabal install tidal
   ```

3. **Follow detailed guides**
   - [Installation Guide](Toplap-nls/tidalcycles/INSTALLATION-GUIDE.md)
   - [VS Code Setup](Toplap-nls/tidalcycles/VSCODE-SETUP.md)
   - [Multimodal Setup](Toplap-nls/tidalcycles/MULTIMODAL-SETUP.md)

---

## Repository Structure

```
toplap-nls/
├── README.md                          # This file
├── WARP.md                            # AI assistant guidance
├── Toplap-nls/tidalcycles/           # TidalCycles resources
│   ├── livecode-manuals/             # 10 comprehensive manuals
│   │   ├── 01-getting-started.md
│   │   ├── 02-pattern-basics.md
│   │   ├── 03-samples-and-synths.md
│   │   ├── 04-effects.md
│   │   ├── 05-advanced-patterns.md
│   │   ├── 06-scales-and-melody.md
│   │   ├── 07-performance-techniques.md
│   │   ├── 08-midi-osc-integration.md
│   │   ├── 09-troubleshooting.md
│   │   └── 10-reference-quick.md
│   ├── projects/                     # Project templates
│   │   ├── built/                    # Basic TidalCycles template
│   │   ├── renoise/                  # Renoise MIDI integration
│   │   ├── ffmpeg Cmd Data/          # Metadata embedding scripts
│   │   └── visual-shaders/           # GLSL shader examples
│   ├── INSTALLATION-GUIDE.md
│   ├── VSCODE-SETUP.md
│   ├── MULTIMODAL-SETUP.md
│   ├── startup.scd                   # SuperCollider auto-start config
│   └── install-superdirt.scd         # SuperDirt installation
├── projects/visual-detection/        # Computer vision integration
│   ├── README.md                     # Integration guide
│   └── algorithm.md                  # Implementation plan
└── the-format/                       # THE FORMAT™ framework
    ├── executive-orchestration.md
    ├── Nexus.md
    ├── NeXT.md
    ├── Contact.md
    ├── Modular-of-end-user.md
    └── Satoshi Dreams Nakamoto.md
```

---

## Documentation

### TidalCycles Learning Path

**Beginner** (Start here)
1. [Getting Started](Toplap-nls/tidalcycles/livecode-manuals/01-getting-started.md) - Installation and first patterns
2. [Pattern Basics](Toplap-nls/tidalcycles/livecode-manuals/02-pattern-basics.md) - Mini-notation and sequencing
3. [Samples and Synths](Toplap-nls/tidalcycles/livecode-manuals/03-samples-and-synths.md) - Sound sources
4. [Effects](Toplap-nls/tidalcycles/livecode-manuals/04-effects.md) - Audio processing

**Intermediate**
5. [Advanced Patterns](Toplap-nls/tidalcycles/livecode-manuals/05-advanced-patterns.md) - Transformations and combinations
6. [Scales and Melody](Toplap-nls/tidalcycles/livecode-manuals/06-scales-and-melody.md) - Musical theory integration
7. [Performance Techniques](Toplap-nls/tidalcycles/livecode-manuals/07-performance-techniques.md) - Live coding strategies

**Advanced**
8. [MIDI/OSC Integration](Toplap-nls/tidalcycles/livecode-manuals/08-midi-osc-integration.md) - External control
9. [Troubleshooting](Toplap-nls/tidalcycles/livecode-manuals/09-troubleshooting.md) - Common issues
10. [Quick Reference](Toplap-nls/tidalcycles/livecode-manuals/10-reference-quick.md) - Command cheat sheet

### Setup Guides

- **[Installation Guide](Toplap-nls/tidalcycles/INSTALLATION-GUIDE.md)** - Complete setup from scratch
- **[VS Code Setup](Toplap-nls/tidalcycles/VSCODE-SETUP.md)** - Editor configuration
- **[Multimodal Setup](Toplap-nls/tidalcycles/MULTIMODAL-SETUP.md)** - Audio + visual integration

---

## Visual Detection Integration

Integrate real-time object detection with TidalCycles for reactive performances:

### Features
- **Darknet/YOLO** object detection
- **OSC bridge** for TidalCycles communication
- **Reactive patterns** based on audience detection
- **Custom metrics** (AP50-style for A/V sync)

### Quick Start
```bash
cd projects/visual-detection
cat README.md          # Full integration guide
cat algorithm.md       # Implementation plan
```

### Use Cases
- Detect audience members → modulate sound density
- Track performer gestures → control effects
- Object positions → stereo panning
- Detection confidence → volume control

---

## THE FORMAT™ Framework

Documentation for web3 music event orchestration and executive planning:

- **[Executive Orchestration](the-format/executive-orchestration.md)** - Assembly structure
- **[Nexus](the-format/Nexus.md)** - Programming and engagement strategy
- **[NeXT](the-format/NeXT.md)** - Infrastructure and cost planning
- **[Contact](the-format/Contact.md)** - Revenue streams and metrics
- **[Modular of End-User](the-format/Modular-of-end-user.md)** - Philosophical foundations
- **[Satoshi Dreams Nakamoto](the-format/Satoshi Dreams Nakamoto.md)** - Film concept

---

## Project Templates

### Built Template
Ready-to-use TidalCycles project structure:
```bash
cd Toplap-nls/tidalcycles/projects/built
code built.tidal
```

### Renoise Integration
MIDI control for Renoise DAW:
```bash
cd Toplap-nls/tidalcycles/projects/renoise
cat README-RENOISE.md
```

### FFmpeg Metadata
Embed metadata in recorded performances:
```bash
cd "Toplap-nls/tidalcycles/projects/ffmpeg Cmd Data"
source embed-metadata.sh
```

### Visual Shaders
GLSL shaders for audio-reactive visuals:
```bash
cd Toplap-nls/tidalcycles/projects/visual-shaders
cat audio-reactive.frag
```

---

## Workflow

### Standard Live Coding Session

1. **Start SuperCollider**
   ```supercollider
   s.boot;
   SuperDirt.start;
   ```

2. **Start TidalCycles in VS Code**
   - Open a `.tidal` file
   - Press `Cmd+Shift+Enter` to boot Tidal
   - Press `Shift+Enter` to evaluate patterns

3. **Write patterns**
   ```haskell
   d1 $ sound "bd sd bd sd"
   d2 $ sound "arpy*4" # note "0 2 4 7"
   ```

4. **Stop all**
   ```haskell
   hush
   ```

### With Visual Detection

1. Follow standard setup above
2. Start detection bridge:
   ```bash
   cd projects/visual-detection
   python3 detect_to_osc.py 0  # 0 = webcam
   ```
3. Use detection data in patterns:
   ```haskell
   d1 $ sound "bd*<person_count>" # gain 0.9
   ```

---

## Key Technologies

### Core
- **[TidalCycles](https://tidalcycles.org)** - Pattern-based live coding language (Haskell)
- **[SuperCollider](https://supercollider.github.io)** - Audio synthesis server
- **[SuperDirt](https://github.com/musikinformatik/SuperDirt)** - Sample engine for TidalCycles

### Editors
- **VS Code** - Primary editor with TidalCycles extension
- **Atom/VEDA** - Alternative with GLSL support
- **Hydra** - Browser-based visual synthesis

### Integration
- **OSC** - Open Sound Control protocol
- **MIDI** - Hardware/software control
- **Darknet/YOLO** - Object detection
- **FFmpeg** - Media processing

---

## Community

### Resources
- **TidalCycles Forum**: https://club.tidalcycles.org
- **TOPLAP**: International live coding community
- **Discord**: TidalCycles community server
- **GitHub**: https://github.com/tidalcycles/Tidal

### Credits
- **Created by**: Jimmy Howe ([@jimmyhowe](https://github.com/nonlineari))
- **Label**: NLS Records
- **Platform**: [nlsrecordings.com](https://nlsrecordings.com)

---

## Contributing

Contributions welcome! This repository documents:
- TidalCycles learning resources
- Integration patterns for visual music
- Web3 music event frameworks

Feel free to:
- Report issues
- Submit improvements to documentation
- Share your own patterns and templates
- Contribute integration examples

---

## License

MIT License - See LICENSE file for details

---

## Acknowledgments

- **TidalCycles** by Alex McLean
- **SuperCollider** community
- **TOPLAP** live coding community
- **Darknet/YOLO** by Joseph Redmon, Alexey Bochkovskiy
- **ByteTrack** by Yifu Zhang et al.

---

## Support

- **Issues**: [GitHub Issues](https://github.com/nonlineari/toplap-nls/issues)
- **Discussions**: [GitHub Discussions](https://github.com/nonlineari/toplap-nls/discussions)
- **Contact**: jimmy@nlsrecordings.com

---

**Status**: Active Development  
**Version**: 1.0.0  
**Last Updated**: December 2024

*"Let my people go surfing."*
