#!/usr/bin/env bash

LANGS=(
	zh_TW
	en
	jp
)

for lang in "${LANGS[@]}"; do
	mkdir -p "dist/$lang"

	# Fetch staffs
	curl -Lo "dist/$lang/staffs.json" "https://script.google.com/a/coscup.tw/macros/s/AKfycbxz2kOgLEPrk1fjvO6jWAFdOKkQquR4SpU2R2Zv6KgEvwXqk5Di/exec"

	# Fetch sponsors
	curl -Lo "dist/$lang/sponsors.json" "https://script.google.com/macros/s/AKfycbx49lzZ60QVcHXFmrqLFwOi4j09r3WnBQQCaFao_BGNOT8gukM/exec?lang=$lang"
done

