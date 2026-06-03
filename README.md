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
<summary>macOS Desktop App</summary>

```bash
APP="$HOME/Desktop/MD Reader.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp AppIcon.icns "$APP/Contents/Resources/"
cp Info.plist "$APP/Contents/"
cp launch.sh "$APP/Contents/MacOS/launch"
chmod +x "$APP/Contents/MacOS/launch"
```
</details>

## License

[MIT](LICENSE) — eosycx × Claude Code
