# Scales and Melody

## Musical Scales

### Using Scales

```haskell
-- Major scale
d1 $ n (scale "major" "0 1 2 3 4 5 6 7") # sound "superpiano"

-- Minor scale
d1 $ n (scale "minor" "0 2 4 6") # sound "superpiano"

-- Pattern scale degrees
d1 $ n (scale "major" "0 2 4 7 4 2 0") # sound "superpiano"
```

### Common Scales

```haskell
-- major: Major scale
d1 $ n (scale "major" "0 2 4 7") # sound "superpiano"

-- minor: Natural minor
d1 $ n (scale "minor" "0 2 4 7") # sound "superpiano"

-- dorian: Dorian mode
d1 $ n (scale "dorian" "0 2 4 6") # sound "superpiano"

-- phrygian: Phrygian mode
d1 $ n (scale "phrygian" "0 2 4 6") # sound "superpiano"

-- lydian: Lydian mode
d1 $ n (scale "lydian" "0 2 4 6") # sound "superpiano"

-- mixolydian: Mixolydian mode
d1 $ n (scale "mixolydian" "0 2 4 6") # sound "superpiano"

-- aeolian: Aeolian mode (natural minor)
d1 $ n (scale "aeolian" "0 2 4 6") # sound "superpiano"

-- locrian: Locrian mode
d1 $ n (scale "locrian" "0 2 4 6") # sound "superpiano"
```

### Pentatonic Scales

```haskell
-- major pentatonic
d1 $ n (scale "majorPent" "0 1 2 3 4") # sound "superpiano"

-- minor pentatonic
d1 $ n (scale "minorPent" "0 1 2 3 4") # sound "superpiano"

-- egyptian: Egyptian scale
d1 $ n (scale "egyptian" "0 1 2 3 4") # sound "superpiano"
```

### World Music Scales

```haskell
-- arabic: Arabic scale
d1 $ n (scale "arabic" "0 1 2 3 4 5 6 7") # sound "superpiano"

-- indian (raga-inspired)
d1 $ n (scale "bhairav" "0 1 2 3 4 5 6 7") # sound "superpiano"

-- japanese: Japanese traditional
d1 $ n (scale "ritusen" "0 1 2 3 4") # sound "superpiano"

-- chinese: Chinese scale
d1 $ n (scale "chinese" "0 1 2 3 4") # sound "superpiano"
```

### Blues and Jazz

```haskell
-- blues scale
d1 $ n (scale "blues" "0 1 2 3 4 5") # sound "superpiano"

-- whole tone
d1 $ n (scale "whole" "0 1 2 3 4 5") # sound "superpiano"

-- diminished
d1 $ n (scale "diminished" "0 1 2 3 4 5 6 7") # sound "superpiano"
```

## Root Notes and Transposition

### Setting Root Note

```haskell
-- C major
d1 $ n (scale "major" "0 2 4 7") # sound "superpiano"

-- D major (transpose up 2 semitones)
d1 $ n (scale "major" "0 2 4 7" |+| 2) # sound "superpiano"

-- F# minor (transpose up 6 semitones)
d1 $ n (scale "minor" "0 2 4 7" |+| 6) # sound "superpiano"
```

### Dynamic Transposition

```haskell
-- Changing root note per cycle
d1 $ n (scale "major" "0 2 4 7" |+| "<0 3 7 5>") 
  # sound "superpiano"

-- Pattern transposition
d1 $ n (scale "minor" "0 2 4" |+| "0 2 3 5") 
  # sound "superpiano"
```

## Chord Construction

### Basic Chords

```haskell
-- Major triad (0 4 7)
d1 $ n "[0, 4, 7]" # sound "superpiano"

-- Minor triad (0 3 7)
d1 $ n "[0, 3, 7]" # sound "superpiano"

-- Diminished triad (0 3 6)
d1 $ n "[0, 3, 6]" # sound "superpiano"

-- Augmented triad (0 4 8)
d1 $ n "[0, 4, 8]" # sound "superpiano"
```

### Extended Chords

```haskell
-- Major 7th
d1 $ n "[0, 4, 7, 11]" # sound "superpiano"

-- Dominant 7th
d1 $ n "[0, 4, 7, 10]" # sound "superpiano"

-- Minor 7th
d1 $ n "[0, 3, 7, 10]" # sound "superpiano"

-- Half-diminished 7th
d1 $ n "[0, 3, 6, 10]" # sound "superpiano"
```

### Chord Progressions

```haskell
-- I-IV-V-I in C major
d1 $ n (scale "major" "<[0,4,7] [5,9,12] [7,11,14] [0,4,7]>")
  # sound "superpiano"

-- ii-V-I in C major
d1 $ n (scale "major" "<[2,5,9] [7,11,14] [0,4,7]>")
  # sound "superpiano"

-- Blues progression
d1 $ n (scale "blues" "<[0,4,7] [5,9,12] [0,4,7]>")
  # sound "superpiano"
```

## Arpeggios

### Basic Arpeggios

```haskell
-- Ascending arpeggio
d1 $ n (scale "major" "0 2 4 7") # sound "superpiano"

-- Descending arpeggio
d1 $ n (scale "major" "7 4 2 0") # sound "superpiano"

-- Up and down
d1 $ n (scale "major" "0 2 4 7 4 2") # sound "superpiano"
```

### Complex Arpeggios

```haskell
-- Random arpeggio notes
d1 $ n (scale "minor" (irand 8)) # sound "superpiano"

-- Euclidean arpeggio
d1 $ n (scale "major" "0 2 4 7") 
  # sound "superpiano(5,8)"

-- Layered arpeggios
d1 $ stack [
  n (scale "major" "0 2 4") # sound "superpiano",
  n (scale "major" "7 9 11") # sound "superpiano" # gain 0.7
]
```

## Melodic Patterns

### Sequences and Phrases

```haskell
-- Simple melody
d1 $ n (scale "major" "0 2 4 2 0 4 2 0") # sound "superpiano"

-- With rhythm variation
d1 $ n (scale "minor" "0*2 2 4 [2 3] 4 2 0") 
  # sound "superpiano"

-- Rests in melody
d1 $ n (scale "major" "0 2 ~ 4 ~ 2 0 ~") 
  # sound "superpiano"
```

### Melodic Transformations

```haskell
-- Reverse melody
d1 $ rev $ n (scale "major" "0 2 4 7") # sound "superpiano"

-- Speed up melody
d1 $ fast 2 $ n (scale "minor" "0 2 4 7 9 7 4 2") 
  # sound "superpiano"

-- Palindrome
d1 $ palindrome $ n (scale "major" "0 2 4 7") 
  # sound "superpiano"
```

## Rhythmic Melody

### Euclidean Melodies

```haskell
-- Euclidean rhythm with scale
d1 $ n (scale "minor" "0 2 4 7 9") 
  # sound "superpiano(5,8)"

-- Multiple euclidean melodies
d1 $ stack [
  n (scale "major" "0 2 4") # sound "superpiano(3,8)",
  n (scale "major" "7 9 11") # sound "superpiano(5,8)" # gain 0.6
]
```

### Polyrhythmic Melodies

```haskell
-- Two melodies with different lengths
d1 $ n (scale "major" "{0 2 4, 7 9 11 14}") 
  # sound "superpiano"

-- Complex polymeter
d1 $ n (scale "minor" "{0 2 4 7, 9 11 14, 16}") 
  # sound "superpiano"
```

## Advanced Harmonic Techniques

### Voice Leading

```haskell
-- Smooth voice leading between chords
d1 $ n (scale "major" 
  "<[0,4,7] [0,5,9] [2,5,9] [0,4,7]>")
  # sound "superpiano"
  # sustain 2
```

### Modal Interchange

```haskell
-- Switching between major and minor
d1 $ n (scale "<major minor>" "0 2 4 7")
  # sound "superpiano"

-- Mode per cycle
d1 $ n (scale "<major dorian phrygian lydian>" "0 2 4 7")
  # sound "superpiano"
```

### Chromatic Movement

```haskell
-- Chromatic line
d1 $ note "0 1 2 3 4 5 6 7" # sound "superpiano"

-- Chromatic passing tones
d1 $ n (scale "major" "0 2 [3 4] 5 7") # sound "superpiano"
```

## Combining Melody and Rhythm

```haskell
-- Melody with bass
d1 $ stack [
  n (scale "minor" "0 2 4 7 9 7 4 2") 
    # sound "superpiano",
  n (scale "minor" "0") 
    # sound "superpiano" 
    # octave 2
    # gain 0.8
]

-- Melody with drums
d1 $ sound "bd sd hh cp"
d2 $ n (scale "major" "0 2 4 7") 
  # sound "supermandolin"
  # delay 0.5
  # delaytime 0.25
```

## Tips

- Start with pentatonic scales for instant musicality
- Use scale degrees (0-7) rather than MIDI notes for flexibility
- Experiment with modal interchange for harmonic interest
- Layer melodies at different octaves
- Combine scales with euclidean rhythms for unexpected results
- Use `sometimes` to add variation to melodies
- Keep transposition patterns simple for harmonic clarity
