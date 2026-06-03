<p align="center">
  <img src="icon_handmade.svg" width="128" height="128" alt="MD Reader icon">
</p>

# MD Reader

Local Markdown reader & editor. Single HTML file, zero dependencies.

**[Try it online](https://eosycx.github.io/md-reader/md-reader.html)** | 本地 Markdown 阅读器/编辑器，单 HTML 文件，零依赖。

## Features

- Drag & drop or `Cmd+O` to open `.md` / `.txt` files; `Cmd+S` saves back to the original file (Chrome)
- Side-by-side preview + source editor with draggable split ratio
- WYSIWYG editing in preview mode — `Cmd+B` bold, `Cmd+I` italic, and more
- `Cmd+Z` undo, `Cmd+Shift+Z` redo
- Light / dark theme, follows system preference
- Auto-continuing lists, Tab indent, scroll sync, word count

## Usage

Download `md-reader.html` and open it in any modern browser. That's it.

### macOS Desktop App

To create a standalone `.app` wrapper:

```bash
APP="$HOME/Desktop/MD Reader.app"
mkdir -p "$APP/Contents/MacOS" "$APP/Contents/Resources"
cp AppIcon.icns "$APP/Contents/Resources/"
cp Info.plist "$APP/Contents/"
cp launch.sh "$APP/Contents/MacOS/launch"
chmod +x "$APP/Contents/MacOS/launch"
```

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

## Changelog

- **v1.4.3** / 2026-06-02
  - Fix: toolbar icons inconsistent sizing (folder icon too small, strikethrough too short)
  - Fix: toolbar buttons compressed on narrow viewports
- **v1.4** / 2026-05-28
  - Fix: ordered lists broken by blank lines restart numbering from 1
  - Fix: editor highlight not syncing with preview highlight
  - Fix: toolbar buttons crash when no file is open
  - New: block-level highlight sync (full block, not just first line)
  - New: WYSIWYG editing in preview mode (default editable, lock button to toggle)
  - New: source-only mode with centered layout
- **v1.3** / 2025-05-13

## License

[MIT](LICENSE) — eosycx × Claude Code
