#!/bin/bash
set -euo pipefail

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
OUTPUT_DMG="${1:-$ROOT_DIR/release/MD Reader-1.4.5.dmg}"

if [ "$(uname -s)" != "Darwin" ]; then
    echo "The installer can only be built on macOS." >&2
    exit 1
fi

if ! command -v hdiutil >/dev/null 2>&1; then
    echo "Missing required command: hdiutil" >&2
    exit 1
fi

if [ -e "$OUTPUT_DMG" ]; then
    echo "Output already exists: $OUTPUT_DMG" >&2
    echo "Move or remove it, then run the build again." >&2
    exit 1
fi

TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/md-reader-dmg.XXXXXX")"
trap 'rm -rf "$TEMP_DIR"' EXIT

STAGING_DIR="$TEMP_DIR/MD Reader"
mkdir -p "$STAGING_DIR" "$(dirname "$OUTPUT_DMG")"
"$ROOT_DIR/build-macos.sh" "$STAGING_DIR/MD Reader.app"
ln -s /Applications "$STAGING_DIR/Applications"

hdiutil create \
    -volname "MD Reader 1.4.5" \
    -srcfolder "$STAGING_DIR" \
    -format UDZO \
    -imagekey zlib-level=9 \
    "$OUTPUT_DMG"

hdiutil verify "$OUTPUT_DMG"
echo "Built: $OUTPUT_DMG"
