# Performance Techniques

## Building a Set

### Starting Simple

```haskell
-- Begin with a basic pattern
d1 $ sound "bd sd"

-- Gradually add elements
d1 $ sound "bd sd hh cp"

-- Add variation
d1 $ sound "bd sd hh*4 cp"

-- Layer in another channel
d2 $ sound "arpy(3,8)"
```

### Progressive Complexity

```haskell
-- Start: Minimal
d1 $ sound "bd"

-- Add: Rhythm
d1 $ sound "bd sd"

-- Add: Variation
d1 $ sound "bd sd hh*4"

-- Add: Effects
d1 $ sound "bd sd hh*4" # crush 4

-- Add: Transformation
d1 $ every 4 (rev) $ sound "bd sd hh*4" # crush 4

-- Add: More layers
d2 $ n (scale "minor" "0 2 4 7") # sound "superpiano"
```

## Transitions and Changes

### Smooth Transitions

```haskell
-- Gradual filter sweep
d1 $ sound "breaks165" 
  # cutoff (slow 8 $ range 200 8000 sine)

-- Fade in/out with gain
d1 $ sound "bd sd" 
  # gain (slow 4 $ range 0 1 sine)

-- Crossfade between patterns
d1 $ sound "bd sd" # gain 0.8
d2 $ sound "hh*8" # gain 0.2

-- Then swap
d1 $ sound "bd sd" # gain 0.2
d2 $ sound "hh*8" # gain 0.8
```

### Hard Cuts

```haskell
-- Sudden silence
d1 silence

-- Immediate pattern change
d1 $ sound "arpy*16" # speed 2

-- Drop all and start fresh
hush
d1 $ sound "bd*4"
```

### Build and Release

```haskell
-- Build: Add layers
d1 $ sound "bd"
-- wait...
d2 $ sound "bd sd"
-- wait...
d3 $ sound "bd sd hh*8"
-- wait...
d4 $ sound "bd sd hh*8 cp"

-- Release: Drop to minimal
hush
d1 $ sound "bd ~ ~ ~" # room 0.9 # size 0.9
```

## Live Manipulation Techniques

### Parameter Modulation

```haskell
-- Speed changes
d1 $ sound "breaks165" # speed "<1 1.5 2 0.5>"

-- Pitch variation
d1 $ sound "arpy" # note "<0 3 7 12>"

-- Filter sweeps
d1 $ sound "breaks165" 
  # cutoff (range 200 8000 $ slow 4 sine)

-- Dynamic panning
d1 $ sound "bd sd hh cp" 
  # pan (range 0 1 $ fast 2 sine)
```

### Pattern Transformations

```haskell
-- Conditional effects
d1 $ sometimes (# speed 2) $ sound "bd sd hh cp"

-- Periodic reversal
d1 $ every 4 (rev) $ sound "bd sd hh cp"

-- Degradation for variation
d1 $ degradeBy 0.3 $ sound "hh*16"

-- Iterative rotation
d1 $ iter 4 $ sound "bd sd hh cp"
```

### Using `every` for Structure

```haskell
-- Every 4 cycles, reverse
d1 $ every 4 (rev) $ sound "bd sd hh cp"

-- Multiple transformations
d1 $ every 4 (fast 2) 
   $ every 3 (rev) 
   $ sound "bd sd hh cp"

-- Build complexity over time
d1 $ every 8 (# crush 4)
   $ every 4 (# speed 2)
   $ every 2 (rev)
   $ sound "bd sd hh cp"
```

## Channel Management

### Organizing Channels

```haskell
-- d1-d4: Drums
d1 $ sound "bd(3,8)"
d2 $ sound "sd(5,16)"
d3 $ sound "hh*16" # gain 0.6
d4 $ sound "cp(3,8,2)"

-- d5-d8: Melodic
d5 $ n (scale "minor" "0 2 4 7") # sound "superpiano"
d6 $ n (scale "minor" "0 7") # sound "superbass"

-- d9-d12: Textures/ambience
d9 $ sound "breaks165" # cutoff 1000 # room 0.9
```

### Muting and Soloing

```haskell
-- Mute individual channel
d1 silence

-- Solo by muting others
d2 silence
d3 silence
d4 silence
-- d1 continues

-- Restore
hush  -- silence all
-- rebuild
```

### Channel Grouping

```haskell
-- Define reusable patterns
let drums = sound "bd sd hh cp"
let bass = n "0 ~ 0 7" # sound "superbass"
let melody = n (scale "minor" "0 2 4 7") # sound "superpiano"

-- Use them
d1 $ drums
d2 $ bass
d3 $ melody

-- Modify on the fly
d1 $ fast 2 $ drums
```

## Dynamic Pattern Variables

### Using `let` for Patterns

```haskell
-- Define patterns
let kick = sound "bd*4"
let snare = sound "~ sd ~ sd"
let hats = sound "hh*8"

-- Combine
d1 $ stack [kick, snare, hats]

-- Modify
d1 $ fast 2 $ stack [kick, snare, hats]
```

### Building Pattern Libraries

```haskell
-- Rhythm patterns
let rhythm1 = "bd sd hh cp"
let rhythm2 = "bd sd bd [sd sd]"
let rhythm3 = "bd*2 [~ sd] hh*4 cp"

-- Use them
d1 $ sound rhythm1
-- then
d1 $ sound rhythm2
-- then
d1 $ sound rhythm3
```

## Performance Structures

### A-B Structure

```haskell
-- Section A: Minimal
d1 $ sound "bd sd"
d2 $ n (scale "minor" "0 2") # sound "superpiano"

-- Section B: Dense
d1 $ sound "bd*4 sd*2 hh*16 cp*2"
d2 $ fast 2 $ n (scale "minor" "0 2 4 7 9 7 4 2") 
  # sound "superpiano"
d3 $ sound "bass(3,8)" # gain 0.8

-- Back to A (minimal)
d3 silence
d1 $ sound "bd sd"
d2 $ slow 2 $ n (scale "minor" "0 2") # sound "superpiano"
```

### Build-Drop-Build

```haskell
-- Build: Gradual addition
d1 $ sound "bd"
-- ...
d1 $ sound "bd sd"
-- ...
d1 $ sound "bd sd hh*8"
-- ...add effects
d1 $ sound "bd sd hh*8" # cutoff (range 200 8000 sine)

-- Drop: Everything stops or minimal
hush
d1 $ sound "bd ~ ~ ~" # room 0.9

-- Build again: Faster, more intense
d1 $ fast 2 $ sound "bd sd hh*8 cp*2"
d2 $ sound "arpy(5,8)" # speed 2
```

### Call and Response

```haskell
-- Pattern 1 (call)
d1 $ sound "bd sd ~ ~"

-- Pattern 2 (response)
d2 $ sound "~ ~ arpy arpy"

-- Alternate
d1 $ sound "<bd ~ ~ ~, ~ sd ~ ~>"
d2 $ sound "<~ ~ arpy ~, ~ ~ ~ arpy>"
```

## Error Recovery

### Quick Fixes

```haskell
-- If something goes wrong:
d1 silence  -- mute problematic channel

-- Or silence all:
hush

-- Then rebuild slowly
d1 $ sound "bd"
```

### Safety Patterns

```haskell
-- Keep a simple fallback ready
let safe = sound "bd ~ ~ ~"

-- If things get chaotic:
hush
d1 $ safe
```

## Improvisation Strategies

### Prepared Variations

```haskell
-- Base pattern
d1 $ sound "bd sd hh cp"

-- Variation 1: Speed
d1 $ fast 2 $ sound "bd sd hh cp"

-- Variation 2: Effects
d1 $ sound "bd sd hh cp" # crush 4 # room 0.5

-- Variation 3: Structure
d1 $ every 2 (rev) $ sound "bd sd hh cp"

-- Variation 4: Density
d1 $ sound "bd*2 sd hh*4 cp"
```

### Responsive Playing

```haskell
-- Listen and react
-- If too busy: simplify
d1 $ sound "bd ~ ~ ~"

-- If too sparse: add
d1 $ sound "bd sd hh*8 cp"

-- If too static: add variation
d1 $ sometimes (# speed 2) $ sound "bd sd hh cp"
```

## Working with Others

### Complementary Patterns

```haskell
-- Leave space for other performers
d1 $ sound "bd ~ ~ ~"  -- sparse kick
d2 $ sound "~ ~ hh*4 ~"  -- hi-hats in gaps

-- Different frequency ranges
d1 $ sound "bd sd"  -- low
d2 $ n (scale "major" "7 9 11 14") # sound "superpiano"  -- high
```

### Communication Through Code

```haskell
-- Use channel numbers to coordinate
-- Agree: d1-d4 for one person, d5-d8 for another

-- Person 1
d1 $ sound "bd sd"
d2 $ sound "hh*8"

-- Person 2
d5 $ n (scale "minor" "0 2 4 7") # sound "superpiano"
d6 $ sound "arpy(3,8)"
```

## Tips for Live Performance

- **Practice transitions** between patterns
- **Start minimal** and build up
- **Leave space** - not every channel needs to be active
- **Listen more than you code** - let patterns develop
- **Have escape routes** - know how to quickly simplify or reset
- **Embrace mistakes** - they can lead to interesting places
- **Vary dynamics** - use gain and effects for dynamics
- **Create tension and release** - build energy, then drop it
- **Use `every`** for predictable structure
- **Keep backups** - save interesting patterns as you go
