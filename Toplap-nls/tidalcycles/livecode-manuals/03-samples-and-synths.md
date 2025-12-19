# Samples and Synths

## Working with Samples

### Basic Sample Selection

```haskell
-- Play default sample
d1 $ sound "bd"

-- Choose specific sample variant with 'n'
d1 $ sound "bd" # n 2

-- Pattern the sample selection
d1 $ sound "bd" # n "0 1 2 3"
```

### Common Sample Banks in SuperDirt

- **bd** - Bass drums
- **sd** - Snare drums
- **hh** - Hi-hats (closed)
- **oh** - Hi-hats (open)
- **cp** - Claps
- **arpy** - Arpeggio samples
- **bass** - Bass sounds
- **feel** - Feel samples
- **sn** - Snares
- **perc** - Percussion
- **tabla** - Tabla drums
- **tok** - Tok sounds
- **glitch** - Glitch sounds

### Custom Samples

```haskell
-- Load samples from custom folder
d1 $ sound "mysamples" # n 0

-- Pattern custom samples
d1 $ sound "mysamples:0 mysamples:1 mysamples:2"
```

## Sample Parameters

### Pitch and Speed

```haskell
-- speed: change playback speed (affects pitch)
d1 $ sound "bd" # speed 2      -- double speed, higher pitch
d1 $ sound "bd" # speed 0.5    -- half speed, lower pitch
d1 $ sound "bd" # speed "-1"   -- reverse

-- Pattern speed
d1 $ sound "arpy" # speed "1 1.5 2 0.5"

-- unit: change time stretching mode
d1 $ sound "bd" # speed 0.5 # unit "c"  -- crush (pitch independent)
```

### Note and Pitch

```haskell
-- note: musical note (semitones)
d1 $ sound "arpy" # note "0 2 4 7"

-- up: transpose in semitones
d1 $ sound "arpy" # up "0 3 7 12"

-- Musical notation
d1 $ n "c a f e" # sound "superpiano"
```

### Sample Playback Control

```haskell
-- begin/end: play part of sample (0-1)
d1 $ sound "bd" # begin 0.25 # end 0.75

-- cut: cut off previous sound (same cut group)
d1 $ sound "arpy" # cut 1

-- legato: control note length
d1 $ sound "arpy" # legato 1
```

## Built-in Synthesizers

### Common Synths

```haskell
-- superpiano
d1 $ n "c e g c5" # sound "superpiano"

-- supermandolin
d1 $ n "0 2 4 7" # sound "supermandolin"

-- supersaw
d1 $ note "0 3 7" # sound "supersaw"
  # voice 0.3
  # semitone 12
  # resonance 0.3

-- supersquare
d1 $ n "c a f e" # sound "supersquare"
  # voice 0.5
  # decay 0.4

-- superpwm (pulse width modulation)
d1 $ n "0 3 7 10" # sound "superpwm"
  # voice 0.4
```

### Synth Parameters

```haskell
-- voice: varies by synth, often affects timbre
d1 $ note "c e g" # sound "superpiano" # voice 0.8

-- decay: how quickly sound fades
d1 $ sound "supermandolin" # decay 0.1

-- sustain: how long sound holds
d1 $ sound "superpiano" # sustain 2

-- accelerate: pitch acceleration
d1 $ sound "bd" # accelerate 2
```

## Advanced Sample Techniques

### Slicing and Chopping

```haskell
-- chop: divide sample into pieces
d1 $ sound "breaks165" # chop 16

-- striate: granular chopping
d1 $ sound "breaks165" # striate 32

-- slice: manually select slices
d1 $ sound "breaks165" # slice 8 "0 1 2 3 4 5 6 7"
```

### Coarse Manipulation

```haskell
-- coarse: reduce sample rate for lo-fi effect
d1 $ sound "bd" # coarse "4 8 16 32"

-- Combine with other effects
d1 $ sound "breaks165" # coarse 16 # speed 2
```

### Sample Loops

```haskell
-- loop: loop a sample
d1 $ sound "breaks165" # loop 4

-- Combine with cut for clean looping
d1 $ sound "breaks165" # loop 4 # cut 1
```

## Layering Samples and Synths

```haskell
-- Layer samples
d1 $ stack [
  sound "bd sd",
  sound "hh*8",
  n "0 2 4 7" # sound "superpiano"
]

-- Mix samples and synths
d1 $ sound "bd sd"
d2 $ note "c a f e" # sound "supermandolin"
d3 $ sound "hh*16" # gain 0.6
```

## Tips

- Explore different `n` values to find interesting samples
- Use `speed` for quick pitch variations
- Combine `begin` and `end` for creative sample slicing
- Layer different sample banks for rich textures
- Experiment with synth parameters to shape your sound
