# Getting Started with TidalCycles

## What is TidalCycles?

TidalCycles (or "Tidal") is a live coding environment for algorithmic music and pattern manipulation. It allows you to create complex musical patterns using a concise, expressive syntax inspired by Haskell.

## Installation

### Prerequisites
- SuperCollider (audio synthesis engine)
- SuperDirt (sample library and synthesis engine for SuperCollider)
- Haskell (GHC and cabal)
- A text editor with Tidal integration (Atom, VS Code, Emacs, Vim)

### Basic Setup

1. Install SuperCollider from https://supercollider.github.io/
2. Install SuperDirt by running in SuperCollider:
   ```
   Quarks.checkForUpdates({Quarks.install("SuperDirt", "v1.7.3"); thisProcess.recompile()})
   ```
3. Install TidalCycles:
   ```bash
   cabal update
   cabal install tidal
   ```

## First Steps

### Starting a Session

1. Start SuperCollider and run:
   ```
   SuperDirt.start
   ```

2. In your editor, create a new Tidal file (.tidal) and connect to Tidal

### Your First Pattern

```haskell
-- Play a simple kick drum pattern
d1 $ sound "bd sd bd sd"

-- Stop the pattern
d1 silence
```

## Basic Concepts

### Channels
TidalCycles uses channels (d1, d2, d3, etc.) to organize different musical streams:
```haskell
d1 $ sound "bd sd"    -- Channel 1: drums
d2 $ sound "arpy"     -- Channel 2: melody
```

### Patterns
Everything in Tidal is a pattern. Patterns can be transformed, combined, and manipulated:
```haskell
-- Simple pattern
d1 $ sound "bd sd hh cp"

-- Repeated pattern
d1 $ sound "bd*4"

-- Pattern with rests
d1 $ sound "bd ~ sd ~"
```

### Silencing
```haskell
-- Silence specific channel
d1 silence

-- Silence all channels
hush
```

## Next Steps

- Explore pattern transformations (see `02-pattern-basics.md`)
- Learn about sample manipulation (see `03-samples-and-synths.md`)
- Study effects and parameters (see `04-effects.md`)
