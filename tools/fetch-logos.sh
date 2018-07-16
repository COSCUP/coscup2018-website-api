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

cat - | jq -r 'to_entries[] | [.key, .value] | @tsv' |
	while IFS=$'\t' read -r filename driveId; do
		fetch-logo $filename $driveId
	done
