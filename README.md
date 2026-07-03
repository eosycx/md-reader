<p align="center">
  <img src="icon_handmade.svg" width="128" height="128" alt="MD Reader icon">
</p>

<h1 align="center">MD Reader</h1>

<p align="center">
  Markdown reader & editor. Single HTML file, zero dependencies.<br>
  <strong><a href="https://eosycx.github.io/md-reader/md-reader.html">Open in browser</a></strong>
</p>

## Features

- Drag & drop or `Cmd+O` to open `.md` / `.txt` files; `Cmd+S` saves back to the original file (Chrome)
- Side-by-side preview + source editor with draggable split ratio
- WYSIWYG editing in preview mode — `Cmd+B` bold, `Cmd+I` italic, and more
- `Cmd+Z` undo, `Cmd+Shift+Z` redo
- Light / dark theme, follows system preference
- Auto-continuing lists, Tab indent, scroll sync, word count

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Open file | `Cmd+O` |
| Save file | `Cmd+S` |
| Bold | `Cmd+B` |
| Italic | `Cmd+I` |
| Inline code | `Cmd+E` |
| Strikethrough | `Cmd+Shift+X` |
| Link | `Cmd+K` |
| Heading 1–3 | `Cmd+Opt+1/2/3` |
| Unordered list | `Cmd+Shift+8` |
| Ordered list | `Cmd+Shift+7` |
| Task list | `Cmd+Shift+9` |
| Quote | `Cmd+Shift+.` |
| Code block | `Cmd+Opt+C` |
| Split / Preview / Source | `Cmd+1/2/3` |

## Offline / Desktop

Download [`md-reader.html`](md-reader.html) and open in any browser. Works fully offline.

<details>
<summary>macOS Desktop App (with "Open With" support)</summary>

Build the app bundle and register it as a handler for `.md` files:

```bash
APP="$HOME/Applications/MD Reader.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources/Scripts"

# Copy resources
cp AppIcon.icns "$APP/Contents/Resources/"
cp Info.plist "$APP/Contents/"
cp md-reader.html "$APP/Contents/Resources/"
cp launch.sh "$APP/Contents/Resources/launch-core.sh"
chmod +x "$APP/Contents/Resources/launch-core.sh"

# Build AppleScript droplet (handles macOS "Open With" file events)
cat > /tmp/_mdreader.applescript << 'EOF'
property coreScript : ""
on run
    set coreScript to (POSIX path of (path to me)) & "Contents/Resources/launch-core.sh"
    do shell script "bash " & quoted form of coreScript
end run
on open theFiles
    set coreScript to (POSIX path of (path to me)) & "Contents/Resources/launch-core.sh"
    repeat with f in theFiles
        do shell script "bash " & quoted form of coreScript & " " & quoted form of POSIX path of f
    end repeat
end open
EOF
osacompile -o /tmp/_mdreader_droplet.app /tmp/_mdreader.applescript
cp /tmp/_mdreader_droplet.app/Contents/MacOS/droplet "$APP/Contents/MacOS/launch"
cp /tmp/_mdreader_droplet.app/Contents/Resources/Scripts/main.scpt "$APP/Contents/Resources/Scripts/"
cp /tmp/_mdreader_droplet.app/Contents/Resources/droplet.rsrc "$APP/Contents/Resources/launch.rsrc"
rm -rf /tmp/_mdreader_droplet.app /tmp/_mdreader.applescript
chmod +x "$APP/Contents/MacOS/launch"

# Register with macOS so it appears in "Open With" menus
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$APP"
```

After building, you can:
- Right-click any `.md` file → **Open With** → **MD Reader**
- Set it as the **default app** for `.md` files (Get Info → Open with → Change All)
- Open from terminal: `open -a "MD Reader" file.md`

</details>

## License

[MIT](LICENSE) — eosycx × Claude Code
