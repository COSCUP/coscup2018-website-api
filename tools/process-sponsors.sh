#!/usr/bin/env bash
DIR=$(dirname $(dirname $0))
DIST=$DIR/dist
TOOLS=$DIR/tools

FILENAME="$1"
TMP_FILE="${FILENAME}.tmp.${RANDOM}"

cat "$FILENAME" | jq '[ .sponsors[].image? | select(.) | {key: .name, value: .driveId} ] | from_entries' | $TOOLS/fetch-logos.sh
cat "$FILENAME" | jq -Mc '.sponsors[].image |= if . == null then null else (.name | match( "\\.[a-zA-Z0-9]*$" ) | .string) as $ext | "/assets/\(.name | rtrimstr($ext))-\(.driveId)\($ext)" end' > "$TMP_FILE"
mv "$TMP_FILE" "$FILENAME"
