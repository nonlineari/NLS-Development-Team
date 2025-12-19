# Complete TidalCycles Installation Guide

## Current Status ✅

Already installed on your M4 Mac:
- ✅ GHC (Haskell compiler) - `~/.ghcup/bin/ghc`
- ✅ Cabal (package manager) - `~/.ghcup/bin/cabal`
- ✅ TidalCycles 1.9.5
- ✅ Tidal-Link 1.0.3
- ✅ SuperCollider - `/Applications/SuperCollider.app`
- ✅ VS Code - `/Applications/Visual Studio Code.app`

## What You Need to Do

### Step 1: Install SuperDirt in SuperCollider

1. **Open SuperCollider**
   ```bash
   open /Applications/SuperCollider.app
   ```

2. **Install SuperDirt**
   
   Copy and paste this code into SuperCollider and press `Cmd+Enter`:
   
   ```supercollider
   Quarks.checkForUpdates({
       Quarks.install("SuperDirt", "v1.7.3");
       Quarks.install("SC3plugins");
       thisProcess.recompile();
   });
   ```

3. **Restart SuperCollider** after installation completes

4. **Test SuperDirt**
   
   In SuperCollider, run:
   ```supercollider
   SuperDirt.start
   ```
   
   You should see:
   - "SuperDirt: listening to Tidal on port 57120"
   - Sample loading messages
   - No error messages

### Step 2: Set Up SuperCollider Auto-Start (Optional but Recommended)

1. **Copy the startup file**
   ```bash
   mkdir -p ~/Library/Application\ Support/SuperCollider
   cp Toplap-nls/tidalcycles/startup.scd ~/Library/Application\ Support/SuperCollider/startup.scd
   ```

2. **Restart SuperCollider** - SuperDirt will now start automatically!

### Step 3: Install VS Code Extension

1. **Open VS Code**

2. **Install TidalCycles extension manually:**
   - Press `Cmd+Shift+X` (Extensions)
   - Search for: **"TidalCycles"**
   - Look for the extension by **"TidalCycles"** or **"kindohm"**
   - Click **Install**

   Alternative: Visit the [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=tidalcycles.vscode-tidalcycles)

### Step 4: Configure VS Code

1. **Create VS Code settings**
   
   Press `Cmd+Shift+P` → Type "Preferences: Open User Settings (JSON)"
   
   Add this configuration:
   
   ```json
   {
       "tidalcycles.bootTidalPath": "~/.ghcup/bin",
       "tidalcycles.ghciPath": "~/.ghcup/bin/ghci",
       "tidalcycles.feedbackColor": "rgba(100,250,100,0.3)",
       "tidalcycles.showEvalCount": true,
       "tidalcycles.showOutput": true
   }
   ```

### Step 5: Test Your Setup

1. **Start SuperCollider** with SuperDirt running

2. **Create a test file**
   ```bash
   cd Toplap-nls/tidalcycles/projects
   touch test.tidal
   code test.tidal
   ```

3. **In VS Code:**
   - Press `Cmd+Shift+Enter` to boot Tidal
   - You should see "Tidal started" in the output panel

4. **Type this pattern:**
   ```haskell
   d1 $ sound "bd sd hh cp"
   ```

5. **Press `Shift+Enter`** to evaluate
   - You should hear drums!
   - See green feedback on the line

6. **Stop the sound:**
   ```haskell
   hush
   ```

## Quick Test Commands

### In SuperCollider
```supercollider
// Boot the server
s.boot;

// Start SuperDirt
SuperDirt.start;

// Check if running
~dirt.postln;
```

### In VS Code (with .tidal file)
```haskell
-- Boot Tidal: Cmd+Shift+Enter

-- Test pattern: Shift+Enter on this line
d1 $ sound "bd sd hh cp"

-- Stop: Shift+Enter on this line
hush
```

## Troubleshooting

### SuperDirt Installation Fails

If `Quarks.install("SuperDirt")` fails:

1. Check internet connection
2. Try updating Quarks first:
   ```supercollider
   Quarks.checkForUpdates();
   ```
3. Restart SuperCollider and try again

### No Sound in TidalCycles

**Check:**
1. Is SuperCollider running?
2. Is SuperDirt started? Run `SuperDirt.start` in SuperCollider
3. Is your audio output working? Test with:
   ```supercollider
   { SinOsc.ar(440) * 0.1 }.play; // Should hear a tone
   ```
4. Check system audio settings

### VS Code Can't Find GHCi

1. Verify GHCi works in terminal:
   ```bash
   ~/.ghcup/bin/ghci
   ```
   Type `:quit` to exit

2. If it works, check VS Code settings have correct path

### VS Code Can't Boot Tidal

1. Check output panel for errors (View → Output → select "TidalCycles")
2. Verify SuperCollider is running with SuperDirt
3. Try restarting VS Code
4. Check that port 57120 is not blocked

## File Locations

- **SuperCollider startup file:** `~/Library/Application Support/SuperCollider/startup.scd`
- **TidalCycles boot file:** Usually auto-detected by VS Code extension
- **Your Tidal projects:** `Toplap-nls/tidalcycles/projects/`
- **Manuals:** `Toplap-nls/tidalcycles/livecode-manuals/`

## Daily Workflow

1. **Start SuperCollider** → Auto-starts SuperDirt (if using startup.scd)
2. **Open VS Code** → Open a `.tidal` file
3. **Boot Tidal** → `Cmd+Shift+Enter`
4. **Live code!** → Write patterns and evaluate with `Shift+Enter`
5. **When done** → `hush` to silence, close VS Code, quit SuperCollider

## Next Steps After Installation

1. ✅ Complete installation steps above
2. 📖 Read `01-getting-started.md` in livecode-manuals
3. 🎵 Try examples from `10-reference-quick.md`
4. 🎹 Create your first pattern in `projects/`
5. 🚀 Explore the other 8 manuals

## Getting Help

If you encounter issues:
1. Check `09-troubleshooting.md`
2. TidalCycles Forum: https://club.tidalcycles.org/
3. Discord: TidalCycles community
4. GitHub Issues: https://github.com/tidalcycles/Tidal/issues

## Summary Checklist

- [ ] Install SuperDirt in SuperCollider
- [ ] Test SuperDirt with `SuperDirt.start`
- [ ] (Optional) Copy startup.scd for auto-start
- [ ] Install TidalCycles extension in VS Code
- [ ] Configure VS Code settings with GHCi path
- [ ] Create test.tidal and boot Tidal
- [ ] Evaluate first pattern and hear sound
- [ ] Read getting-started manual
- [ ] Start live coding! 🎉
