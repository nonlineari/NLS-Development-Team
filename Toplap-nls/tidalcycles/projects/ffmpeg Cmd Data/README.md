# FFmpeg Metadata Embedding for MP4 Files

## Quick Reference

### Metadata Field Mapping

| Field    | FFmpeg Parameter   | Example Value              |
|----------|--------------------|----------------------------|
| Album    | `-metadata album`  | "Live Coding Session 2024" |
| Track    | `-metadata track`  | "1" or "1/10"              |
| Artist   | `-metadata artist` | "Your Name"                |
| Label    | `-metadata publisher` | "Record Label"          |
| Year     | `-metadata date`   | "2024"                     |
| Format   | `-metadata comment` | "MP4/H.264/AAC"           |
| Length   | (automatic)        | Preserved from source      |

## Basic Command

```bash
ffmpeg -i input.mp4 -c copy \
  -metadata album="Album Name" \
  -metadata track="1" \
  -metadata artist="Artist Name" \
  -metadata publisher="Label Name" \
  -metadata date="2024" \
  -metadata comment="Format: MP4/H.264" \
  output.mp4
```

The `-c copy` flag copies streams without re-encoding (fast and lossless).

## Using the Script

```bash
# Make script executable
chmod +x embed-metadata.sh

# Source the script to load the function
source embed-metadata.sh

# Use the function
ffmpeg_embed_metadata "input.mp4" "output.mp4" "Album Name" "1" "Artist Name" "Label" "2024"
```

## Verify Metadata

After embedding, check the metadata:

```bash
# View all format metadata
ffprobe -v quiet -print_format json -show_format output.mp4

# View specific fields
ffprobe -v error -show_entries format_tags=album,artist,date,publisher,track -of default=noprint_wrappers=1 output.mp4
```

## Additional Metadata Fields

```bash
-metadata title="Track Title"
-metadata album_artist="Album Artist"
-metadata composer="Composer Name"
-metadata genre="Electronic/Live Coding"
-metadata description="Description text"
-metadata copyright="© 2024 Your Name"
```

## Notes

- **Length/Duration**: Automatically preserved from the source file
- **Format**: Store format info in the `comment` field or use `encoder` field
- **Re-encoding**: Use `-c copy` to avoid re-encoding. Omit to re-encode with quality settings
- **Batch Processing**: Loop through multiple files using shell scripts
