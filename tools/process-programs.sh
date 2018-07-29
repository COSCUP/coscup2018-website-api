#!/usr/bin/env bash
DIR=$(dirname $(dirname $0))
DIST=$DIR/dist
TOOLS=$DIR/tools

FILENAME="$1"
TMP_FILE="${FILENAME}.tmp.${RANDOM}"

cat "$FILENAME" | jq '[ .communities[].image? | select(.>={}) | {key: .name, value: .driveId} ] | from_entries' | $TOOLS/fetch-logos.sh
cat "$FILENAME" | jq '[ .speakers[].avatar? | select(.>={}) | {key: .name, value: .driveId} ] | from_entries' | $TOOLS/fetch-logos.sh
cat "$FILENAME" | \
	jq -Mc '.communities[].image |= if .>={} then (.name | match( "\\.[a-zA-Z0-9]*$" ) | .string) as $ext | "/assets/\(.name | rtrimstr($ext))-\(.driveId)\($ext)" else null end' | \
	jq -Mc '.speakers[].avatar |= if .>={} then (.name | match( "\\.[a-zA-Z0-9]*$" ) | .string) as $ext | "/assets/\(.name | rtrimstr($ext))-\(.driveId)\($ext)" else null end' > "$TMP_FILE"
mv "$TMP_FILE" "$FILENAME"
