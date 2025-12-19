# Visual Detection for Live Coding
## Integrating YOLO/Darknet with TidalCycles

---

## Overview

This project connects real-time object detection (YOLO/Darknet) with audio-visual live coding (TidalCycles + Hydra/VEDA).

**Use Cases:**
- Detect audience members → modulate sound density
- Track performer gestures → control effects
- Identify objects in camera feed → trigger samples
- Measure visual-audio synchronization (AP50-style metrics)

---

## Installation

### 1. Move/Link Darknet

```bash
# Option A: Move from Downloads
mv ~/Downloads/darknet-master ~/projects/darknet

# Option B: Symbolic link (keeps original location)
ln -s ~/Downloads/darknet-master ~/projects/darknet
```

### 2. Compile Darknet

```bash
cd ~/projects/darknet
make

# Test compilation
./darknet
# Should output: "usage: ./darknet <function>"
```

### 3. Download Weights (Pre-trained Model)

```bash
cd ~/projects/darknet
wget https://github.com/AlexeyAB/darknet/releases/download/darknet_yolo_v3_optimal/yolov4.weights

# Or for YOLOv7 (faster)
wget https://github.com/WongKinYiu/yolov7/releases/download/v0.1/yolov7.weights
```

---

## Architecture

```
Camera/Video Feed
      ↓
   Darknet (YOLO)
      ↓
 Object Detections (x, y, class, confidence)
      ↓
Python OSC Bridge
      ↓
   SuperCollider ← TidalCycles
      ↓           ↓
   Audio     OSC Control
              ↓
          Hydra/VEDA Visuals
```

---

## Component 1: Detection to OSC Bridge

### `detect_to_osc.py`

```python
#!/usr/bin/env python3
"""
Bridge between Darknet detections and TidalCycles via OSC
Sends detection data to SuperCollider on port 57120
"""

import subprocess
import re
from pythonosc import udp_client

OSC_IP = "127.0.0.1"
OSC_PORT = 57120

client = udp_client.SimpleUDPClient(OSC_IP, OSC_PORT)

def parse_darknet_output(line):
    """
    Parse YOLO detection format:
    'person: 85% (x=320 y=240 w=100 h=200)'
    """
    match = re.match(r'(\w+):\s+(\d+)%.*x=(\d+).*y=(\d+)', line)
    if match:
        obj_class = match.group(1)
        confidence = int(match.group(2))
        x = int(match.group(3))
        y = int(match.group(4))
        return obj_class, confidence, x, y
    return None

def run_detection(video_source=0):
    """
    Run Darknet detection on video source
    video_source: 0 for webcam, or path to video file
    """
    cmd = [
        "./darknet", "detector", "demo",
        "cfg/coco.data",
        "cfg/yolov4.cfg",
        "yolov4.weights",
        str(video_source),
        "-dont_show"  # Don't display video window
    ]
    
    process = subprocess.Popen(
        cmd,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        universal_newlines=True,
        cwd="~/projects/darknet"
    )
    
    object_counts = {}
    
    for line in process.stdout:
        line = line.strip()
        
        if "FPS:" in line:
            # Extract FPS metric
            fps = re.search(r'FPS:(\d+\.\d+)', line)
            if fps:
                client.send_message("/detection/fps", float(fps.group(1)))
        
        detection = parse_darknet_output(line)
        if detection:
            obj_class, confidence, x, y = detection
            
            # Count objects
            object_counts[obj_class] = object_counts.get(obj_class, 0) + 1
            
            # Send to TidalCycles via OSC
            client.send_message("/detection/object", [obj_class, confidence, x, y])
            client.send_message(f"/detection/count/{obj_class}", object_counts[obj_class])
            
            print(f"Detected {obj_class} at ({x}, {y}) - {confidence}% confidence")

if __name__ == "__main__":
    import sys
    video_src = sys.argv[1] if len(sys.argv) > 1 else 0
    print(f"Starting detection on source: {video_src}")
    print(f"Sending OSC to {OSC_IP}:{OSC_PORT}")
    run_detection(video_src)
```

### Install Dependencies

```bash
pip3 install python-osc
```

---

## Component 2: TidalCycles Integration

### `visual-reactive.tidal`

```haskell
-- Visual Detection Reactive Patterns
-- Receives OSC from Darknet detections

-- Import OSC control
import Sound.OSC.FD as O

-- Map detection counts to pattern density
d1 $ sound "bd*<person_count>" # gain 0.8

-- Map X position to pitch (0-640 screen width → 0-12 semitones)
d2 $ sound "arpy" 
   # note (scale 0 12 "<x_position>" / 640)

-- Map Y position to filter cutoff
d3 $ sound "bass" 
   # cutoff (scale 200 8000 "<y_position>" / 480)

-- Trigger sample when confidence > 90%
d4 $ sound (if "<confidence>" > 90 then "cp" else "~")

-- Layer based on object classes detected
do
  d1 $ whenmod 4 2 (# speed 2) 
     $ sound "bd*<person_count>"
  d2 $ sound "hh*<car_count>"
  d3 $ sound "arpy*<bottle_count>"
  
-- FPS as tempo modulation
setcps ("<fps>" / 60 / 4)

-- React to sudden object count changes
d5 $ sound "clap" 
   # orbit 1
   # room 0.8
   # size (scale 0 1 "<total_objects>" / 10)
```

### OSC Setup in Tidal Boot File

Add to `BootTidal.hs`:

```haskell
-- Receive OSC from detection system
detectionState <- newMVar 0

forkIO $ do
  udp <- O.openUDP "127.0.0.1" 57120
  forever $ do
    msg <- O.recvPacket udp
    case msg of
      Message "/detection/count/person" [Int32 count] -> 
        modifyMVar_ detectionState (\_ -> return count)
      _ -> return ()
```

---

## Component 3: Hydra Visual Integration

### `hydra-detection.js`

```javascript
// Hydra visual synthesis reacting to YOLO detections
// Run in https://hydra.ojack.xyz

// Receive OSC data via OSC.js or WebSocket bridge
// (Requires separate OSC-to-WebSocket server)

// Modulate based on person count
osc(10, 0.1, () => personCount / 10)
  .color(() => xPosition / 640, () => yPosition / 480, 0.5)
  .rotate(() => confidence / 100)
  .modulate(noise(3), 0.5)
  .out()

// React to FPS (visual scratch based on detection speed)
src(o0)
  .scrollX(() => fps / 100)
  .blend(o0, 0.9)
  .out(o1)

// Object-specific visuals
shape(() => objectCount + 3)
  .scale(() => confidence / 50)
  .kaleid(() => Math.floor(personCount))
  .out(o2)
```

---

## Workflow

### 1. Start SuperCollider & SuperDirt
```supercollider
s.boot;
SuperDirt.start;
```

### 2. Start TidalCycles (VS Code)
```
Cmd+Shift+Enter to boot Tidal
```

### 3. Run Detection Bridge
```bash
cd ~/projects/darknet
python3 ../toplap-nls/projects/visual-detection/detect_to_osc.py 0
# 0 = webcam, or use video file path
```

### 4. Load Reactive Patterns in Tidal
```haskell
-- In VS Code, open visual-reactive.tidal
-- Evaluate patterns with Shift+Enter
d1 $ sound "bd*<person_count>"
```

### 5. Open Hydra (Optional)
```
https://hydra.ojack.xyz
# Paste hydra-detection.js code
```

---

## Metrics Implementation

### AP50-Style: Visual-Audio Sync Accuracy

```python
# Calculate how well visuals match audio events
def calculate_sync_accuracy(beat_times, visual_events):
    """
    beat_times: List of audio beat timestamps
    visual_events: List of visual change timestamps
    
    Returns: Percentage of beats with matching visual (within 50ms)
    """
    matches = 0
    threshold = 0.05  # 50ms = 0.05s (like 50% IoU → 50ms sync)
    
    for beat in beat_times:
        for event in visual_events:
            if abs(beat - event) < threshold:
                matches += 1
                break
    
    return (matches / len(beat_times)) * 100
```

### FPS: Pattern Generation Rate

```haskell
-- Measure TidalCycles evaluation rate
import Data.Time.Clock

startTime <- getCurrentTime
evalCount <- newMVar 0

-- In pattern evaluation
do
  modifyMVar_ evalCount (+1)
  current <- getCurrentTime
  count <- readMVar evalCount
  let elapsed = diffUTCTime current startTime
  let fps = fromIntegral count / realToFrac elapsed
  putStrLn $ "Pattern FPS: " ++ show fps
```

---

## Example Session

### Scenario: Live Performance with Audience Detection

```bash
# Terminal 1: Start detection
python3 detect_to_osc.py 0

# Output:
# Detected person at (320, 240) - 92% confidence
# Detected person at (450, 180) - 87% confidence
# FPS: 28.5
```

```haskell
-- Terminal 2: TidalCycles patterns
-- More people = denser drums
d1 $ sound "bd*<person_count>" # gain 0.9

-- Audience position affects melody
d2 $ n (scale "minor" "<x_position>" / 50) 
   # sound "arpy" 
   # room (scale 0 0.5 "<person_count>" / 10)

-- High confidence detections trigger accents
d3 $ sound (if "<confidence>" > 90 then "cp" else "~")
   # orbit 1
```

Result: **Music that responds to audience presence and movement in real-time**

---

## Advanced: Custom Metrics

### Track Pattern Complexity Over Time

```python
# Log detection diversity as "pattern richness"
def calculate_pattern_diversity(detections):
    """
    Like AP50 but measures variety of objects detected
    High diversity = rich visual scene
    """
    unique_classes = len(set(d['class'] for d in detections))
    total_detections = len(detections)
    
    diversity_score = unique_classes / total_detections if total_detections > 0 else 0
    return diversity_score * 100
```

```haskell
-- In Tidal: Modulate based on scene diversity
d1 $ sound "bd*<diversity_score>" 
   # speed (scale 0.5 2 "<diversity_score>" / 100)
```

---

## Troubleshooting

### Darknet Won't Compile
```bash
# Check for missing dependencies
brew install opencv
# Edit Makefile: set OPENCV=1
```

### No OSC Messages in Tidal
```bash
# Test OSC sending
pip3 install python-osc
python3 -c "from pythonosc import udp_client; c = udp_client.SimpleUDPClient('127.0.0.1', 57120); c.send_message('/test', 123)"

# Check SuperCollider is listening
# In SuperCollider:
OSCFunc.trace(true);
```

### Low FPS
```bash
# Use smaller/faster model
./darknet detector demo cfg/coco.data cfg/yolov4-tiny.cfg yolov4-tiny.weights 0

# Or reduce resolution in cfg file
```

---

## Next Steps

1. **Move darknet-master** to projects directory
2. **Compile** and download weights
3. **Test detection** on webcam
4. **Create OSC bridge** (detect_to_osc.py)
5. **Integrate with Tidal** patterns
6. **Add Hydra visuals** (optional)
7. **Document your own metrics** for audio-visual sync

---

## Resources

- Darknet: https://github.com/AlexeyAB/darknet
- TidalCycles OSC: https://tidalcycles.org/docs/configuration/osc/
- Hydra: https://hydra.ojack.xyz
- YOLO Paper: https://arxiv.org/abs/2207.02696

---

**Created by:** Jimmy Howe (@jimmyhowe)  
**Project:** NLS Records Visual Detection Integration  
**Platform:** nlsrecordings.com
