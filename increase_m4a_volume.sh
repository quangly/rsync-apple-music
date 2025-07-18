#!/bin/bash

for file in *.m4a; do
  echo "Increasing volume: $file"
  ffmpeg -i "$file" -af "volume=1.8" -c:a alac "normalized_$file"
  if [ $? -eq 0 ]; then
    mv "normalized_$file" "$file"
  else
    echo "Error processing $file"
    rm -f "normalized_$file"
  fi
done