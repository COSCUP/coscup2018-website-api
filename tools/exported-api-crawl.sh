#!/usr/bin/env bash
DIR=$(dirname $(dirname $0))
DIST=$DIR/dist
TOOLS=$DIR/tools

LANGS=(
	zh_TW
	en
	jp
)

for lang in "${LANGS[@]}"; do
	PLACE="${DIST}/${lang}"
	mkdir -p "$PLACE"

	# Fetch staffs
	curl -Lo "${PLACE}/staffs.json" "https://script.google.com/a/coscup.tw/macros/s/AKfycbxz2kOgLEPrk1fjvO6jWAFdOKkQquR4SpU2R2Zv6KgEvwXqk5Di/exec?lang=$lang"

	# Fetch sponsors
	curl -Lo "${PLACE}/sponsors.json" "https://script.google.com/macros/s/AKfycbx49lzZ60QVcHXFmrqLFwOi4j09r3WnBQQCaFao_BGNOT8gukM/exec?lang=$lang"
	$TOOLS/process-sponsors.sh "${PLACE}/sponsors.json"
done

