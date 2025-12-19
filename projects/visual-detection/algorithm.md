# The Plan
## Algorithm for Visual Music Detection System

---

## Philosophy

This document describes the algorithmic plan for integrating object detection with live coded visual music. The algorithm operates on three levels:

1. **Detection** (Surface) - What exists in this frame
2. **Association** (Scratching) - How patterns connect across time  
3. **Synthesis** (Harmony) - How detection becomes sound/visual

Like your monologue described:
> "So the world is being scratched as a piece of music, so enhanced music, as harmonic systems of design."

---

## Algorithm Overview

```
INPUT: Camera feed (video stream)
       TidalCycles patterns (audio)
       Hydra visuals (graphics)

PROCESS: 
  1. Detect objects (Darknet/YOLO)
  2. Extract features (position, class, confidence)
  3. Transform to OSC messages
  4. Modulate audio/visual patterns

OUTPUT: Reactive audio-visual performance
```

---

## Phase 1: Setup (The Foundation)

### Objective
Establish the modular architecture for detection → synthesis pipeline

### Steps

#### 1.1 Move Darknet to Projects
```bash
# Algorithm: Relocate system to modular location
mv ~/Downloads/darknet-master ~/projects/darknet

# Verify integrity
cd ~/projects/darknet
ls src/*.c | wc -l  # Should output: 107 (source files present)
```

**Why:** Creates centralized project structure, integrates with toplap-nls

#### 1.2 Compile Detection Engine
```bash
cd ~/projects/darknet

# Algorithm: Build binary from source
make

# Expected output: darknet executable
test -f ./darknet && echo "✓ Compiled" || echo "✗ Failed"
```

**Dependencies Check:**
```bash
# If compilation fails, install dependencies
brew install opencv
brew install pkg-config

# Edit Makefile if GPU available (optional)
# Set: GPU=1, CUDNN=1, OPENCV=1
```

#### 1.3 Download Neural Network Weights
```bash
cd ~/projects/darknet

# Algorithm: Fetch pre-trained model
# Option A: Standard model (better accuracy)
wget https://pjreddie.com/media/files/yolov3.weights

# Option B: Tiny model (better speed)
wget https://pjreddie.com/media/files/yolov3-tiny.weights

# Verify download
ls -lh *.weights
# Should show: ~240MB for yolov3, ~35MB for tiny
```

**Why:** Neural network needs trained parameters to detect objects

---

## Phase 2: Test Detection (Verify the Node)

### Objective
Confirm detection works before integration

### Algorithm: Single Image Test
```bash
cd ~/projects/darknet

# Create test directory
mkdir -p test-images

# Test on image (if you have one)
./darknet detect cfg/yolov3.cfg yolov3.weights test-images/test.jpg

# Expected output:
# person: 92%
# car: 85%
# (saves predictions.jpg with bounding boxes)
```

### Algorithm: Webcam Real-time Test
```bash
# Test live detection
./darknet detector demo cfg/coco.data cfg/yolov3.cfg yolov3.weights 0

# 0 = webcam device ID
# Should open window showing detections
# Press Ctrl+C to stop
```

**Success Criteria:**
- ✓ Window opens with video feed
- ✓ Objects are detected with bounding boxes
- ✓ FPS displayed (should be 10-30 FPS)
- ✓ Console shows: "person: 92%", "car: 85%", etc.

---

## Phase 3: Build OSC Bridge (The Connector)

### Objective
Translate detection data into OSC messages for TidalCycles

### Algorithm: Create Python Bridge

#### 3.1 Install Python Dependencies
```bash
pip3 install python-osc
```

#### 3.2 Create Bridge Script
```bash
cd ~/projects/toplap-nls/projects/visual-detection

# Create the script (see detect_to_osc.py in README.md)
touch detect_to_osc.py
chmod +x detect_to_osc.py
```

**Algorithm Flow:**
```python
# Pseudocode of the bridge
while video_running:
    line = read_darknet_output()
    
    if line contains "person: X%":
        parse: class, confidence, x, y
        send_osc("/detection/object", [class, confidence, x, y])
        send_osc("/detection/count/person", person_count)
    
    if line contains "FPS:":
        parse: fps_value
        send_osc("/detection/fps", fps_value)
```

#### 3.3 Test OSC Sending
```bash
# Terminal 1: Test OSC receiver (SuperCollider)
# In SuperCollider:
OSCFunc.trace(true);

# Terminal 2: Test OSC sending
python3 -c "
from pythonosc import udp_client
c = udp_client.SimpleUDPClient('127.0.0.1', 57120)
c.send_message('/test', 123)
print('Sent test message')
"

# SuperCollider should print:
# OSC Message Received:
#   /test, 123
```

---

## Phase 4: Integration (The Synthesis)

### Objective
Connect detection to TidalCycles patterns

### Algorithm: SuperCollider Setup

#### 4.1 Boot SuperCollider
```supercollider
// In SuperCollider IDE
s.boot;
SuperDirt.start;

// Verify listening on port 57120
NetAddr.langPort;  // Should output: 57120
```

#### 4.2 Create OSC Listeners (Optional)
```supercollider
// Listen for detection messages
OSCdef(\detectionCount, {|msg, time, addr, recvPort|
    var count = msg[1];
    "Person count: %".format(count).postln;
}, '/detection/count/person');

OSCdef(\detectionFPS, {|msg|
    var fps = msg[1];
    "Detection FPS: %".format(fps).postln;
}, '/detection/fps');
```

### Algorithm: TidalCycles Patterns

#### 4.3 Basic Pattern (Person Count → Drum Density)
```haskell
-- In .tidal file
-- Note: OSC variables would need proper setup in BootTidal.hs
-- For now, this is conceptual structure

-- Simple: More people = more drums
d1 $ sound "bd*4 sd*2"  -- Start with baseline

-- Advanced: React to detection (requires OSC state setup)
-- This is the target pattern structure
d1 $ sound "bd*<person_count>" # gain 0.9
```

---

## Phase 5: Test Integration (Verify the Circuit)

### Algorithm: Full System Test

#### 5.1 Start All Components (Multi-terminal)
```bash
# Terminal 1: SuperCollider (already running from Phase 4)

# Terminal 2: TidalCycles
code ~/projects/toplap-nls/projects/visual-detection/visual-reactive.tidal
# Boot Tidal: Cmd+Shift+Enter

# Terminal 3: Detection Bridge
cd ~/projects/darknet
python3 ../toplap-nls/projects/visual-detection/detect_to_osc.py 0
```

#### 5.2 Verification Checklist
```
□ SuperCollider shows "SuperDirt started"
□ TidalCycles shows "Tidal started"
□ Python bridge shows "Starting detection on source: 0"
□ Python bridge shows "Sending OSC to 127.0.0.1:57120"
□ Detections appear: "Detected person at (320, 240) - 92% confidence"
□ (Later) Audio responds to detections
```

---

## Phase 6: Performance Patterns (The Music)

### Algorithm: Pattern Design

#### 6.1 Density Mapping
```haskell
-- Map object count to pattern density
-- Algorithm: count → repetitions

d1 $ sound "bd*<person_count>"
-- 1 person  → "bd"
-- 3 people  → "bd bd bd"
-- 10 people → "bd" repeated 10x
```

#### 6.2 Position Mapping
```haskell
-- Map X position to stereo pan
-- Algorithm: x_pixel → pan_value (-1 to 1)

d2 $ sound "arpy" 
   # pan (scale (-1) 1 "<x_position>" / 640)
-- Left screen   (x=0)   → pan -1 (left speaker)
-- Center screen (x=320) → pan 0  (center)
-- Right screen  (x=640) → pan 1  (right speaker)
```

#### 6.3 Confidence Mapping
```haskell
-- Map detection confidence to gain
-- Algorithm: confidence% → volume

d3 $ sound "bass" 
   # gain (scale 0 1 "<confidence>" / 100)
-- Low confidence  (50%) → quiet (gain 0.5)
-- High confidence (95%) → loud  (gain 0.95)
```

#### 6.4 FPS as Tempo
```haskell
-- Map detection FPS to Tidal cycles per second
-- Algorithm: fps → cps

setcps ("<fps>" / 60 / 4)
-- 30 FPS → 0.125 cps (one cycle per 8 seconds)
-- 60 FPS → 0.25 cps  (one cycle per 4 seconds)
```

---

## Phase 7: Metrics (Measure the Performance)

### Algorithm: Custom AP50-Style Metric for A/V Sync

#### 7.1 Sync Accuracy Measurement
```python
def calculate_av_sync_accuracy(beat_times, visual_events, threshold=0.05):
    """
    Algorithm: Measure temporal alignment
    
    For each beat:
        Find nearest visual event
        If within threshold (50ms):
            Count as match
    
    Return: match_percentage
    """
    matches = 0
    
    for beat in beat_times:
        for event in visual_events:
            delta = abs(beat - event)
            if delta < threshold:
                matches += 1
                break  # Only count first match
    
    accuracy = (matches / len(beat_times)) * 100
    return accuracy

# Example usage:
beat_times = [0.0, 0.5, 1.0, 1.5, 2.0]  # Audio beats at these timestamps
visual_events = [0.02, 0.48, 1.03, 1.51, 1.98]  # Visual changes

sync_score = calculate_av_sync_accuracy(beat_times, visual_events)
print(f"A/V Sync Accuracy: {sync_score}%")
# Output: A/V Sync Accuracy: 100.0%
```

#### 7.2 Pattern Diversity Metric
```python
def calculate_pattern_diversity(detections):
    """
    Algorithm: Measure variety of detected objects
    
    diversity = unique_classes / total_detections
    
    High diversity → rich visual scene
    Low diversity  → monotonous scene
    """
    if not detections:
        return 0
    
    unique_classes = len(set(d['class'] for d in detections))
    total = len(detections)
    
    diversity = (unique_classes / total) * 100
    return diversity

# Example:
detections = [
    {'class': 'person', 'conf': 0.92},
    {'class': 'person', 'conf': 0.88},
    {'class': 'car', 'conf': 0.85},
    {'class': 'bottle', 'conf': 0.78}
]

diversity = calculate_pattern_diversity(detections)
print(f"Scene Diversity: {diversity}%")
# Output: Scene Diversity: 75.0% (3 unique / 4 total)
```

---

## Phase 8: Optimization (Tune the Algorithm)

### Algorithm: Performance Tuning

#### 8.1 If FPS Too Low (< 10 FPS)
```bash
# Option 1: Use tiny model
./darknet detector demo cfg/coco.data cfg/yolov3-tiny.cfg yolov3-tiny.weights 0

# Option 2: Reduce input resolution
# Edit cfg file: change width/height to 320x320 (from 416x416)

# Option 3: Skip frames
# In detect_to_osc.py: process every Nth frame only
frame_count = 0
if frame_count % 2 == 0:  # Process every other frame
    process_detection()
frame_count += 1
```

#### 8.2 If Too Many False Detections
```python
# Increase confidence threshold
# In detect_to_osc.py:

if confidence > 70:  # Only send if > 70% confident
    send_osc(...)
```

#### 8.3 If Audio Too Reactive (Jittery)
```haskell
-- Add smoothing in Tidal patterns
-- Use 'slow' to average over time

d1 $ slow 2 $ sound "bd*<person_count>"
-- Updates every 2 cycles instead of every cycle
```

---

## Algorithm Summary: The Full Loop

```
┌─────────────────────────────────────────────────────┐
│ PHASE 1-2: SETUP & TEST                             │
│   1. Move darknet → ~/projects/darknet              │
│   2. Compile: make                                   │
│   3. Download: yolov3.weights                        │
│   4. Test: ./darknet detector demo ... 0            │
└───────────────┬─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────────────────────┐
│ PHASE 3: BUILD BRIDGE                                │
│   5. Install: pip3 install python-osc               │
│   6. Create: detect_to_osc.py                        │
│   7. Test: python3 test_osc.py                       │
└───────────────┬─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────────────────────┐
│ PHASE 4-5: INTEGRATE & TEST                         │
│   8. Boot SuperCollider + SuperDirt                  │
│   9. Boot TidalCycles                                │
│   10. Run detection bridge                           │
│   11. Verify: Detections → OSC → Sound              │
└───────────────┬─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────────────────────┐
│ PHASE 6: PERFORM                                     │
│   12. Load reactive patterns                         │
│   13. Map detections to sound parameters             │
│   14. Live code with detection as input              │
└───────────────┬─────────────────────────────────────┘
                ↓
┌─────────────────────────────────────────────────────┐
│ PHASE 7-8: MEASURE & OPTIMIZE                       │
│   15. Calculate A/V sync metrics                     │
│   16. Measure pattern diversity                      │
│   17. Tune FPS, confidence, smoothing                │
└─────────────────────────────────────────────────────┘
```

---

## Modular Architecture (From Your Philosophy)

### The Cell Phone as Node
**Darknet** = The detection node
- Centralized processing in one system
- Self-contained module (can be moved, replaced)
- Communicates via OSC (network protocol)

### Scratching Across Surfaces
**Detection → OSC → Sound** = The scratch
- Each frame is a "surface"
- OSC bridge "scratches" detection data onto audio patterns
- Creates harmonic flow across time

### Connectivity & Society
**Integration** = The network
- SuperCollider + Tidal + Darknet = Distributed system
- Each component maintains state (like your "solid state society")
- Messages flow through network (OSC = the connectivity)

---

## Success Criteria

### Minimum Viable Performance (MVP)
- [ ] Darknet compiles and runs
- [ ] Detects objects in webcam feed
- [ ] Python bridge sends OSC messages
- [ ] TidalCycles receives messages (visible in logs)
- [ ] One pattern reacts to person count

### Full Performance
- [ ] Multiple patterns react to different detection types
- [ ] Position/confidence mapped to sound parameters
- [ ] FPS mapped to tempo
- [ ] Hydra visuals respond to detections (optional)
- [ ] A/V sync accuracy > 80%
- [ ] Maintains 20+ FPS detection rate

---

## Next Steps (Immediate Actions)

### Step 1: Execute Phase 1 (Today)
```bash
# Run these commands now:
mv ~/Downloads/darknet-master ~/projects/darknet
cd ~/projects/darknet
make
wget https://pjreddie.com/media/files/yolov3-tiny.weights
```

### Step 2: Verify Phase 2 (Today)
```bash
# Test detection:
./darknet detector demo cfg/coco.data cfg/yolov3-tiny.cfg yolov3-tiny.weights 0
```

### Step 3: Create Bridge (Next Session)
```bash
cd ~/projects/toplap-nls/projects/visual-detection
# Create detect_to_osc.py from README.md
```

---

## Future Enhancements (ByteTrack Integration)

### Phase 9: Add Tracking (Optional)
Once basic detection works, add ByteTrack:

```bash
# Install ByteTrack
cd ~/projects
git clone https://github.com/ifzhang/ByteTrack.git
cd ByteTrack
pip3 install -r requirements.txt
```

**Algorithm: Detection → Tracking → Synthesis**
```
Darknet detects objects (what exists)
    ↓
ByteTrack assigns IDs (who is who)
    ↓
OSC sends: [person_ID_1, person_ID_2, ...]
    ↓
Tidal: Each person gets own channel
```

---

## References

### Papers
- **YOLO:** "YOLOv7: Trainable bag-of-freebies" (2022)
- **ByteTrack:** "Multi-Object Tracking by Associating Every Detection Box" (2021)
- **COCO:** "Microsoft COCO: Common Objects in Context" (2014)

### Your Philosophy
- **Modular-of-end-user.md:** Cell phone as modular node
- **Satoshi Dreams Nakamoto.md:** Solid state society, Ghost in the Shell
- **Contact.md (THE FORMAT™):** Revenue streams, metrics

### Tools
- **Darknet:** https://github.com/AlexeyAB/darknet
- **TidalCycles:** https://tidalcycles.org
- **SuperCollider:** https://supercollider.github.io
- **Hydra:** https://hydra.ojack.xyz

---

**The Plan by:** Jimmy Howe (@jimmyhowe)  
**NLS Records**  
**Platform:** nlsrecordings.com  

**Status:** Ready to Execute Phase 1  
**Next Action:** Run setup commands above

---

*"So the world is being scratched as a piece of music, so enhanced music, as harmonic systems of design."*
