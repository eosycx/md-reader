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

python3 - "$FILEPATH" "$HTML_PATH" "$TEMP_HTML" << 'PYEOF'
import sys, json, os

fp, hp, tp = sys.argv[1], sys.argv[2], sys.argv[3]

with open(fp, "r", encoding="utf-8") as f:
    content = f.read()
filename = os.path.basename(fp)

with open(hp, "r", encoding="utf-8") as f:
    html = f.read()

inject = "\n// --- Injected: auto-load file ---\n"
inject += "(function(){\n"
inject += "  const _d = " + json.dumps({"n": filename, "c": content}) + ";\n"
inject += "  editor.value = _d.c;\n"
inject += "  currentFileName = _d.n;\n"
inject += "  document.title = _d.n + ' \\u2014 MD Reader';\n"
inject += "  fileHandle = null;\n"
inject += "  setModified(false);\n"
inject += "  render();\n"
inject += "  if (_d.c.includes('![')) tryAutoLoadImages().then(ok => { if (!ok) showImgAuthBar(); });\n"
inject += "  toast('\\u5df2\\u6253\\u5f00');\n"
inject += "})();\n"

html = html.replace("</script>\n</body>", inject + "</script>\n</body>")

with open(tp, "w", encoding="utf-8") as f:
    f.write(html)
PYEOF

if [ $? -ne 0 ]; then
    rm -f "$TEMP_HTML"
    open -a "Google Chrome" "$HTML_PATH" 2>/dev/null || open "$HTML_PATH"
    exit 0
fi

open -a "Google Chrome" "$TEMP_HTML" 2>/dev/null || open "$TEMP_HTML"
