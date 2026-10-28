#!/bin/bash
# MD Reader launcher — opens md-reader.html in Chrome.
# When called with a file argument (e.g. via macOS "Open With"),
# creates a temp copy with the file content pre-injected.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
HTML_PATH="$SCRIPT_DIR/md-reader.html"

if [ ! -f "$HTML_PATH" ]; then
    echo "Error: Cannot find md-reader.html in $SCRIPT_DIR" >&2
    exit 1
fi

if [ -z "$1" ]; then
    open -a "Google Chrome" "$HTML_PATH" 2>/dev/null || open "$HTML_PATH"
    exit 0
fi

FILEPATH="$(cd "$(dirname "$1")" 2>/dev/null && pwd)/$(basename "$1")"
if [ ! -f "$FILEPATH" ]; then
    open -a "Google Chrome" "$HTML_PATH" 2>/dev/null || open "$HTML_PATH"
    exit 0
fi

TEMP_HTML="/tmp/mdreader_${$}_$(date +%s).html"

osascript -l JavaScript "$SCRIPT_DIR/inject-file.js" "$FILEPATH" "$HTML_PATH" "$TEMP_HTML"

if [ $? -ne 0 ]; then
    rm -f "$TEMP_HTML"
    open -a "Google Chrome" "$HTML_PATH" 2>/dev/null || open "$HTML_PATH"
    exit 0
fi

open -a "Google Chrome" "$TEMP_HTML" 2>/dev/null || open "$TEMP_HTML"
