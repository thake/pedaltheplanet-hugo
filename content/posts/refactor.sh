#!/bin/bash
for f in */index.md
do  
  echo "filename: $f"
  feature_image=$(grep -oP '^featured_image:\s+\K(.+)' "$f")
  image_name=$(basename "$feature_image")
  echo "$feature_image"
  echo "$image_name"
  cp "../pages/wordpress/$feature_image" "$image_name" 
  sed -i "s/^featured_image:\s*.*/featured_image: $image_name/" "$f"
done