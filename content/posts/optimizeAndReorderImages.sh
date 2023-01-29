#!/bin/bash
# remove all json files
for json in */images/*/*.json
do
  rm "$json"
done
for image in */images/*/*.{JPG,jpg}
do
  # Check if a bearbeitet exists
  image_dir=$(dirname "$image")
  # File without suffix
  #echo "Checking file $image"
  extension="${image##*.}"
  
  image_filename=$(basename "$image")
  bearbeitet_file="$image_dir/${image_filename%.*}-bearbeitet.$extension"
  if [ -f "$bearbeitet_file" ]; then
    # A bearbeitet file exists. This file should be preferred.
    rm "$image"
    continue 
  fi
  #if [[ "$image" != *-bearbeitet.* ]] 
  #then
    # Optimize only files that are not already optimized by google
    echo "Optimizing $image"
    mogrify -quality 70 -resize 1920x1080 "$image"    
  #fi
done
for album in */images/
do
  exiftool -fileOrder DateTimeOriginal -recurse -extension jpg -extension jpeg -extension JPG -ignoreMinorErrors '-FileName<DateTimeOriginal' -d %Y-%m-%d-%H-%M-%S.jpg "$album"  
  read -p 'Check if it worked'
done

