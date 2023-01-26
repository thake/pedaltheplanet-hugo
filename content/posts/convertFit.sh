#!/bin/bash

for f in *.fit
do
  filename=$(basename "$f")
  targetname="${filename%.*}.geojson"
  gpsbabel -i garmin_fit -f "$f" -x simplify,crosstrack,error=0.005k -o kml,points=0 -o geojson,compact -F "$targetname"
done 