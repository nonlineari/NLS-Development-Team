# Advanced Pattern Techniques

## Conditional Transformations

### Sometimes Functions
```haskell
-- sometimes: 50% chance
d1 $ sometimes (# speed 2) $ sound "bd sd hh cp"

-- often: 75% chance
d1 $ often (# crush 4) $ sound "bd sd hh cp"

-- rarely: 25% chance
d1 $ rarely (# vowel "a") $ sound "bd sd hh cp"

-- almostNever: 10% chance
d1 $ almostNever (rev) $ sound "bd sd hh cp"

-- almostAlways: 90% chance
d1 $ almostAlways (# gain 1.2) $ sound "bd sd hh cp"
```

### someCycles and someBy
```haskell
-- someCycles: apply to certain cycles
d1 $ someCycles (fast 2) $ sound "bd sd"

-- someBy: specify probability (0-1)
d1 $ someBy 0.3 (# speed 2) $ sound "bd sd hh cp"
```

### Every
```haskell
-- every: apply transformation every n cycles
d1 $ every 4 (rev) $ sound "bd sd hh cp"

-- every with multiple transformations
d1 $ every 3 (fast 2 . rev) $ sound "bd sd hh cp"

-- every': apply transformation on specific cycle
d1 $ every' 4 2 (# crush 4) $ sound "bd sd hh cp"
```

## Polyrhythm and Polymetric Patterns

### Curly Braces (Polymeter)
```haskell
-- Different length patterns cycling independently
d1 $ sound "{bd sd cp, hh hh hh hh hh}"

-- Three against four
d1 $ sound "{bd sd cp, hh hh hh hh}"

-- Complex polymeters
d1 $ sound "{bd sd, hh*8, arpy(3,8)}"
```

### Angle Brackets (Alternation)
```haskell
-- Alternate between patterns each cycle
d1 $ sound "bd <sd cp> bd <hh hh hh>"

-- Alternate effects
d1 $ sound "bd sd" # speed "<1 1.5 2 0.5>"

-- Nested alternation
d1 $ sound "bd <sd <cp hh>>"
```

## Advanced Time Manipulation

### Compress and Fastcat
```haskell
-- compress: fit pattern into time range (0-1)
d1 $ compress (0, 0.5) $ sound "bd sd hh cp"

-- fastcat: concatenate patterns quickly
d1 $ fastcat [
  sound "bd*4",
  sound "sd*4",
  sound "hh*8"
]

-- timeCat: specify relative durations
d1 $ timeCat [
  (1, sound "bd*4"),
  (2, sound "sd*2"),
  (1, sound "hh*8")
]
```

### Swing and Shuffle

```haskell
-- swing: add groove
d1 $ swingBy (1/3) 4 $ sound "bd*8"

-- shuffle: shuffle steps
d1 $ shuffle 4 $ sound "bd sd hh cp"

-- scramble: randomly reorder
d1 $ scramble 4 $ sound "bd sd hh cp"
```

### Offset and Rotation

```haskell
-- <~: rotate left (negative phase)
d1 $ (0.25 <~) $ sound "bd sd hh cp"

-- ~>: rotate right (positive phase)
d1 $ (0.25 ~>) $ sound "bd sd hh cp"

-- Pattern offset
d1 $ every 4 (0.25 <~) $ sound "bd sd hh cp"
```

## Pattern Structure

### Struct and Substruct
```haskell
-- struct: impose rhythm structure
d1 $ struct "t t ~ t" $ sound "bd"

-- Use with euclidean patterns
d1 $ struct "t(5,8)" $ sound "bd"

-- substruct: remove events
d1 $ substruct "t ~ t ~" $ sound "bd sd hh cp"
```

### Mask
```haskell
-- mask: show pattern only where mask is true
d1 $ mask "t t ~ t" $ sound "bd sd hh cp"

-- Pattern boolean operations
d1 $ mask "<t f>" $ sound "bd sd"
```

## Generative Techniques

### Degradation
```haskell
-- degrade: randomly remove events (50%)
d1 $ degrade $ sound "bd sd hh cp"

-- degradeBy: specify probability
d1 $ degradeBy 0.3 $ sound "bd sd hh cp"

-- unDegradeBy: randomly add events
d1 $ unDegradeBy 0.2 $ sound "bd ~ sd ~"
```

### Weighted Randomness
```haskell
-- wchoose: weighted random choice
d1 $ sound (wchoose [("bd", 3), ("sd", 1), ("hh", 2)])

-- cycleChoose: choose once per cycle
d1 $ sound (cycleChoose ["bd sd", "hh cp", "arpy"])
```

### Range and Scale
```haskell
-- range: map pattern to range
d1 $ sound "bd*8" # gain (range 0.5 1 sine)

-- scale: scale values
d1 $ sound "bd sd" # speed (scale 0.5 2 rand)
```

## Complex Pattern Operators

### Operator Patterns
```haskell
-- |+| : add patterns together
d1 $ note "0 2 4" |+| note "7" # sound "superpiano"

-- |*| : multiply patterns
d1 $ sound "bd*8" # speed (1 |*| "1 1.5 2 0.5")

-- |/| : divide patterns
d1 $ sound "bd sd" # speed (2 |/| "1 2 4")

-- |-| : subtract patterns
d1 $ note "7 5 0" |-| note "0 2 0" # sound "superpiano"
```

### Pattern Arithmetic
```haskell
-- Combine numeric patterns
d1 $ note ("0 2 4" |+| "<0 3 7>") # sound "superpiano"

-- Complex combinations
d1 $ sound "arpy" 
  # n ("0 1 2" |+| (irand 4))
  # speed ("1 1.5" |*| "1 0.5")
```

## State and Memory

### Binary Pattern
```haskell
-- Binary representation
d1 $ sound "bd*8" # pan (binary "10101010")
```

### Signal Functions
```haskell
-- sig: constant signal
d1 $ sound "bd sd" # gain (sig 0.8)

-- Multiple signal sources
d1 $ sound "bd sd" 
  # cutoff (sine * 2000 + 500)
  # resonance (tri * 0.3)
```

## Mini-Notation Advanced

### Replicate with !
```haskell
-- ! replicates previous value
d1 $ sound "bd!3 sd"  -- equivalent to "bd bd bd sd"

-- Pattern replication
d1 $ sound "bd ! sd ! hh ! cp !"
```

### Elongate with @
```haskell
-- @ makes step longer
d1 $ sound "bd@3 sd"  -- bd lasts 3 times longer

-- Combine with other notation
d1 $ sound "bd@2 sd hh@3 cp"
```

### Choice with |
```haskell
-- | randomly chooses one per cycle
d1 $ sound "bd | sd | hh | cp"

-- Nested choices
d1 $ sound "[bd | sd] [hh | cp | ~]"
```

## Tips for Advanced Patterns

- Layer conditional transformations for emergent complexity
- Combine polymeters with euclidean rhythms
- Use `every` with different periods for evolving patterns
- Mix deterministic and random elements
- Start simple and add complexity gradually
- Listen for unintended phase relationships in polymeter
