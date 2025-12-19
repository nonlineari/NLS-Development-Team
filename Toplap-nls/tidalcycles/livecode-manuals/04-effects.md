# Effects and Audio Processing

## Applying Effects

Effects are applied using the `#` operator:

```haskell
-- Single effect
d1 $ sound "bd sd" # gain 0.8

-- Multiple effects
d1 $ sound "bd sd" 
  # gain 0.9
  # room 0.3
  # speed 1.2
```

## Volume and Dynamics

### Gain
```haskell
-- gain: overall volume (1 = normal, 0 = silent)
d1 $ sound "bd sd hh cp" # gain 0.8

-- Pattern gain
d1 $ sound "bd sd hh cp" # gain "1 0.8 0.6 0.9"

-- Accent with gain
d1 $ sound "bd*4" # gain "1 0.7 0.8 0.6"
```

### Amplify
```haskell
-- amplify: similar to gain, multiplicative
d1 $ sound "bd sd" # amplify 1.2
```

## Spatial Effects

### Pan
```haskell
-- pan: stereo position (0 = left, 0.5 = center, 1 = right)
d1 $ sound "bd sd" # pan 0.5

-- Moving pan
d1 $ sound "hh*8" # pan (range 0 1 sine)

-- Pattern pan
d1 $ sound "bd sd hh cp" # pan "0 0.3 0.7 1"
```

### Reverb (Room/Size)
```haskell
-- room: reverb amount (0-1)
-- size: reverb size (0-1)
d1 $ sound "bd sd" 
  # room 0.5 
  # size 0.8

-- Varying reverb
d1 $ sound "cp*4" # room "0.1 0.3 0.5 0.9"
```

## Filter Effects

### Low-Pass Filter
```haskell
-- cutoff: low-pass filter frequency (0-20000 Hz)
d1 $ sound "bd sd" # cutoff 2000

-- resonance: filter resonance (0-1)
d1 $ sound "bd sd" 
  # cutoff 1000 
  # resonance 0.3

-- Moving filter
d1 $ sound "breaks165" 
  # cutoff (range 200 8000 sine)
  # resonance 0.2
```

### High-Pass Filter
```haskell
-- hcutoff: high-pass filter frequency
d1 $ sound "breaks165" # hcutoff 2000

-- With resonance
d1 $ sound "breaks165" 
  # hcutoff 3000 
  # hresonance 0.3
```

### Band-Pass Filter
```haskell
-- bandf: band-pass filter center frequency
-- bandq: band-pass filter bandwidth
d1 $ sound "breaks165" 
  # bandf 2000 
  # bandq 10
```

## Modulation Effects

### Delay
```haskell
-- delay: delay amount (0-1)
-- delaytime: delay time in cycles
-- delayfeedback: delay feedback amount
d1 $ sound "bd cp" 
  # delay 0.8 
  # delaytime 0.25 
  # delayfeedback 0.6

-- Rhythmic delays
d1 $ sound "cp" 
  # delay 0.9 
  # delaytime "0.25 0.5 0.125"
```

### Phaser
```haskell
-- phasr: phaser rate
-- phasdp: phaser depth
d1 $ sound "bd sd" 
  # phasr 4 
  # phasdp 0.5
```

### Chorus
```haskell
-- leslie: rotating speaker effect (chorus)
-- lrate: rotation rate
-- lsize: speaker size
d1 $ sound "superpiano" 
  # note "c e g" 
  # leslie 1 
  # lrate 2
```

## Distortion and Saturation

### Crush (Bit Reduction)
```haskell
-- crush: bit depth reduction (1-16)
d1 $ sound "bd sd" # crush 4

-- Pattern crush for glitchy effects
d1 $ sound "hh*8" # crush "8 4 2 1"
```

### Distortion
```haskell
-- distort: distortion amount (0-1)
d1 $ sound "bd sd" # distort 0.5

-- squiz: weird pitch-dive distortion
d1 $ sound "bd sd" # squiz 2
```

### Shape (Waveshaping)
```haskell
-- shape: waveshaping distortion (0-1)
d1 $ sound "bd sd hh cp" # shape 0.5

-- Aggressive shaping
d1 $ sound "bass" # shape 0.8
```

## Envelope Control

### Attack, Hold, Release
```haskell
-- attack: fade-in time
-- hold: sustain time
-- release: fade-out time
d1 $ sound "arpy" 
  # attack 0.1 
  # hold 0.5 
  # release 0.4
```

## Specialized Effects

### Vowel
```haskell
-- vowel: formant filter (vowel sounds)
-- Values: a e i o u
d1 $ sound "bd sd" # vowel "a e i o"

-- Moving through vowels
d1 $ sound "bass" # vowel "<a e i o u>"
```

### Tremolo
```haskell
-- tremolorate: tremolo speed
-- tremolodepth: tremolo depth
d1 $ sound "superpiano" 
  # note "c e g" 
  # tremolorate 8 
  # tremolodepth 0.8
```

### DJ Filter
```haskell
-- djf: DJ-style filter (0-1, 0.5 = no filter)
d1 $ sound "breaks165" # djf 0.3  -- low-pass
d1 $ sound "breaks165" # djf 0.7  -- high-pass
```

## Effect Chaining and Combination

```haskell
-- Combine multiple effects
d1 $ sound "bd sd hh cp"
  # gain 0.9
  # cutoff 2000
  # resonance 0.3
  # room 0.4
  # delay 0.5
  # delaytime 0.25
  # pan (range 0 1 sine)

-- Different effects per pattern element
d1 $ sound "bd sd"
  # gain "0.9 0.7"
  # cutoff "3000 1000"
  # room "0.1 0.5"
```

## Continuous Modulation

### Using Oscillators
```haskell
-- sine: sine wave oscillator
d1 $ sound "bd sd" # cutoff (range 200 4000 sine)

-- saw: sawtooth oscillator
d1 $ sound "bd sd" # pan (range 0 1 saw)

-- tri: triangle oscillator
d1 $ sound "hh*16" # gain (range 0.5 1 tri)

-- square: square wave oscillator
d1 $ sound "bd sd" # room (range 0 0.5 square)
```

### Slow Modulation
```haskell
-- slow: slow down modulation
d1 $ sound "bd sd" 
  # cutoff (slow 4 $ range 200 4000 sine)

-- fast: speed up modulation
d1 $ sound "bd sd" 
  # pan (fast 2 $ range 0 1 sine)
```

## Tips

- Start with subtle effect amounts and increase gradually
- Use `range` to control oscillator output ranges
- Combine complementary effects (reverb + delay, filter + resonance)
- Pattern effect parameters for rhythmic variation
- Use `sometimes` or `every` to apply effects conditionally
