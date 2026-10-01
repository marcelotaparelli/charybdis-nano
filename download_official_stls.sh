#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$ROOT"/{01_cases,02_bottom_plates,03_trackball,04_tenting}

download() {
  local url="$1" out="$2"
  echo "-> $(basename "$out")"
  curl -fL --retry 3 --retry-delay 1 "$url" -o "$out"
}

# RIGHT — Charybdis Nano 3x5
download 'https://raw.githubusercontent.com/Bastardkb/Charybdis/main/files/3x5%20nano/charybdisnano_v2_v187.stl' \
  "$ROOT/01_cases/RIGHT_charybdisnano_v2_v187.stl"
download 'https://raw.githubusercontent.com/Bastardkb/Charybdis/main/files/3x5%20nano/plates/alien_v2_185.stl' \
  "$ROOT/02_bottom_plates/RIGHT_alien_v2_185.stl"
download 'https://raw.githubusercontent.com/Bastardkb/Charybdis/main/files/3x5%20nano/adapter_v2_top_v75.stl' \
  "$ROOT/03_trackball/adapter_v2_top_v75.stl"
download 'https://raw.githubusercontent.com/Bastardkb/Charybdis/main/files/adapter_v4_bottom_v17.stl' \
  "$ROOT/03_trackball/adapter_v4_bottom_v17.stl"
download 'https://raw.githubusercontent.com/Bastardkb/Charybdis/main/files/sensor_cover_v51.stl' \
  "$ROOT/03_trackball/sensor_cover_v51.stl"
download 'https://raw.githubusercontent.com/Bastardkb/Charybdis/main/files/3x5%20nano/tent/alien/tent15deg_v2_27.stl' \
  "$ROOT/04_tenting/RIGHT_tent15deg_v2_27.stl"

# LEFT source — Skeletyl V4 (unmirrored upstream reference)
download 'https://raw.githubusercontent.com/Bastardkb/Skeletyl/main/V4/case_v4_103.stl' \
  "$ROOT/01_cases/LEFT_SOURCE_case_v4_103_MIRROR_IN_SLICER.stl"
download 'https://raw.githubusercontent.com/Bastardkb/Skeletyl/main/V4/plates/plate_v4_103.stl' \
  "$ROOT/02_bottom_plates/LEFT_SOURCE_plate_v4_103_MIRROR_IN_SLICER.stl"
cp "$ROOT/04_tenting/RIGHT_tent15deg_v2_27.stl" \
  "$ROOT/04_tenting/LEFT_SOURCE_tent15deg_v2_27_MIRROR_IN_SLICER.stl"

echo
echo 'OK. Fontes upstream atualizadas. Os arquivos LEFT_SOURCE_* são referências não espelhadas.'
echo 'Se as fontes mudaram, regenere os LEFT com node scripts/mirror_left_stls.js --write.'
