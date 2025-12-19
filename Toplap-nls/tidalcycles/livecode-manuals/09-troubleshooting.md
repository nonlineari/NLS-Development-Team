# Troubleshooting Guide

## Installation Issues

### SuperDirt Not Starting

**Problem**: SuperDirt fails to start in SuperCollider

```
// Try recompiling the class library
thisProcess.recompile

// Check if SuperDirt is installed
Quarks.installed

// Reinstall if necessary
Quarks.uninstall("SuperDirt")
Quarks.install("SuperDirt")
thisProcess.recompile
```

**Solution**: Ensure all dependencies are installed:
- SC3-plugins
- Vowel synth
- Dirt-Samples

### Tidal Not Connecting

**Problem**: Editor can't connect to SuperCollider

**Check**:
1. Is SuperCollider running?
2. Is SuperDirt started? (`SuperDirt.start`)
3. Is port 57120 available?

**Solution**:
```
// In SuperCollider, verify SuperDirt is running
~dirt.postln;  // Should show SuperDirt instance

// Restart SuperDirt
~dirt.stop;
~dirt.free;
SuperDirt.start;
```

### Haskell/Cabal Issues

**Problem**: `cabal install tidal` fails

**Solution**:
```bash
# Update package list
cabal update

# Clear cache if needed
rm -rf ~/.cabal/store

# Try installing with specific version
cabal install tidal --lib

# Check GHC version compatibility
ghc --version  # Should be 8.6 or later
```

## Audio Issues

### No Sound Output

**Problem**: Patterns run but no audio

**Check**:
1. Is SuperCollider audio server running?
   ```
   s.boot;  // Boot audio server
   ```

2. Is SuperDirt connected to audio?
   ```
   s.meter;  // Check levels
   ```

3. Are samples loaded?
   ```
   // Check sample paths
   ~dirt.soundLibrary.postln;
   ```

**Solution**:
```
// Restart audio server
s.quit;
s.boot;
SuperDirt.start;
```

### Distorted/Clipping Audio

**Problem**: Audio is distorted

**Solution**:
```
// Lower overall gain in SuperCollider
~dirt.orbits.do { |x| x.outBus.postln; }
~dirt.orbits[0].set(\amp, 0.5);  // Reduce volume

// Or in Tidal, lower gain
d1 $ sound "bd sd" # gain 0.7
```

### Latency Issues

**Problem**: Noticeable delay between code execution and sound

**Solution**:
```
// In SuperCollider, adjust buffer size
s.options.blockSize = 64;  // Lower = less latency
s.options.numBuffers = 1024 * 256;
s.reboot;
```

Or adjust in Tidal:
```haskell
-- Adjust nudge to compensate
d1 $ sound "bd sd" # nudge 0.1
```

## Pattern Issues

### Pattern Not Playing

**Problem**: Code executes but pattern doesn't sound

**Checklist**:
1. Is channel silenced?
   ```haskell
   d1 silence  -- Unintentionally silenced?
   ```

2. Is gain too low?
   ```haskell
   d1 $ sound "bd sd" # gain 1.0  -- Try explicit gain
   ```

3. Is pattern empty?
   ```haskell
   -- Check for empty patterns
   d1 $ sound "~ ~ ~ ~"  -- All rests
   ```

### Unexpected Rhythm

**Problem**: Pattern doesn't play as expected

**Common causes**:
- Mismatched brackets: `[` vs `{` vs `<`
- Wrong operator precedence
- Missing `$` operator

**Debug**:
```haskell
-- Simplify pattern to isolate issue
d1 $ sound "bd"  -- Does this work?
d1 $ sound "bd sd"  -- How about this?
d1 $ sound "bd sd hh cp"  -- Add complexity gradually
```

### Pattern Timing Issues

**Problem**: Pattern feels off-tempo

**Check tempo**:
```haskell
-- Verify CPS (cycles per second)
cps

-- Set tempo explicitly (120 BPM)
setcps (120/60/4)

-- Or in SuperCollider
~dirt.orbits[0].tempo.postln;
```

## Syntax Errors

### Haskell Parse Errors

**Common errors**:

1. **Missing `$`**:
   ```haskell
   -- Wrong:
   d1 fast 2 sound "bd sd"
   
   -- Right:
   d1 $ fast 2 $ sound "bd sd"
   ```

2. **Bracket mismatch**:
   ```haskell
   -- Wrong:
   d1 $ sound "bd [sd hh"
   
   -- Right:
   d1 $ sound "bd [sd hh]"
   ```

3. **Quote mismatch**:
   ```haskell
   -- Wrong:
   d1 $ sound "bd sd'
   
   -- Right:
   d1 $ sound "bd sd"
   ```

### Mini-notation Errors

**Common issues**:

1. **Bracket types**:
   - `[ ]` - subdivision
   - `{ }` - polymeter
   - `< >` - alternation

2. **Operator spacing**:
   ```haskell
   -- Wrong:
   d1 $ sound "bd*4sd"
   
   -- Right:
   d1 $ sound "bd*4 sd"
   ```

## Performance Issues

### CPU Too High

**Problem**: High CPU usage, audio dropouts

**Solutions**:

1. **Reduce polyphony**:
   ```haskell
   -- Limit concurrent sounds
   d1 $ sound "bd sd" # cut 1
   ```

2. **Simplify effects**:
   ```haskell
   -- Remove expensive effects temporarily
   -- room, delay can be CPU-intensive
   ```

3. **In SuperCollider**:
   ```
   // Increase number of audio buffers
   s.options.numBuffers = 1024 * 256;
   s.options.memSize = 8192 * 64;
   s.reboot;
   ```

### Memory Issues

**Problem**: System runs out of memory

**Solution**:
```
// In SuperCollider, increase memory
s.options.memSize = 8192 * 64;  // Increase memory
s.reboot;

// Check memory usage
s.meter;
s.scope;
```

## Editor Issues

### Evaluation Not Working

**Problem**: Code doesn't execute when triggered

**Check**:
1. Is editor connected to Tidal?
2. Is correct text selected?
3. Are shortcuts configured correctly?

**Common fixes**:
- Restart editor
- Reconnect to Tidal (varies by editor)
- Check editor plugin installation

### Multi-line Evaluation

**Problem**: Only first line executes

**Solution**: Ensure editor is configured for block evaluation:
- Atom: Select all lines and evaluate
- VS Code: Check multi-line evaluation settings
- Vim: Use visual block mode
- Emacs: Use appropriate region evaluation

## Sample Issues

### Sample Not Found

**Problem**: `sound "mysample"` produces no sound

**Check**:
```
// In SuperCollider, verify sample paths
~dirt.soundLibrary.postln;

// Add custom sample path
~dirt.loadSoundFiles("/path/to/samples/*");
```

**Solution**:
1. Verify sample folder name matches
2. Check samples are in Dirt-Samples format (folders with samples)
3. Ensure SuperDirt has read permissions

### Custom Samples Not Loading

**Problem**: Custom samples don't load

**Setup**:
```
// In SuperCollider, before SuperDirt.start
~dirt = SuperDirt(2, s);
~dirt.loadSoundFiles("/path/to/custom/samples/*");
~dirt.start(57120, [0, 0]);

// Verify loaded
~dirt.soundLibrary.postln;
```

## Effect Issues

### Effect Not Working

**Problem**: Effect parameter seems to have no impact

**Check**:
1. Is effect value in correct range?
2. Is effect supported by current sound?

**Debug**:
```haskell
-- Try with obvious value
d1 $ sound "bd sd" # crush 1  -- Very obvious

-- Check if sample supports effect
d1 $ sound "superpiano" # note 0 # cutoff 500  -- Synths support filters
```

## Common Mistakes

### Forgetting to Start SuperDirt

**Remember**:
```
// In SuperCollider, BEFORE using Tidal:
SuperDirt.start
```

### Wrong Channel Number

```haskell
-- Channels d1-d9, then d10, d11, etc.
-- Not d01, d02...

d1 $ sound "bd"  -- ✓ Correct
d01 $ sound "bd"  -- ✗ Wrong
```

### Operator Precedence

```haskell
-- Wrong precedence:
d1 $ sound "bd sd" # gain 0.8 # cutoff 2000 fast 2

-- Correct:
d1 $ fast 2 $ sound "bd sd" # gain 0.8 # cutoff 2000
```

## Emergency Fixes

### Everything is Broken

```haskell
-- Nuclear option: silence everything
hush

-- Restart SuperCollider
-- In SuperCollider:
s.quit;
s.boot;
SuperDirt.start;

-- Start fresh in Tidal
d1 $ sound "bd"
```

### Stuck in a Loop

```haskell
-- If pattern is overwhelming/stuck:
hush  -- Silence all

-- Then rebuild carefully
d1 $ sound "bd ~ ~ ~"  -- Simple pattern
```

## Getting Help

### Where to Ask

1. **TidalCycles Forum**: https://club.tidalcycles.org/
2. **Discord**: TidalCycles community
3. **GitHub Issues**: For bugs
4. **Stack Overflow**: Tag `tidalcycles`

### Information to Include

- TidalCycles version
- SuperCollider version
- Operating system
- Editor being used
- Full error message
- Minimal code that reproduces issue

### Check Documentation

- Official docs: https://tidalcycles.org/
- Pattern reference: https://tidalcycles.org/docs/patternlib/
- Function list: https://tidalcycles.org/docs/reference/

## Preventive Measures

### Regular Backups

```bash
# Save your code regularly
# Use version control
git init
git add *.tidal
git commit -m "Backup"
```

### Test Before Performance

- Boot SuperCollider and test samples
- Verify MIDI connections
- Check audio routing
- Test all channels (d1-d12)
- Have simple fallback patterns ready

### Keep It Simple

- Start with basic patterns
- Add complexity gradually
- Test each change
- Keep a simple pattern ready for recovery
