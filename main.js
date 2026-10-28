function shellQuote(value) {
  return "'" + String(value).replace(/'/g, "'\\''") + "'";
}

function launcherPath() {
  const app = Application.currentApplication();
  app.includeStandardAdditions = true;
  return `${app.pathTo(this).toString()}/Contents/Resources/launch-core.sh`;
}

function run() {
  const app = Application.currentApplication();
  app.includeStandardAdditions = true;
  app.doShellScript(`bash ${shellQuote(launcherPath())}`);
}

function openDocuments(documents) {
  const app = Application.currentApplication();
  app.includeStandardAdditions = true;
  const launcher = launcherPath();
  documents.forEach(document => {
    app.doShellScript(`bash ${shellQuote(launcher)} ${shellQuote(document.toString())}`);
  });
}
