#!/bin/bash
for post_index in */index.md
do
  echo "File: $post_index"
  post_dir=$(dirname "$post_index")
  echo "Post-Directory: $post_dir"
  tracks_dir="$post_dir/tracks"
  mkdir -p "$tracks_dir"
  # Removing previous track information
  yq --front-matter=process "del(.tracks)" "$post_index" > tmp_file
  mv tmp_file "$post_index"
  for track_data in $(yq --front-matter="extract" '.attachments.[0]' "$post_index" | jq -c '.tracks[] as $track | $track.id | tonumber as $id | $track.fields.endflag | startswith("true") as $endflag | $track.fields.vehicle as $vehicle | {$id, $endflag, $vehicle}')
  do    
    echo "Track Data: $track_data"    
    attachment_post_id=$(echo "$track_data" | jq '.id') 
    track_file=$(mysql -s -r -N -ppedaltheplanet -u pedaltheplanet -h 127.0.0.1 -P 3306 -e "select TRIM(LEADING 'http://www.pedaltheplanet.de/wordpress/' from guid) from wp_posts where ID = $attachment_post_id" pedaltheplanet 2> /dev/null)
    echo "  $attachment_post_id = $track_file"
    absolut_path="../pages/wordpress/$track_file"    
    cp "$absolut_path" "$tracks_dir"
    track_filename="$tracks_dir/$(basename "$track_file")"
    geojson_file="${track_filename%.*}.geojson"
    echo "Creating $geojson_file"
    # Now convert
    if [[ "$track_file" == *fit ]] 
    then
      gpsbabel -i garmin_fit,recoverymode -f "$track_filename" -x simplify,crosstrack,error=0.005k -o geojson,compact -F "$geojson_file"
    else
      gpsbabel -i gpx -f "$track_filename" -x simplify,crosstrack,error=0.005k -o geojson,compact -F "$geojson_file"
    fi
    # Now convert to geobuf
    geobuf_file="${track_filename%.*}.pbf"
    json2geobuf "$geojson_file" > "$geobuf_file"
    #rm "$track_filename"
    rm "$geojson_file"
    
    rel_geobuf_file="${geobuf_file#*/}"     
    # Now update relevant metadata
    track_data=$(echo "$track_data" | jq -c ".file=\"$rel_geobuf_file\" | del(.id)")
    echo "New meta data $track_data"
    yq --front-matter=process ".tracks += [$track_data]" "$post_index" > tmp_file
    mv tmp_file "$post_index"    
  done  
  read -p 'Check if it worked'
done