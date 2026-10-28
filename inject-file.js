ObjC.import('Foundation');

function readUtf8(path) {
  const data = $.NSData.dataWithContentsOfFile(path);
  if (!data) throw new Error(`Cannot read ${path}`);
  const text = $.NSString.alloc.initWithDataEncoding(data, $.NSUTF8StringEncoding);
  if (!text) throw new Error(`Cannot decode ${path}`);
  return ObjC.unwrap(text);
}

function writeUtf8(path, text) {
  const ok = $(text).writeToFileAtomicallyEncodingError(path, true, $.NSUTF8StringEncoding, null);
  if (!ok) throw new Error(`Cannot write ${path}`);
}

function run(argv) {
  if (argv.length !== 3) throw new Error('Expected input Markdown, source HTML, and output HTML paths');
  const filePath = argv[0];
  const htmlPath = argv[1];
  const outputPath = argv[2];
  const content = readUtf8(filePath);
  const filename = ObjC.unwrap($(filePath).lastPathComponent);
  const html = readUtf8(htmlPath);
  const inject = [
    '',
    '// --- Injected: auto-load file ---',
    '(function(){',
    `  const _d = ${JSON.stringify({n: filename, c: content})};`,
    '  editor.value = _d.c;',
    '  currentFileName = _d.n;',
    "  document.title = _d.n + ' \\u2014 MD Reader';",
    '  fileHandle = null;',
    '  setModified(false);',
    '  render();',
    "  if (_d.c.includes('![')) tryAutoLoadImages().then(ok => { if (!ok) showImgAuthBar(); });",
    "  toast('\\u5df2\\u6253\\u5f00');",
    '})();',
    ''
  ].join('\n');
  const marker = '</script>\n</body>';
  if (!html.includes(marker)) throw new Error('Cannot find HTML injection point');
  writeUtf8(outputPath, html.replace(marker, inject + marker));
}
