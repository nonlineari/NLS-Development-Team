#!/bin/bash

# FFmpeg Metadata Embedding Script
# Embeds Album, Track, Artist, Label, Year, Format, and Length metadata into MP4 files

# Usage examples:

# Example 1: Basic metadata embedding
# ffmpeg -i input.mp4 -c copy \
#   -metadata album="Live Coding Session 2024" \
#   -metadata track="1" \
#   -metadata artist="Your Name" \
#   -metadata publisher="Label Name" \
#   -metadata date="2024" \
#   -metadata comment="Format: MP4/H.264" \
#   output.mp4

# Example 2: With specific metadata fields
ffmpeg_embed_metadata() {
    local input="$1"
    local output="$2"
    local album="$3"
    local track="$4"
    local artist="$5"
    local label="$6"
    local year="$7"
    
    ffmpeg -i "$input" -c copy \
        -metadata album="$album" \
        -metadata track="$track" \
        -metadata artist="$artist" \
        -metadata publisher="$label" \
        -metadata date="$year" \
        -metadata encoder="FFmpeg" \
        "$output"
}

# Example usage of the function:
# ffmpeg_embed_metadata "input.mp4" "output.mp4" "My Album" "1" "Artist Name" "Record Label" "2024"

# Example 3: Embed metadata and re-encode (if needed)
# ffmpeg -i input.mp4 \
#   -c:v libx264 -crf 23 -preset medium \
#   -c:a aac -b:a 192k \
#   -metadata album="Live Coding Session 2024" \
#   -metadata track="1" \
#   -metadata artist="Your Name" \
#   -metadata publisher="Label Name" \
#   -metadata date="2024" \
#   -metadata comment="Format: MP4/H.264/AAC" \
#   output.mp4

# Note: Length/duration is automatically preserved from the source file
# To view metadata after embedding, use:
# ffprobe -v quiet -print_format json -show_format output.mp4

echo "FFmpeg metadata embedding script loaded"
echo "Usage: ffmpeg_embed_metadata <input.mp4> <output.mp4> <album> <track> <artist> <label> <year>"
