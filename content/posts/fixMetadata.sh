#!/bin/bash
for post_index in */index.md
do
  url=$(yq --front-matter="extract" '.url' "$post_index")
  if [ "$url" != "null" ]; 
  then
    slug_with_trailing_slash=${url#/*/}
    slug=${slug_with_trailing_slash%/}    
    echo "Url: $url. Slug: $slug"
    yq --front-matter=process ".slug = \"$slug\" | del(.url) | .alias += [\"$url\"]" "$post_index" > tmp_file
    mv tmp_file "$post_index" 
    read -p 'Check if it worked'
  fi
done