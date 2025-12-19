# TidalCycles Resources

This directory contains comprehensive resources for learning and using TidalCycles, a live coding environment for algorithmic music.

## Structure

### Livecode Manuals (`livecode-manuals/`)

A complete guide to TidalCycles, organized into 10 comprehensive manuals:

1. **[Getting Started](livecode-manuals/01-getting-started.md)** - Installation, setup, and basic concepts
2. **[Pattern Basics](livecode-manuals/02-pattern-basics.md)** - Core pattern syntax and transformations
3. **[Samples and Synths](livecode-manuals/03-samples-and-synths.md)** - Working with samples and built-in synthesizers
4. **[Effects](livecode-manuals/04-effects.md)** - Audio effects and processing techniques
5. **[Advanced Patterns](livecode-manuals/05-advanced-patterns.md)** - Complex pattern manipulation and generative techniques
6. **[Scales and Melody](livecode-manuals/06-scales-and-melody.md)** - Musical scales, harmony, and melodic composition
7. **[Performance Techniques](livecode-manuals/07-performance-techniques.md)** - Live performance strategies and improvisation
8. **[MIDI/OSC Integration](livecode-manuals/08-midi-osc-integration.md)** - External hardware and software integration
9. **[Troubleshooting](livecode-manuals/09-troubleshooting.md)** - Common issues and solutions
10. **[Quick Reference](livecode-manuals/10-reference-quick.md)** - Cheat sheet for common commands and patterns

### Projects (`projects/`)

Directory for your TidalCycles projects and live coding sessions.

## Quick Start

### Prerequisites

- SuperCollider (audio synthesis engine)
- SuperDirt (sample library)
- Haskell (GHC and cabal)
- Text editor with Tidal support (Atom, VS Code, Emacs, Vim)

### Basic Workflow

1. Start SuperCollider and run: `SuperDirt.start`
2. Open your editor and connect to Tidal
3. Write patterns and evaluate them
4. Explore the manuals to learn more techniques

### First Pattern

```haskell
-- Play a simple drum pattern
d1 $ sound "bd sd bd sd"

-- Silence it
d1 silence
```

## Learning Path

**Beginners**: Start with manuals 1-4 to learn the basics
- Getting Started → Pattern Basics → Samples/Synths → Effects

**Intermediate**: Explore manuals 5-7 for advanced techniques
- Advanced Patterns → Scales/Melody → Performance Techniques

**Advanced**: Check manuals 8-9 for integration and troubleshooting
- MIDI/OSC Integration → Troubleshooting

**Always handy**: Keep manual 10 (Quick Reference) open while coding

## Resources

### Official Documentation
- [TidalCycles Website](https://tidalcycles.org/)
- [Pattern Reference](https://tidalcycles.org/docs/patternlib/)
- [Forum](https://club.tidalcycles.org/)

### Community
- Discord: TidalCycles community server
- TOPLAP: International live coding community
- GitHub: https://github.com/tidalcycles/Tidal

## Tips

- **Start simple**: Begin with basic patterns and build complexity
- **Save often**: Keep backups of interesting patterns
- **Listen first**: Let patterns develop before changing them
- **Have fun**: Embrace mistakes as creative opportunities
- **Join the community**: Share your work and learn from others

## Contributing

Feel free to add your own projects, examples, and documentation to this repository.

## License

These manuals are provided as educational resources. TidalCycles itself is licensed under GPL-3.0.
