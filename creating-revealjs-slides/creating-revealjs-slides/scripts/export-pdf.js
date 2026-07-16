#!/usr/bin/env node

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

function formatTimestamp(date = new Date()) {
  const pad = value => String(value).padStart(2, '0');
  return [
    date.getFullYear(),
    pad(date.getMonth() + 1),
    pad(date.getDate()),
  ].join('') + '_' + [
    pad(date.getHours()),
    pad(date.getMinutes()),
    pad(date.getSeconds()),
  ].join('');
}

function findAvailablePdfPath(basePdfPath) {
  const parsed = path.parse(basePdfPath);
  let candidate = basePdfPath;
  let counter = 2;

  while (fs.existsSync(candidate)) {
    candidate = path.join(parsed.dir, `${parsed.name}-${counter}${parsed.ext}`);
    counter += 1;
  }

  return candidate;
}

function buildExportPlan(htmlPath, timestamp = formatTimestamp()) {
  const absoluteHtmlPath = path.resolve(htmlPath);
  const htmlDir = path.dirname(absoluteHtmlPath);
  const htmlBaseName = path.basename(absoluteHtmlPath, path.extname(absoluteHtmlPath));
  const basePdfPath = path.join(htmlDir, `${htmlBaseName}.pdf`);

  return {
    htmlPath: absoluteHtmlPath,
    htmlDir,
    htmlBaseName,
    pdfPath: findAvailablePdfPath(basePdfPath),
    screenshotsDir: path.join(htmlDir, 'screenshots', timestamp),
    revealInput: `${path.basename(absoluteHtmlPath)}?export`,
    spawnCwd: htmlDir,
  };
}

function printHelp() {
  console.log(`
export-pdf.js - Export a reveal.js HTML deck to PDF with screenshots

Usage:
  node export-pdf.js <presentation.html>

Behavior:
  - Creates screenshots under <html-dir>/screenshots/<timestamp>/
  - Writes PDF next to the HTML file using the same base name
  - If the PDF already exists, appends -2, -3, ... until free
`);
}

function buildDecktapeArgs(plan) {
  return [
    'decktape',
    'reveal',
    plan.revealInput,
    path.relative(plan.spawnCwd, plan.pdfPath),
    '--screenshots',
    '--screenshots-directory',
    path.relative(plan.spawnCwd, plan.screenshotsDir),
  ];
}

function runDecktape(plan) {
  fs.mkdirSync(plan.screenshotsDir, { recursive: true });
  const args = buildDecktapeArgs(plan);

  const result = spawnSync('npx', args, {
    cwd: plan.spawnCwd,
    stdio: 'inherit',
  });

  if (result.error) {
    throw result.error;
  }
  if (typeof result.status === 'number' && result.status !== 0) {
    process.exit(result.status);
  }
}

function main() {
  const htmlPath = process.argv[2];

  if (!htmlPath || htmlPath === '--help' || htmlPath === '-h') {
    printHelp();
    process.exit(htmlPath ? 0 : 1);
  }

  const plan = buildExportPlan(htmlPath);

  if (!fs.existsSync(plan.htmlPath)) {
    console.error(`Error: HTML file not found: ${plan.htmlPath}`);
    process.exit(1);
  }

  console.log(`HTML: ${plan.htmlPath}`);
  console.log(`PDF: ${plan.pdfPath}`);
  console.log(`Screenshots: ${plan.screenshotsDir}`);

  runDecktape(plan);
}

if (require.main === module) {
  main();
}

module.exports = {
  buildExportPlan,
  buildDecktapeArgs,
  findAvailablePdfPath,
  formatTimestamp,
};
