# Pattern Basics

## Pattern Syntax

### Simple Sequences
```haskell
-- Space-separated items play in sequence
d1 $ sound "bd sd hh cp"

-- Play one cycle (4 beats by default)
d1 $ sound "kick snare"
```

### Repetition and Subdivision

```haskell
-- Multiply: repeat within a step
d1 $ sound "bd*4"  -- plays 4 kicks in one beat

-- Divide: slow down
d1 $ sound "bd/2"  -- plays kick every 2 cycles

-- Combine them
d1 $ sound "bd*2 sd hh*4 cp"
```

### Rests
```haskell
-- Tilde (~) represents silence
d1 $ sound "bd ~ sd ~"

-- Multiple rests
d1 $ sound "bd ~ ~ ~"
```

### Subsequences with Brackets
```haskell
-- Square brackets create subdivisions
d1 $ sound "bd [sd sd]"  -- sd plays twice as fast

-- Nested brackets
d1 $ sound "bd [sd [hh hh hh]]"

-- Curly braces for polyrhythm
d1 $ sound "{bd sd hh, arpy arpy arpy arpy}"
```

## Pattern Transformations

### Speed and Time

```haskell
-- fast: speed up pattern
d1 $ fast 2 $ sound "bd sd hh cp"

-- slow: slow down pattern
d1 $ slow 2 $ sound "bd sd hh cp"

-- hurry: speed up and increase pitch
d1 $ hurry 2 $ sound "bd sd hh cp"
```

### Structure Manipulation

```haskell
-- rev: reverse pattern
d1 $ rev $ sound "bd sd hh cp"

-- every: apply transformation periodically
d1 $ every 4 (rev) $ sound "bd sd hh cp"

-- iter: rotate pattern over cycles
d1 $ iter 4 $ sound "bd sd hh cp"

-- chunk: apply function to chunks
d1 $ chunk 4 (fast 2) $ sound "bd sd hh cp"
```

### Density and Repetition

```haskell
-- density: alias for fast
d1 $ density 2 $ sound "bd sd"

-- compress: fit pattern into smaller timespan
d1 $ compress (0, 0.5) $ sound "bd sd hh cp"

-- elongate: stretch a pattern
d1 $ slow 2 $ sound "bd sd hh cp"
```

## Combining Patterns

### Layering with Commas
```haskell
-- Play patterns simultaneously on same channel
d1 $ sound "bd sd, hh*8, arpy"
```

### Stack
```haskell
-- Stack multiple patterns
d1 $ stack [
  sound "bd sd",
  sound "hh*8",
  sound "arpy(3,8)"
]
```

### Cat (Concatenation)
```haskell
-- Play patterns in sequence
d1 $ cat [
  sound "bd sd",
  sound "hh cp",
  sound "arpy"
]

-- slowcat: one pattern per cycle
d1 $ slowcat [
  sound "bd*4",
  sound "sd*4",
  sound "hh*4"
]
```

## Euclidean Rhythms

```haskell
-- Euclidean syntax: sound(hits, steps)
d1 $ sound "bd(3,8)"  -- 3 hits distributed over 8 steps

-- With rotation
d1 $ sound "bd(3,8,2)"  -- rotate by 2 steps

-- Complex euclidean patterns
d1 $ sound "bd(5,8) sd(3,8,2) hh(7,8)"
```

## Randomness

```haskell
-- rand: random continuous values (0-1)
d1 $ sound "bd*8" # pan rand

-- irand: random integers
d1 $ sound "arpy" # n (irand 8)

-- sometimes: randomly apply transformation
d1 $ sometimes (# speed 2) $ sound "bd sd hh cp"

-- choose: randomly choose from list
d1 $ sound (choose ["bd", "sd", "hh"])
```

## Tips

- Use parentheses to control order of operations
- Chain transformations with `$` or `.`
- Experiment with combining multiple transformations
- Listen to how each transformation affects the pattern
