# TidalCycles → Renoise Integration

This guide sets up a reliable path from TidalCycles into Renoise on macOS.

Recommended path: MIDI via the IAC Driver (simple, low-latency, works with Ableton too). Optional: OSC via the xRules tool.

## Option A — MIDI (Recommended)

### 1) Create a virtual MIDI bus (IAC)

1. Open "Audio MIDI Setup" (spotlight search)
2. Window → Show MIDI Studio
3. Double‑click "IAC Driver"
4. Check "Device is online"
5. Click + to add a Port named "IAC Bus 1"

### 2) Send MIDI from TidalCycles

Use the sample `tidal-to-renoise.tidal` file in this folder, or paste into your editor:

```haskell
:{
import Sound.Tidal.Context
import Sound.Tidal.MIDI.Context

-- List MIDI devices
:{
devs <- midiDevices
:}

-- Connect to the IAC virtual bus on channel 1
-- Replace "IAC Driver Bus 1" with the exact name if different
m1 <- midiStream devs "IAC Driver Bus 1" 1 synthController

-- Basic note pattern (C minor pentatonic)
m1 $ note "0 3 5 7" # velocity 0.9 # sustain 0.25

-- Euclidean rhythm driving notes
m1 $ note (scale "minorPent" "0 3 5 7") # legato 0.9 # up "<0 12>" # gain 1
:}
```

Notes:
- `note` takes semitone values relative to C (0 = C, 12 = C next octave).
- Use `velocity` (0–1) and `sustain` (seconds) to shape notes.
- Use `midichan` to change the MIDI channel if needed.

### 3) Receive MIDI in Renoise

1. In Renoise, create or select an Instrument
2. Set MIDI Input Device = "IAC Driver Bus 1"
3. Set Channel = 1 (match the one used in Tidal)
4. Arm a track and play — you should hear notes

Tip: Use multiple IAC ports or channels to separate drum/bass/melody.

---

## Option B — OSC (xRules tool)

If you prefer OSC control and per‑parameter mapping, install the xRules tool inside Renoise:

1. Renoise → Tools → Tool Browser → search for "xRules" → Install
2. Enable OSC server in xRules and create a rule that listens to `/renoise/trigger/note_on` with 4 integer args (instrument, track, note, velocity)
3. In Tidal, you will need a custom Boot file to send these messages (see `BootTidal-renoise.hs.example`).

Note: Direct OSC triggering needs more setup; MIDI is simpler for most workflows.

---

## Ableton Link / hybrid setups

- Renoise supports Ableton Link for tempo/phase sync (enable in Preferences → MIDI/Sync). Use Link for tempo, and MIDI or OSC for actual note/event transport.
- With Link enabled in Renoise and Ableton/VDMX (or other Link apps), tempo will stay in sync automatically.

---

## Files in this folder

- `tidal-to-renoise.tidal` — example Tidal MIDI session
- `BootTidal-renoise.hs.example` — sketch of a custom OSC target if you want to experiment

---

## Troubleshooting

- No MIDI in Renoise? Verify the IAC bus is Online and selected on the instrument.
- Notes cut off? Adjust `sustain` or disable note-off quantization in Renoise.
- Off-by-latency? Use smaller audio buffer in Renoise; in Tidal reduce MIDI latency by tightening your patterns (MIDI is generally snappy).
