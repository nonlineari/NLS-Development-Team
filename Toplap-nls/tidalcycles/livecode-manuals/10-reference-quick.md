# Quick Reference Guide

## Essential Commands

### Control
```haskell
d1 silence          -- Silence channel 1
hush                -- Silence all channels
setcps (120/60/4)   -- Set tempo to 120 BPM
```

### Basic Pattern
```haskell
d1 $ sound "bd sd hh cp"              -- Simple sequence
d1 $ sound "bd*4"                     -- Repeat 4 times
d1 $ sound "bd ~ sd ~"                -- With rests
d1 $ sound "bd [sd sd]"               -- Subdivision
d1 $ sound "{bd sd, hh hh hh}"        -- Polymeter
d1 $ sound "bd <sd cp>"               -- Alternation
```

## Common Transformations

### Time
```haskell
fast 2              -- Double speed
slow 2              -- Half speed
hurry 2             -- Speed up with pitch
rev                 -- Reverse
iter 4              -- Rotate over 4 cycles
every 4 (rev)       -- Apply every 4 cycles
```

### Structure
```haskell
degrade             -- Remove 50% of events
degradeBy 0.3       -- Remove 30% of events
sometimes (f)       -- Apply f 50% of time
often (f)           -- Apply f 75% of time
rarely (f)          -- Apply f 25% of time
```

### Combination
```haskell
stack [p1, p2]      -- Layer patterns
cat [p1, p2]        -- Concatenate patterns
slowcat [p1, p2]    -- One pattern per cycle
```

## Sample Parameters

### Selection
```haskell
sound "bd"          -- Sample bank
n 2                 -- Sample number
```

### Playback
```haskell
speed 2             -- Double speed/higher pitch
speed (-1)          -- Reverse
begin 0.25          -- Start at 25%
end 0.75            -- End at 75%
loop 4              -- Loop 4 times
```

### Pitch
```haskell
note "0 2 4 7"      -- Semitones
up 12               -- Transpose up octave
```

## Common Effects

### Volume
```haskell
gain 0.8            -- Volume (1 = normal)
amplify 1.2         -- Amplify
```

### Space
```haskell
pan 0.5             -- Pan (0=left, 1=right)
room 0.3            -- Reverb amount
size 0.8            -- Reverb size
```

### Filters
```haskell
cutoff 2000         -- Low-pass filter (Hz)
resonance 0.3       -- Filter resonance
hcutoff 2000        -- High-pass filter
bandf 1000          -- Band-pass center
```

### Time Effects
```haskell
delay 0.5           -- Delay amount
delaytime 0.25      -- Delay time (cycles)
delayfeedback 0.6   -- Delay feedback
```

### Distortion
```haskell
crush 4             -- Bit crush (1-16)
shape 0.5           -- Waveshaping
distort 0.5         -- Distortion
coarse 16           -- Sample rate reduction
```

### Special
```haskell
vowel "a"           -- Vowel filter (a,e,i,o,u)
speed (range 0.5 2 sine)    -- Modulation
```

## Scales

```haskell
scale "major" "0 2 4 7"         -- Major scale
scale "minor" "0 2 4 7"         -- Minor scale
scale "majorPent" "0 1 2 3 4"   -- Major pentatonic
scale "minorPent" "0 1 2 3 4"   -- Minor pentatonic
scale "dorian" "0 2 4 6"        -- Dorian mode
scale "blues" "0 1 2 3 4 5"     -- Blues scale
```

## Euclidean Rhythms

```haskell
sound "bd(3,8)"     -- 3 hits over 8 steps
sound "bd(5,8,2)"   -- 5 hits, 8 steps, rotate 2
```

## Randomness

```haskell
rand                -- Random 0-1
irand 8             -- Random integer 0-7
choose ["bd","sd"]  -- Choose from list
wchoose [("bd",3),("sd",1)]  -- Weighted choice
```

## Pattern Operators

```haskell
|+|                 -- Add patterns
|-|                 -- Subtract patterns
|*|                 -- Multiply patterns
|/|                 -- Divide patterns
```

## Oscillators

```haskell
sine                -- Sine wave (0-1)
saw                 -- Sawtooth wave
tri                 -- Triangle wave
square              -- Square wave
rand                -- Random values

-- Use with range
range 200 4000 sine -- Map sine to 200-4000
```

## Mini-Notation

```haskell
"bd sd"             -- Sequence
"bd*4"              -- Multiply (repeat)
"bd/2"              -- Divide (slow)
"bd ~ sd ~"         -- Rest (~)
"bd!3"              -- Replicate (!)
"bd@3"              -- Elongate (@)
"[bd sd]"           -- Subdivision
"{bd sd, hh hh hh}" -- Polymeter
"<bd sd hh>"        -- Alternation
"bd | sd | hh"      -- Random choice
"bd(3,8)"           -- Euclidean rhythm
```

## Common Patterns

### Basic Drums
```haskell
d1 $ sound "bd sd bd sd"
d1 $ sound "bd*2 sd"
d1 $ sound "bd sd [hh hh] cp"
```

### Hi-hats
```haskell
d1 $ sound "hh*8" # gain 0.6
d1 $ sound "hh(7,8)" # gain "1 0.7"
d1 $ sound "hh*16" # gain (range 0.5 1 sine)
```

### Bass
```haskell
d1 $ n "0 ~ 0 7" # sound "bass"
d1 $ n "0 0 0 7" # sound "bass" # cutoff 800
```

### Melody
```haskell
d1 $ n (scale "minor" "0 2 4 7") # sound "superpiano"
d1 $ n (scale "major" "0 2 4 7 4 2") # sound "supermandolin"
```

## Cheat Codes

### Instant Groove
```haskell
d1 $ sound "bd sd [~ bd] sd"
d2 $ sound "hh*8" # gain (range 0.5 0.9 sine)
d3 $ sound "cp(3,8,2)"
```

### Filter Sweep
```haskell
d1 $ sound "breaks165" 
  # cutoff (range 200 8000 $ slow 4 sine)
  # resonance 0.3
```

### Glitch Effect
```haskell
d1 $ sometimes (# speed 2) 
   $ sometimes (# crush 4)
   $ sound "bd sd hh cp"
```

### Build Tension
```haskell
d1 $ every 8 (fast 2)
   $ every 4 (# crush 4)
   $ sound "bd sd hh cp"
```

### Ambient Texture
```haskell
d1 $ slow 4 $ sound "arpy(5,8)"
  # speed (range 0.5 2 sine)
  # room 0.9
  # size 0.9
  # cutoff (range 500 3000 saw)
```

## Function Composition

```haskell
-- Chain with $
d1 $ fast 2 $ rev $ sound "bd sd hh cp"

-- Chain with .
d1 $ (fast 2 . rev) $ sound "bd sd hh cp"

-- Multiple functions
d1 $ every 4 (fast 2 . rev) $ sound "bd sd hh cp"
```

## Common Combinations

### Drums + Bass
```haskell
d1 $ sound "bd sd"
d2 $ n "0 ~ 0 7" # sound "bass" # cutoff 600
```

### Drums + Melody + Pads
```haskell
d1 $ sound "bd sd hh*4 cp"
d2 $ n (scale "minor" "0 2 4 7") # sound "superpiano"
d3 $ slow 4 $ n (scale "minor" "[0,3,7]") 
  # sound "superpwm" 
  # voice 0.3
  # gain 0.7
```

## Quick Tips

- **Start simple**: `d1 $ sound "bd"`
- **Build gradually**: Add one element at a time
- **Use `hush`**: When things get chaotic
- **Save often**: Keep backups of good patterns
- **Listen first**: Code less, listen more
- **Embrace mistakes**: They often sound interesting
- **Use `every`**: For predictable variation
- **Layer wisely**: Leave space in arrangements
- **Test before performing**: Boot everything first
- **Have a safety pattern**: `d1 $ sound "bd ~ ~ ~"`

## Keyboard Shortcuts (Editor-Specific)

### Atom (common defaults)
- Evaluate line: `Ctrl+Enter` (Mac: `Cmd+Enter`)
- Evaluate block: `Ctrl+Shift+Enter`
- Stop: `Ctrl+.`

### VS Code (TidalCycles extension)
- Evaluate: `Shift+Enter`
- Evaluate multiple: Select + `Shift+Enter`

### Vim (vim-tidal)
- Evaluate line: `<localleader>ss`
- Evaluate paragraph: `<localleader>sp`

### Emacs (tidal.el)
- Evaluate region: `C-c C-e`
- Evaluate line: `C-Enter`
