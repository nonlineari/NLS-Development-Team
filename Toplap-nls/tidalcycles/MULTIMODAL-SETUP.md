# Multi-Editor Setup: GLSL + TidalCycles + Lua

## Overview

This guide covers multiple setups for combining visual (GLSL) and audio (TidalCycles) live coding, plus Lua integration options.

## Option 1: VEDA + Atom (RECOMMENDED for GLSL + Tidal)

**What it does:** Live code GLSL shaders and TidalCycles audio in the same editor

### Installation

1. **Install Atom Editor**
   ```bash
   brew install --cask atom
   ```

2. **Install TidalCycles package for Atom**
   ```bash
   apm install tidalcycles
   ```

3. **Install VEDA for GLSL**
   ```bash
   apm install veda
   ```

4. **Install glslangValidator** (required by VEDA)
   ```bash
   brew install glslang
   ```

### Usage

**For TidalCycles:**
- Create `.tidal` files
- Evaluate with `Cmd+Enter` (or `Shift+Enter`)

**For GLSL:**
- Create `.frag` or `.vert` files
- Run VEDA with `Ctrl+Enter`
- Shaders render in the background

**Audio → Visual Integration:**
- VEDA supports audio input via `uniform sampler2D audio`
- Can react to TidalCycles output in real-time

### Example VEDA Shader with Audio

```glsl
/*{
  "audio": true
}*/
precision mediump float;
uniform float time;
uniform vec2 resolution;
uniform sampler2D audio;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution;
    float audioValue = texture2D(audio, vec2(uv.x, 0.0)).r;
    vec3 color = vec3(audioValue);
    gl_FragColor = vec4(color, 1.0);
}
```

---

## Option 2: Hydra + VS Code + TidalCycles

**What it does:** Browser-based GLSL visuals synced with TidalCycles via OSC

### Setup

1. **Keep VS Code for TidalCycles** (already set up)

2. **Use Hydra in browser**
   - Open https://hydra.ojack.xyz
   - Or install locally: `npm i -g hydra-synth`

3. **Send OSC from TidalCycles to Hydra**

### TidalCycles → Hydra Integration

**In TidalCycles (VS Code):**
```haskell
-- Send OSC to Hydra
d1 $ sound "bd sd hh cp"
  # oscN "hydra" (range 0 1 sine)
```

**In Hydra (Browser):**
```javascript
// React to audio
osc(40, 0.1)
  .modulate(noise(3))
  .scale(() => a.fft[0] * 2) // React to audio FFT
  .out()

// Or use MIDI/OSC input
```

### Advantages
- Browser-based (no install)
- Real-time visual feedback
- Easy to share visuals via URL
- Good documentation

---

## Option 3: Renoise + TidalCycles Notation + Lua

**What it does:** Tracker DAW with Lua scripting and Tidal-style patterns

### Installation

1. **Download Renoise**
   - Visit https://www.renoise.com/download
   - $88 (or demo version available)

2. **Renoise 3.5+ includes pattrns**
   - Built-in Lua scripting with Tidal notation support
   - No additional setup needed

### Usage

**Tidal-style patterns in Lua:**
```lua
-- In Renoise's scripting terminal
local p = pattrns.parse("bd sd [hh hh] cp")
p:play()
```

**Lua scripting:**
```lua
-- Access Renoise API
renoise.song().transport.bpm = 140
renoise.song().tracks[1].name = "Drums"
```

### Limitations
- No built-in GLSL support
- Requires purchase (demo available)
- More focused on audio than visuals

---

## Option 4: Triple Setup (BEST FLEXIBILITY)

**Combination of tools for maximum power:**

### The Stack

1. **VS Code** - TidalCycles audio patterns
2. **Atom + VEDA** - GLSL live visuals
3. **SuperCollider** - Audio engine
4. **Hydra (Browser)** - Additional visuals/effects

### Workflow

```
TidalCycles (VS Code) → SuperCollider → Audio Out
                      ↓
                     OSC
                      ↓
        Atom/VEDA ← → Hydra (Browser)
              ↓
         Visual Out
```

### Integration Points

**SuperCollider → OSC → VEDA:**
```supercollider
// In SuperCollider
~osc = NetAddr("127.0.0.1", 7000);
~dirt.orbits.do({ |orbit|
    orbit.outBus.scope;
});
```

**TidalCycles → OSC → Everything:**
```haskell
-- Send data to visuals
d1 $ sound "bd sd hh cp"
  # oscN "intensity" (range 0 1 $ fast 4 sine)
```

---

## VIDVOX ISF Editor (Bonus Option)

**What it does:** Professional GLSL shader editor with ISF format

### Installation

- Download from https://isf.vidvox.net/desktop-editor/
- Free for Mac and Windows

### Features
- Syphon/Spout output
- Real-time preview
- Import from Shadertoy
- Good for shader development
- Use with VDMX for performance

### Integration
- Develop shaders in ISF Editor
- Export for use in VEDA or Hydra
- Use Syphon to send to other apps

---

## Recommended Setup Based on Your Needs

### For Learning Both (Start Here)
**VS Code (Tidal) + Hydra (Browser)**
- Easiest to set up
- Good documentation
- Free
- Browser-based visuals

### For Serious Live Coding
**Atom + VEDA + TidalCycles**
- Everything in one editor
- Direct audio-visual integration
- Professional VJ workflow

### For Music Production + Coding
**Renoise + pattrns (Tidal notation) + Lua**
- Tracker interface
- Tidal-style patterns in Lua
- Professional DAW features

### For Maximum Power
**All of the above**
- VS Code for main Tidal work
- Atom + VEDA for live visuals
- Hydra for effects/experiments
- ISF Editor for shader development

---

## Installation Commands Summary

```bash
# Atom + VEDA + TidalCycles
brew install --cask atom
apm install tidalcycles
apm install veda
brew install glslang

# Hydra (local install, optional)
npm i -g hydra-synth

# ISF Editor
# Download from https://isf.vidvox.net/desktop-editor/

# Renoise
# Purchase/Download from https://www.renoise.com/
```

---

## Ableton Integration

### Using TidalCycles with Ableton

**Via Ableton Link:**
```haskell
-- In TidalCycles (sync tempo)
setcps (120/60/4)  -- 120 BPM
```

**Via MIDI:**
```haskell
-- Send MIDI to Ableton
import Sound.Tidal.MIDI.Context
devices <- midiDevices
m1 <- midiStream devices "IAC Driver Bus 1" 1 synthController

m1 $ note "0 3 7 12" # velocity 0.8
```

### Ableton → TidalCycles
- Use MIDI sync
- Send MIDI CC to control Tidal parameters
- Use Ableton Link for tempo sync

---

## Project Structure

```
Toplap-nls/
├── tidalcycles/
│   ├── projects/
│   │   ├── audio-patterns/     # .tidal files
│   │   ├── visual-shaders/     # .frag files
│   │   ├── hydra-scripts/      # .js files
│   │   └── renoise-lua/        # .lua files
│   ├── livecode-manuals/
│   └── README.md
```

---

## Next Steps

1. **Start with Hydra + VS Code**
   - Easiest entry point
   - Open https://hydra.ojack.xyz
   - Try basic visual patterns
   - Connect to TidalCycles audio

2. **Then try Atom + VEDA**
   - More integrated workflow
   - Better for performance
   - More control over GLSL

3. **Explore Renoise** (optional)
   - If you want tracker workflow
   - Lua scripting is powerful
   - Good for music production

4. **Consider Ableton integration** later
   - MIDI and Link sync
   - Hybrid DAW + livecode workflow

---

## Resources

### VEDA
- Website: https://veda.gl/
- GitHub: https://github.com/fand/veda
- Examples: https://github.com/fand/veda/tree/master/examples

### Hydra
- Website: https://hydra.ojack.xyz
- Docs: https://hydra.ojack.xyz/docs/
- Examples: Built into the website

### Renoise
- Website: https://www.renoise.com/
- Lua docs: https://github.com/renoise/xrnx
- pattrns: https://github.com/renoise/pattrns

### ISF
- Website: https://isf.vidvox.net/
- Editor: https://isf.vidvox.net/desktop-editor/
- Spec: https://isf.vidvox.net/
