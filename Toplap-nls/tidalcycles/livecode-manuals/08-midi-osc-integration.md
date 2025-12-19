# MIDI, OSC, and External Integration

## MIDI Output

### Basic MIDI Setup

```haskell
-- Import MIDI module (in editor initialization)
import Sound.Tidal.MIDI.Context

-- Create MIDI device connection
devices <- midiDevices
m1 <- midiStream devices "Your MIDI Device Name" 1 synthController
```

### Sending MIDI Notes

```haskell
-- Simple MIDI note pattern
m1 $ note "0 2 4 7" # velocity 0.8

-- Pattern velocities
m1 $ note "0 2 4 7" # velocity "0.8 0.6 0.9 0.7"

-- MIDI channels
m1 $ note "0 2 4 7" # midichan 1
m2 $ note "0 3 7" # midichan 2
```

### MIDI Control Changes

```haskell
-- CC messages
m1 $ note "0 2 4" # ccn 74 # ccv 64

-- Pattern CC values
m1 $ note "0 2 4" 
  # ccn 74 
  # ccv (range 0 127 sine)

-- Multiple CCs
m1 $ note "0 2 4 7"
  # ccn 74 # ccv 64  -- filter
  # ccn 71 # ccv 100  -- resonance
```

### Program Changes

```haskell
-- Change MIDI program/patch
m1 $ note "0 2 4 7" # program 10

-- Pattern program changes
m1 $ note "0 2 4 7" # program "<1 5 10 20>"
```

## MIDI Input

### Receiving MIDI

```haskell
-- Map MIDI input to parameters (setup dependent on editor)
-- Example: use MIDI controller to control parameters

-- MIDI CC to cutoff
d1 $ sound "breaks165" 
  # cutoff (cF 0 "cutoff")  -- maps to CC value

-- MIDI notes to trigger samples
d1 $ note (cF 0 "note") # sound "arpy"
```

## OSC (Open Sound Control)

### Sending OSC

```haskell
-- Send OSC messages to external applications
-- Define OSC target
let osc1 = OSC "localhost" 7000

-- Send pattern as OSC
d1 $ sound "bd sd" # s osc1
```

### OSC Parameters

```haskell
-- Send custom OSC parameters
d1 $ sound "bd sd" 
  # oscN "param1" 0.5
  # oscN "param2" (range 0 1 sine)

-- Multiple OSC parameters
d1 $ sound "bd sd"
  # oscN "x" (range 0 1 sine)
  # oscN "y" (range 0 1 saw)
  # oscN "z" rand
```

### Receiving OSC

```haskell
-- Map OSC input to Tidal parameters
-- This allows external control of Tidal

-- Example: OSC message to control cutoff
d1 $ sound "breaks165" 
  # cutoff (cF 0 "cutoff")  -- receives OSC on this path
```

## Integration with DAWs

### Ableton Link

```haskell
-- Sync with Ableton Link (if supported by setup)
-- Enable Link in SuperDirt/SuperCollider

-- TidalCycles will sync tempo with Link-enabled apps
```

### Clock Sync

```haskell
-- Set tempo (BPM)
setcps (120/60/4)  -- 120 BPM

-- Get current tempo
cps

-- Sync with external MIDI clock (depends on setup)
```

## SuperCollider Integration

### Custom SynthDefs

```haskell
-- In SuperCollider, define custom synth
-- Then use in Tidal:

d1 $ note "0 2 4 7" # sound "myCustomSynth"
  # param1 0.5
  # param2 (range 0 1 sine)
```

### SuperDirt Parameters

```haskell
-- Orbit: separate output channels
d1 $ sound "bd sd" # orbit 0
d2 $ sound "hh*8" # orbit 1

-- Different effects per orbit (set in SuperCollider)
-- Orbit 0: reverb
-- Orbit 1: delay
```

### Audio Input Processing

```haskell
-- Process external audio through SuperDirt
-- (Requires SuperCollider setup)

-- Route external input through effects
d1 $ sound "input" 
  # cutoff 2000 
  # room 0.5
```

## Hardware Integration

### MIDI Hardware Synths

```haskell
-- Setup MIDI output to hardware
m1 <- midiStream devices "Hardware Synth" 1 synthController

-- Send patterns to hardware
m1 $ note "0 2 4 7" 
  # velocity (range 0.6 1 sine)
  # sustain 0.5

-- Control multiple synths
m1 $ note "0 2 4 7" # midichan 1  -- synth 1
m2 $ note "0 3 7" # midichan 2   -- synth 2
```

### CV/Gate via MIDI-to-CV

```haskell
-- Use MIDI-to-CV converter for modular synths
-- Send MIDI as usual
m1 $ note "0 2 4 7" 
  # velocity 1.0  -- gate/trigger
  # ccn 74 # ccv (range 0 127 sine)  -- CV modulation
```

### MIDI Controllers

```haskell
-- Map MIDI controller knobs/faders to parameters
-- (Setup in editor or via external routing)

-- Example: Knob 1 controls cutoff
d1 $ sound "breaks165" 
  # cutoff (cF 0 "knob1" * 8000)

-- Example: Fader controls gain
d1 $ sound "bd sd" 
  # gain (cF 0 "fader1")
```

## Visual Integration

### Sending to Video Software

```haskell
-- Send OSC to visual software (e.g., Processing, TouchDesigner)

-- Define OSC target
let visuals = OSC "localhost" 8000

-- Send pattern data
d1 $ sound "bd sd hh cp"
  # oscN "intensity" (range 0 1 $ fast 4 sine)
  # oscN "color" (irand 8)
  # oscN "trigger" 1
```

### Hydra Visual Synth

```haskell
-- TidalCycles can send OSC to Hydra
-- In Hydra (JavaScript), receive OSC:
-- osc(4, 0.1, () => audio.fft[0])

-- Send from Tidal:
d1 $ sound "bd sd" 
  # oscN "hydra" (range 0 1 sine)
```

## Network Collaboration

### Sending Patterns Over Network

```haskell
-- Send OSC to remote machine
let remote = OSC "192.168.1.100" 7000

d1 $ sound "bd sd" # s remote
```

### Shared Clock

```haskell
-- Use Ableton Link for network sync
-- Or share clock via OSC

-- Set tempo on master machine
setcps (120/60/4)

-- Slave machines sync to same tempo
```

## Advanced Integration

### Pattern Data Export

```haskell
-- Send pattern state as data (for visualization, etc.)
d1 $ sound "bd sd hh cp"
  # oscN "step" (segment 4 $ slow 1 saw)
  # oscN "cycle" (slow 1 saw)
```

### Multi-device Setup

```haskell
-- Machine 1: Drums
d1 $ sound "bd sd"
d2 $ sound "hh*8"

-- Machine 2: Melody (via network OSC)
-- Both machines share clock via Link

-- Machine 3: Visuals (receiving OSC from machines 1 & 2)
```

### Complex MIDI Mappings

```haskell
-- Map multiple parameters to MIDI
m1 $ note "0 2 4 7"
  # velocity (range 0.5 1 sine)
  # sustain (range 0.1 1 saw)
  # ccn 74 # ccv (range 0 127 $ fast 2 sine)  -- filter
  # ccn 71 # ccv (range 0 127 rand)  -- resonance
  # ccn 1 # ccv (range 0 127 tri)  -- mod wheel
```

## Tips

- **MIDI latency**: adjust timing if needed with `nudge`
- **OSC debugging**: use OSC monitor tools to verify messages
- **Clock sync**: Ableton Link is most reliable for multi-device sync
- **Buffer size**: adjust SuperCollider buffer for lower latency
- **MIDI channels**: organize synths across MIDI channels
- **OSC address schemes**: use consistent naming for parameters
- **Test connections**: verify MIDI/OSC before performance
- **Backup plan**: have standalone mode ready if integration fails
