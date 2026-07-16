const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const {
  buildExportPlan,
  findAvailablePdfPath,
  buildDecktapeArgs,
} = require('./export-pdf');

test('buildExportPlan places pdf and screenshots next to the source html', () => {
  const htmlPath = '/tmp/slides/quarterly-review.html';
  const timestamp = '20260330_120000';

  const plan = buildExportPlan(htmlPath, timestamp);

  assert.equal(plan.htmlPath, path.resolve(htmlPath));
  assert.equal(plan.pdfPath, path.resolve('/tmp/slides/quarterly-review.pdf'));
  assert.equal(
    plan.screenshotsDir,
    path.resolve('/tmp/slides/screenshots/20260330_120000'),
  );
  assert.equal(plan.revealInput, 'quarterly-review.html?export');
  assert.equal(plan.spawnCwd, path.resolve('/tmp/slides'));
});

test('findAvailablePdfPath increments suffix when same-name pdf exists', () => {
  const tempDir = fs.mkdtempSync(path.join(os.tmpdir(), 'reveal-export-test-'));
  const basePdfPath = path.join(tempDir, 'presentation.pdf');

  fs.writeFileSync(basePdfPath, '');
  fs.writeFileSync(path.join(tempDir, 'presentation-2.pdf'), '');

  const result = findAvailablePdfPath(basePdfPath);

  assert.equal(result, path.join(tempDir, 'presentation-3.pdf'));
});

test('buildDecktapeArgs uses paths relative to spawnCwd', () => {
  const plan = buildExportPlan('/tmp/slides/plat-1edtech-data-structures.html', '20260330_120000');

  const args = buildDecktapeArgs(plan);

  assert.deepEqual(args, [
    'decktape',
    'reveal',
    'plat-1edtech-data-structures.html?export',
    'plat-1edtech-data-structures.pdf',
    '--screenshots',
    '--screenshots-directory',
    path.join('screenshots', '20260330_120000'),
  ]);
});
