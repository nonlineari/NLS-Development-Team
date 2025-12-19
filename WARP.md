# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is a TidalCycles live coding environment resource repository containing:
- Comprehensive documentation and manuals for learning TidalCycles
- Installation guides for multiple editor setups (VS Code, Atom/VEDA, Hydra)
- SuperCollider configuration files
- Integration guides for MIDI, Renoise, and multi-modal (audio + visual) live coding
- Project templates and examples

**TidalCycles** is a Haskell-based live coding environment for creating algorithmic music patterns that integrates with SuperCollider and SuperDirt for audio synthesis.

## File Structure

```
Toplap-nls/tidalcycles/
├── livecode-manuals/          # 10 comprehensive TidalCycles learning manuals
│   ├── 01-getting-started.md
│   ├── 02-pattern-basics.md
│   ├── 03-samples-and-synths.md
│   ├── 04-effects.md
│   ├── 05-advanced-patterns.md
│   ├── 06-scales-and-melody.md
│   ├── 07-performance-techniques.md
│   ├── 08-midi-osc-integration.md
│   ├── 09-troubleshooting.md
│   └── 10-reference-quick.md  # Quick reference for commands
├── projects/                   # User projects and sessions
│   ├── built/                 # Example TidalCycles project template
│   ├── ffmpeg Cmd Data/       # FFmpeg metadata embedding scripts and docs
│   ├── renoise/               # Renoise integration examples
│   └── visual-shaders/        # GLSL/visual live coding
├── startup.scd                # SuperCollider auto-start config
├── install-superdirt.scd      # SuperDirt installation script
├── README.md                  # Main documentation
├── INSTALLATION-GUIDE.md      # Complete setup guide
├── VSCODE-SETUP.md            # VS Code configuration
└── MULTIMODAL-SETUP.md        # Audio + visual integration
```

## Key System Components

### Core Stack
1. **SuperCollider** - Audio synthesis engine (located at `/Applications/SuperCollider.app`)
2. **SuperDirt** - Sample library and synthesis engine (runs within SuperCollider)
3. **Haskell/GHCi** - TidalCycles runtime (at `~/.ghcup/bin/ghci`)
4. **TidalCycles** - Pattern language and live coding environment (v1.9.5)

### Editor Support
- **VS Code** - Primary editor with TidalCycles extension
- **Atom + VEDA** - Alternative for integrated GLSL visual coding
- **Hydra** - Browser-based visual synthesis (https://hydra.ojack.xyz)

## Common Commands

### SuperCollider (in SuperCollider IDE)
```supercollider
// Boot audio server
s.boot;

// Start SuperDirt (required for TidalCycles)
SuperDirt.start

// Check if SuperDirt is running
~dirt.postln;

// Install SuperDirt (one-time setup)
Quarks.checkForUpdates({
    Quarks.install("SuperDirt", "v1.7.3");
    Quarks.install("SC3plugins");
    thisProcess.recompile();
});

// Test audio output
{ SinOsc.ar(440) * 0.1 }.play;
```

### TidalCycles (in .tidal files)
```haskell
-- Boot Tidal in VS Code: Cmd+Shift+Enter
-- Evaluate line/selection: Shift+Enter

-- Basic drum pattern
d1 $ sound "bd sd bd sd"

-- Stop one channel
d1 silence

-- Stop all channels
hush

-- Set tempo (120 BPM)
setcps (120/60/4)

-- Layer multiple patterns
d1 $ stack [
  sound "bd*4",
  sound "~ sd",
  sound "hh*8" # gain 0.6
]
```

### VS Code Extension
```bash
# Install TidalCycles extension
code --install-extension tidalcycles.vscode-tidalcycles

# VS Code keyboard shortcuts:
# - Boot Tidal: Cmd+Shift+Enter
# - Evaluate: Shift+Enter
# - Stop all: Cmd+Alt+H
```

### File Management
```bash
# Open SuperCollider
open /Applications/SuperCollider.app

# Create new Tidal session from template
cd Toplap-nls/tidalcycles/projects
cp -r built my-new-project
cd my-new-project
code *.tidal

# Or create a simple session from scratch
cd Toplap-nls/tidalcycles/projects
mkdir my-session && cd my-session
touch my-session.tidal
code my-session.tidal

# Copy startup config for auto-start SuperDirt
mkdir -p ~/Library/Application\ Support/SuperCollider
cp Toplap-nls/tidalcycles/startup.scd ~/Library/Application\ Support/SuperCollider/startup.scd
```

### FFmpeg Metadata Embedding (for recorded sessions)
```bash
# Navigate to ffmpeg tools
cd Toplap-nls/tidalcycles/projects/ffmpeg\ Cmd\ Data

# Source the metadata embedding function
source embed-metadata.sh

# Embed metadata into recorded MP4 files
ffmpeg_embed_metadata "input.mp4" "output.mp4" "Album Name" "1" "Artist Name" "Label" "2024"

# Verify embedded metadata
ffprobe -v error -show_entries format_tags=album,artist,date,publisher,track -of default=noprint_wrappers=1 output.mp4

# Quick one-liner without function
ffmpeg -i input.mp4 -c copy \
  -metadata album="Live Coding Session 2024" \
  -metadata artist="Your Name" \
  -metadata date="2024" \
  output.mp4
```

## Development Workflow

### Starting a New Project
The `projects/built/` directory serves as a template for new TidalCycles projects:
```bash
cd Toplap-nls/tidalcycles/projects
cp -r built my-new-project
cd my-new-project
git init  # Initialize version control for your project
code *.tidal
```

Template structure:
- `built.tidal` - Main pattern file with channel setup (d1-d4)
- `README.md` - Project documentation
- `.gitignore` - Git exclusions

### Standard Live Coding Session
1. **Start SuperCollider** → Run `SuperDirt.start` (or auto-starts with startup.scd)
2. **Open VS Code** → Open a `.tidal` file in `projects/`
3. **Boot Tidal** → Press `Cmd+Shift+Enter` in VS Code
4. **Write patterns** → Type Haskell pattern code
5. **Evaluate** → Press `Shift+Enter` to hear changes in real-time
6. **Stop** → Type `hush` and evaluate to silence all channels

### Multi-modal (Audio + Visual) Workflow
For combining audio patterns with visual synthesis:

**Option 1: Hydra (Browser)**
- Keep VS Code open for TidalCycles
- Open https://hydra.ojack.xyz in browser
- Send OSC from Tidal to control Hydra visuals

**Option 2: Atom + VEDA**
- Use Atom editor with both TidalCycles and VEDA plugins
- Write `.tidal` files for audio, `.frag` files for GLSL shaders
- VEDA can react to audio in real-time

**Option 3: Renoise Integration**
- Set up IAC Driver MIDI bus in Audio MIDI Setup
- Use `Sound.Tidal.MIDI.Context` to send MIDI to Renoise
- See `projects/renoise/` for examples

## Architecture & Pattern System

### Pattern Language Fundamentals
TidalCycles uses **mini-notation** in strings for pattern sequences:
- `"bd sd hh cp"` - Sequential playback
- `"bd*4"` - Repeat 4 times
- `"bd ~ sd ~"` - Rests (~)
- `"[bd sd]"` - Subdivisions
- `"{bd sd, hh hh hh}"` - Polyrhythm
- `"<bd sd hh>"` - Alternation per cycle
- `"bd(3,8)"` - Euclidean rhythm (3 hits in 8 steps)

### Channel System (d1-d9)
Each channel (`d1`, `d2`, etc.) represents an independent musical stream:
```haskell
d1 $ sound "bd sd"     -- Drums
d2 $ sound "arpy"      -- Melody
d3 $ sound "bass"      -- Bass
```

### Pattern Transformations
Patterns are first-class values that can be transformed:
- **Time**: `fast`, `slow`, `rev`, `iter`, `hurry`
- **Structure**: `degrade`, `sometimes`, `every`
- **Combination**: `stack`, `cat`, `slowcat`

### Effects & Parameters
Effects are applied using `#` operator:
```haskell
d1 $ sound "bd sd" # gain 0.8 # room 0.3 # cutoff 2000
```

Common parameters: `gain`, `pan`, `room`, `size`, `cutoff`, `resonance`, `delay`, `speed`, `note`, `up`

### SuperCollider Integration
- TidalCycles sends OSC messages to SuperCollider on port **57120**
- SuperDirt receives patterns and triggers synthesis/samples
- Uses **12 orbits** (independent audio routing channels) by default
- Samples loaded from SuperDirt's default library or custom paths

## Configuration Files

### VS Code Settings (`.vscode/settings.json` or User Settings)
```json
{
    "tidalcycles.bootTidalPath": "~/.ghcup/bin",
    "tidalcycles.ghciPath": "~/.ghcup/bin/ghci",
    "tidalcycles.feedbackColor": "rgba(100,250,100,0.3)",
    "tidalcycles.showEvalCount": true,
    "tidalcycles.showOutput": true
}
```

### SuperCollider Startup Configuration
Location: `~/Library/Application Support/SuperCollider/startup.scd`
- Auto-boots server with optimized buffer/memory settings
- Auto-starts SuperDirt on port 57120 with 12 orbits
- Loads default sample library on startup

## Troubleshooting Common Issues

### No Sound from TidalCycles
1. Verify SuperCollider is running: check for SuperCollider icon/window
2. Verify SuperDirt is started: run `SuperDirt.start` in SuperCollider
3. Check Tidal is booted in VS Code: look for "Tidal started" message
4. Test audio: run `{ SinOsc.ar(440) * 0.1 }.play;` in SuperCollider

### VS Code Can't Boot Tidal
1. Check GHCi path is correct: `~/.ghcup/bin/ghci`
2. Verify GHCi works: run `~/.ghcup/bin/ghci` in terminal
3. Check VS Code Output panel for errors (View → Output → "TidalCycles")
4. Ensure port 57120 is not blocked by firewall

### SuperDirt Installation Fails
1. Check internet connection
2. Update Quarks: `Quarks.checkForUpdates();` in SuperCollider
3. Restart SuperCollider and retry installation
4. Check SuperCollider console for specific error messages

### MIDI Integration Issues (Renoise/Ableton)
1. Verify IAC Driver is Online in Audio MIDI Setup
2. Check MIDI device name matches exactly in Tidal code
3. Ensure receiving app has IAC bus selected as MIDI input
4. Test with `midiDevices` command in Tidal to list available devices

## Learning Path & Documentation

The `livecode-manuals/` directory contains a structured learning path:
1. **Beginners**: Read manuals 1-4 (Getting Started → Effects)
2. **Intermediate**: Explore manuals 5-7 (Advanced Patterns → Performance)
3. **Advanced**: Study manuals 8-9 (MIDI/OSC → Troubleshooting)
4. **Reference**: Keep manual 10 open for quick lookups

Key documentation files:
- `README.md` - Quick start and overview
- `INSTALLATION-GUIDE.md` - Complete setup instructions
- `VSCODE-SETUP.md` - Editor configuration details
- `MULTIMODAL-SETUP.md` - Audio-visual integration options
- `10-reference-quick.md` - Command cheat sheet

## External Resources

- Official site: https://tidalcycles.org/
- Pattern library: https://tidalcycles.org/docs/patternlib/
- Community forum: https://club.tidalcycles.org/
- GitHub: https://github.com/tidalcycles/Tidal
- Discord: TidalCycles community server
- TOPLAP: International live coding community

## Notes for AI Assistants

When helping with TidalCycles code:
- Patterns use Haskell syntax but mini-notation strings are the core DSL
- All code must be evaluated line-by-line in real-time (not compiled as programs)
- `.tidal` files are meant for live performance, not traditional source code
- SuperCollider must be running before any Tidal patterns will produce sound
- Port 57120 is the standard communication channel between Tidal and SuperDirt
- When editing manuals, maintain the educational/tutorial tone
- Pattern examples should be copy-paste ready and immediately useful
- When helping with FFmpeg commands, reference `projects/ffmpeg Cmd Data/` for metadata embedding scripts
- Use the `built/` project as a template reference for new project structures
- The repository is primarily documentation-focused - no traditional build/test commands needed
