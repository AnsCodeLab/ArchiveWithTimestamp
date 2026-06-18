#!/bin/bash
# Archive a folder as a timestamped ZIP, placed next to the folder

folder="${1%/}"  # strip trailing slash if any
name="$(basename "$folder")"
parent="$(dirname "$folder")"
timestamp="$(date +%Y%m%d_%H%M)"
archive="$parent/${name}_${timestamp}.zip"

cd "$parent" && zip -r "$archive" "$name"
