# VS Code Setup for TidalCycles

## Installation Steps

### 1. Install TidalCycles Extension

Open VS Code and install the TidalCycles extension:

```bash
code --install-extension tidalcycles.vscode-tidalcycles
```

Or manually:
1. Open VS Code
2. Press `Cmd+Shift+X` to open Extensions
3. Search for "TidalCycles"
4. Click "Install" on the extension by tidalcycles

### 2. Configure the Extension

Create or edit VS Code settings:

**Option A: Workspace Settings** (recommended)
1. In VS Code, press `Cmd+Shift+P`
2. Type "Preferences: Open Workspace Settings (JSON)"
3. Add the following configuration:

```json
{
    "tidalcycles.bootTidalPath": "~/.ghcup/bin",
    "tidalcycles.ghciPath": "~/.ghcup/bin/ghci",
    "tidalcycles.feedbackColor": "rgba(100,250,100,0.3)",
    "tidalcycles.showEvalCount": true,
    "tidalcycles.showOutput": true
}
```

**Option B: User Settings**
1. Press `Cmd+,` to open Settings
2. Search for "TidalCycles"
3. Set the paths manually in the UI

### 3. Create a Tidal File

Create a new file with `.tidal` extension:

```bash
touch test.tidal
code test.tidal
```

### 4. Start TidalCycles

In VS Code with a `.tidal` file open:

1. **Boot Tidal**: Press `Cmd+Shift+P` → "Tidal: Start"
   - Or use default shortcut: `Cmd+Shift+Enter`

2. **Verify connection**: You should see "Tidal started" in the output panel

### 5. Test Your Setup

In your `.tidal` file, type:

```haskell
d1 $ sound "bd sd hh cp"
```

**Evaluate the line**:
- Press `Shift+Enter` (evaluate single line)
- Or select multiple lines and press `Shift+Enter`

You should:
- See green feedback flash on the line
- Hear a drum pattern playing
- See evaluation count in the status bar

### 6. Stop Sound

```haskell
-- Stop one channel
d1 silence

-- Stop all channels
hush
```

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Boot Tidal | `Cmd+Shift+Enter` |
| Evaluate line/selection | `Shift+Enter` |
| Stop all sound (hush) | `Cmd+Alt+H` |
| Evaluate multiple lines | Select → `Shift+Enter` |

## Troubleshooting

### "Cannot find ghci"

If VS Code can't find GHCi, set the full path in settings:

```json
{
    "tidalcycles.ghciPath": "~/.ghcup/bin/ghci"
}
```

### "No connection to SuperCollider"

1. Make sure SuperCollider is running
2. Ensure SuperDirt is started: `SuperDirt.start`
3. Check port 57120 is not blocked

### "Cannot boot Tidal"

Try restarting VS Code and ensuring:
- SuperCollider is running with SuperDirt
- The BootTidal.hs file is found
- GHCi is in your PATH

### Check GHCi

Run in terminal:
```bash
~/.ghcup/bin/ghci
```

Should show GHCi prompt. Type `:quit` to exit.

## Workflow

1. **Start SuperCollider** → Run `SuperDirt.start` (or use startup.scd)
2. **Open VS Code** → Open `.tidal` file
3. **Boot Tidal** → `Cmd+Shift+Enter`
4. **Write patterns** → Evaluate with `Shift+Enter`
5. **Live code!** → Edit and re-evaluate in real-time

## Sample Project Structure

```
my-tidal-project/
├── patterns/
│   ├── drums.tidal
│   ├── bass.tidal
│   └── melody.tidal
├── sessions/
│   └── session-2024-01-15.tidal
└── samples/
    └── (custom samples)
```

## Tips

- Use `Shift+Enter` frequently to hear changes immediately
- Keep the Quick Reference manual open
- Start with simple patterns and build complexity
- Save your patterns in organized files
- Use `hush` to silence everything quickly

## Next Steps

1. Review the livecode manuals in `livecode-manuals/`
2. Start with `01-getting-started.md`
3. Try the examples in `10-reference-quick.md`
4. Save your first patterns in the `projects/` folder
