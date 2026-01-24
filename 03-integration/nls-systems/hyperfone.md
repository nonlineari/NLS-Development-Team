# Hyperfone Integration

## Overview

Hyperfone is a P2P (peer-to-peer) audio streaming system for 1-on-1 audio communication in NLS Artist Systems.

## Hyperfone Architecture

### P2P Connection
```
Device A ←→ Hyperbeam ←→ Device B
```

### Audio Streaming
- **Format**: PCM, Opus, or other codecs
- **Sample Rate**: 44.1kHz or 48kHz
- **Channels**: Mono or Stereo
- **Latency**: Low-latency streaming

## Implementation

### Connection Establishment
```c
void hyperfone_connect(const char *peer_id) {
    // Establish P2P connection via Hyperbeam
    hyperbeam_connection_t conn = {
        .peer_id = peer_id,
        .audio_port = 5000,
        .format = AUDIO_FORMAT_PCM_16BIT,
        .sample_rate = 48000,
        .channels = 2
    };
    
    hyperbeam_connect(&conn);
}
```

### Audio Streaming
```c
void hyperfone_stream_audio(audio_buffer_t *buffer) {
    // Send audio data to peer
    hyperfone_audio_packet_t packet = {
        .sequence = get_audio_sequence(),
        .timestamp = get_audio_timestamp(),
        .sample_rate = 48000,
        .channels = 2,
        .format = AUDIO_FORMAT_PCM_16BIT,
        .samples = buffer->sample_count
    };
    
    memcpy(packet.data, buffer->data, buffer->size);
    hyperbeam_send_audio(&packet);
}
```

## Related Documentation

- [Custom Protocols](../02-software/protocols/custom-protocols.md) - Hyperfone protocol
- [TidalCycles Integration](./tidalcycles.md) - Audio integration

---

**Last Updated**: 2025-02-02  
**Version**: 1.0.0
