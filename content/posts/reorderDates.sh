#!/bin/bash

exiftool -fileOrder DateTimeOriginal -recurse -extension jpg -extension jpeg -extension JPG -ignoreMinorErrors '-FileName<DateTimeOriginal' -d %Y-%m-%d-%H-%M-%S.jpg $1
