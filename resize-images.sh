#!/bin/bash

# Target max width (pixels)
MAX_WIDTH=1280

# Thumbnail size (optional)
# THUMB_SIZE=300x200

# Process all JPG/PNG images in both content/posts/ and assets/images/
find content/posts assets/images -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read img; do
  echo "Processing: $img"

  # Get original width
  width=$(identify -format "%w" "$img" 2>/dev/null)
  echo "Original Width: $width"

  # Only resize if wider than MAX_WIDTH
  if [ "$width" -gt "$MAX_WIDTH" ]; then
    echo "Resizing to max width $MAX_WIDTH..."
    magick "$img" -resize "${MAX_WIDTH}x>" -strip "$img"
  else
    echo "Skipping: already <= ${MAX_WIDTH}px wide ($width px)"
  fi

  # Optional: Generate thumbnail next to original
  # dir=$(dirname "$img")
  # base=$(basename "$img")
  # name="${base%.*}"
  # ext="${base##*.}"
  # thumb="$dir/${name}-thumb.$ext"

  # if [ ! -f "$thumb" ]; then
  #   echo "Creating thumbnail $thumb..."
  #   magick "$img" -resize "$THUMB_SIZE^" -gravity center -extent "$THUMB_SIZE" -strip "$thumb"
  # fi

done

