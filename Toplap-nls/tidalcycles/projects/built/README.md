# BuilT

A TidalCycles live coding project for algorithmic music and pattern exploration.

## Getting Started

1. Make sure you have TidalCycles and SuperCollider installed
2. Start SuperCollider and boot SuperDirt
3. Open `built.tidal` in your preferred editor (Atom, VSCode, etc.)
4. Boot Tidal with `Cmd+Shift+Enter` (macOS) or `Ctrl+Shift+Enter` (Linux/Windows)
5. Evaluate patterns with `Shift+Enter`

## Usage

The main file `built.tidal` contains channels for live coding:
- `d1`, `d2`, `d3`, `d4`: Audio pattern channels
- Use `hush` to stop all patterns

## Quick Reference

```haskell
-- Set tempo (120 BPM)
setcps (120/60/4)

-- Basic drum pattern
d1 $ sound "bd sd bd sd"

-- Stop all
hush
```

## Resources

- [TidalCycles Documentation](https://tidalcycles.org/)
- [TidalCycles Cheat Sheet](https://tidalcycles.org/docs/patternlib/tutorials/cheat_sheet)

## License

This project is open source and available for live coding performances and experimentation.
