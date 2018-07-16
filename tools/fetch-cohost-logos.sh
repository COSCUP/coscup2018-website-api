#!/usr/bin/env bash
DIR=$(dirname $(dirname $0))
DIST=$DIR/dist
ASSETS=$DIST/assets
TOOLS=$DIR/tools
GDL=$TOOLS/gdrive-download.sh

function fetch-logo {
	local ORIGINAL_FILENAME="$1"
	local DRIVE_ID="$2"
	local EXTENSION="${ORIGINAL_FILENAME##*.}"
	local BASENAME="${ORIGINAL_FILENAME%.*}"
	local FILENAME="${ASSETS}/${BASENAME}-${DRIVE_ID}.${EXTENSION}"

	if [ ! -f "$FILENAME" ]; then
		$GDL "$DRIVE_ID" "$FILENAME"
	fi
}

mkdir -p "$ASSETS"

IMAGE_NAME_ID_PAIRS=$(cat - | jq -r '.cohosts[].image? | select(. != null) | .name, .driveId')

eval set -- $IMAGE_NAME_ID_PAIRS

while [ "$1" != "" ]; do
	fetch-logo "$1" "$2"
	shift; shift
done
