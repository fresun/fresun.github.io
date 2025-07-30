#!/bin/bash

# Target max width (pixels)
MAX_WIDTH=1280

# Thumbnail size (optional)
THUMB_SIZE=160x120
THUMB_MAX_WIDTH=160

# Process all JPG/PNG images in both content/posts/ and assets/images/
find content/posts assets/images -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | while read img; do
  echo "Processing: $img"

  # Get original width
  width=$(identify -format "%w" "$img" 2>/dev/null)
  # echo "Original Width: $width"

  # Only resize if wider than MAX_WIDTH
  if [ "$width" -gt "$MAX_WIDTH" ]; then
    echo "Resizing to max width $MAX_WIDTH..."
    magick "$img" -resize "${MAX_WIDTH}x>" -strip "$img"
  else
    echo "Skipping: already <= ${MAX_WIDTH}px wide ($width px)"
  fi

  # Only create thumbnail if the file is named "cover.jpg/png/jpeg"
  filename=$(basename "$img" | tr '[:upper:]' '[:lower:]')  # normalize case
  if [[ "$filename" == "cover.jpg" || "$filename" == "cover.jpeg" || "$filename" == "cover.png" ]]; then
    dir=$(dirname "$img")

    # Check if thumb.png or thumb.jpg already exist
    if [ -f "$dir/thumb.jpg" ]; then
      thumb="$dir/thumb.jpg"
    elif [ -f "$dir/thumb.png" ]; then
      thumb="$dir/thumb.png"
    else
      thumb="$dir/thumb.jpg"  # generate a new one
    fi

    echo "thumb = $thumb"
    if [ ! -f "$thumb" ]; then
      echo "Creating new thumbnail: $thumb"
      magick "$img" -resize "$THUMB_SIZE^" -gravity center -extent "$THUMB_SIZE" -strip "$thumb"
    else
      width=$(identify -format "%w" "$thumb" 2>/dev/null)
      echo "thumbnail exists, width = $width"
      if [ "$width" -gt "$THUMB_MAX_WIDTH" ]; then
        echo "Resizing thumbnail to max width $THUMB_MAX_WIDTH..."
        magick "$img" -resize "$THUMB_SIZE^" -gravity center -extent "$THUMB_SIZE" -strip "$thumb"
      else
        echo "Skipping: already <= ${THUMB_MAX_WIDTH}px wide ($width px)"
      fi
      
    fi
  fi

done

