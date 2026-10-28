#!/bin/bash
set -euo pipefail

ROOT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
OUTPUT_APP="${1:-$ROOT_DIR/dist/MD Reader.app}"

if [ "$(uname -s)" != "Darwin" ]; then
    echo "The macOS app can only be built on macOS." >&2
    exit 1
fi

for command_name in osacompile plutil codesign; do
    if ! command -v "$command_name" >/dev/null 2>&1; then
        echo "Missing required command: $command_name" >&2
        exit 1
    fi
done

if [ -e "$OUTPUT_APP" ]; then
    echo "Output already exists: $OUTPUT_APP" >&2
    echo "Move or remove it, then run the build again." >&2
    exit 1
fi

TEMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/md-reader-build.XXXXXX")"
trap 'rm -rf "$TEMP_DIR"' EXIT

osacompile -l JavaScript -o "$TEMP_DIR/droplet.app" "$ROOT_DIR/main.js"

mkdir -p "$OUTPUT_APP/Contents/MacOS" "$OUTPUT_APP/Contents/Resources/Scripts"
cp "$ROOT_DIR/Info.plist" "$OUTPUT_APP/Contents/Info.plist"
cp "$ROOT_DIR/AppIcon.icns" "$OUTPUT_APP/Contents/Resources/AppIcon.icns"
cp "$ROOT_DIR/md-reader.html" "$OUTPUT_APP/Contents/Resources/md-reader.html"
cp "$ROOT_DIR/launch.sh" "$OUTPUT_APP/Contents/Resources/launch-core.sh"
cp "$ROOT_DIR/inject-file.js" "$OUTPUT_APP/Contents/Resources/inject-file.js"
cp "$TEMP_DIR/droplet.app/Contents/MacOS/droplet" "$OUTPUT_APP/Contents/MacOS/launch"
cp "$TEMP_DIR/droplet.app/Contents/Resources/Scripts/main.scpt" "$OUTPUT_APP/Contents/Resources/Scripts/main.scpt"
cp "$TEMP_DIR/droplet.app/Contents/Resources/droplet.rsrc" "$OUTPUT_APP/Contents/Resources/launch.rsrc"
chmod +x "$OUTPUT_APP/Contents/MacOS/launch" "$OUTPUT_APP/Contents/Resources/launch-core.sh"

plutil -lint "$OUTPUT_APP/Contents/Info.plist" >/dev/null
codesign --force --deep --sign - "$OUTPUT_APP" >/dev/null
codesign --verify --deep --strict "$OUTPUT_APP"

echo "Built: $OUTPUT_APP"
