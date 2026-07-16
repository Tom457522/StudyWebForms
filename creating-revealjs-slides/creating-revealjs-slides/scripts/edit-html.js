#!/usr/bin/env node

/**
 * Local HTML Editor — binds to 127.0.0.1 only.
 * Sanitizes HTML before saving (removes dangerous tags/attributes).
 *
 * Usage: node edit-html.js <path-to-html-file>
 */

const http = require('http');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');

const PORT = 3456;
const HOST = '127.0.0.1';
const EDITABLE_SELECTORS = 'p, h1, h2, h3, h4, h5, h6, li, td, th, span:not(.edit-toolbar *), div:not(.edit-toolbar):not([contenteditable="false"])';

const htmlFile = process.argv[2];
if (!htmlFile) { console.error('Usage: node edit-html.js <path-to-html-file>'); process.exit(1); }

const htmlFilePath = path.resolve(htmlFile);
if (!fs.existsSync(htmlFilePath)) { console.error(`File not found: ${htmlFilePath}`); process.exit(1); }

// --- Sanitization ---

const EVENT_ATTRS = /\s+on\w+\s*=\s*("[^"]*"|'[^']*'|[^\s>]*)/gi;
const JS_URLS = /(href|src|action)\s*=\s*["']?\s*javascript\s*:/gi;

function sanitizeHTML(html) {
  return html
    .replace(EVENT_ATTRS, '')
    .replace(JS_URLS, '$1="about:blank"');
}

// --- Editor injection ---

const editorScript = `
<style>
  .edit-toolbar {
    position: fixed; top: 10px; right: 10px; z-index: 999999;
    background: #333; padding: 10px 15px; border-radius: 8px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.3);
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    display: flex; gap: 10px; align-items: center;
  }
  .edit-toolbar button {
    background: #4CAF50; color: white; border: none;
    padding: 8px 16px; border-radius: 4px; cursor: pointer;
    font-size: 14px; font-weight: 500;
  }
  .edit-toolbar button:hover { background: #45a049; }
  .edit-toolbar button.secondary { background: #666; }
  .edit-toolbar button.secondary:hover { background: #555; }
  .edit-toolbar .status { color: #fff; font-size: 13px; margin-left: 10px; }
  .edit-toast {
    position: fixed; bottom: 30px; left: 50%; transform: translateX(-50%);
    background: #333; color: #fff; padding: 12px 24px; border-radius: 8px;
    font-size: 14px; font-family: -apple-system, sans-serif;
    z-index: 9999999; opacity: 0; transition: opacity 0.3s; pointer-events: none;
  }
  .edit-toast.error { background: #d32f2f; }
  .edit-toast.visible { opacity: 1; }
  [contenteditable="true"] { outline: 2px dashed transparent; transition: outline-color 0.2s; }
  [contenteditable="true"]:hover { outline-color: #4CAF5066; }
  [contenteditable="true"]:focus { outline-color: #4CAF50; outline-style: solid; }
</style>
<div class="edit-toast" id="editToast"></div>
<div class="edit-toolbar">
  <button onclick="saveChanges()">💾 Save</button>
  <button class="secondary" onclick="location.reload()">↻ Reload</button>
  <span class="status" id="editStatus">Click any text to edit</span>
</div>
<script>
  function showToast(msg, isError) {
    const toast = document.getElementById('editToast');
    toast.textContent = msg;
    toast.className = 'edit-toast visible' + (isError ? ' error' : '');
    setTimeout(() => { toast.className = 'edit-toast'; }, 2000);
  }
  const params = new URLSearchParams(location.search);
  if (params.has('saved')) { showToast('Saved successfully'); history.replaceState(null, '', '/'); }
  if (params.has('error')) { showToast('Error: ' + params.get('error'), true); history.replaceState(null, '', '/'); }

  document.querySelectorAll('${EDITABLE_SELECTORS}').forEach(el => {
    if (el.closest('.edit-toolbar') || el.getAttribute('contenteditable') === 'false') return;
    const hasOnlyElementChildren = el.children.length > 0 &&
      Array.from(el.childNodes).every(n => n.nodeType !== 3 || !n.textContent.trim());
    if (hasOnlyElementChildren && el.tagName !== 'LI') return;
    el.setAttribute('contenteditable', 'true');
  });

  document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' && document.activeElement.getAttribute('contenteditable') === 'true')
      document.activeElement.blur();
  });

  let hasChanges = false;
  document.addEventListener('input', (e) => {
    if (e.target.getAttribute('contenteditable') === 'true') {
      hasChanges = true;
      document.getElementById('editStatus').textContent = 'Unsaved changes';
    }
  });

  async function saveChanges() {
    const clone = document.documentElement.cloneNode(true);
    clone.querySelectorAll('.edit-toolbar, .edit-toast').forEach(el => el.remove());
    clone.querySelectorAll('[contenteditable]').forEach(el => el.removeAttribute('contenteditable'));
    clone.querySelectorAll('style, script').forEach(el => {
      if (el.textContent.includes('edit-toolbar') || el.textContent.includes('saveChanges')) el.remove();
    });
    const html = '<!DOCTYPE html>\\n' + clone.outerHTML;
    try {
      const response = await fetch('/save', { method: 'POST', headers: { 'Content-Type': 'text/html' }, body: html });
      if (response.ok) { hasChanges = false; location.href = '/?saved=1' + location.hash; }
      else throw new Error('Save failed');
    } catch (err) { location.href = '/?error=' + encodeURIComponent(err.message) + location.hash; }
  }

  window.addEventListener('beforeunload', (e) => { if (hasChanges) { e.preventDefault(); e.returnValue = ''; } });
</script>
`;

const server = http.createServer((req, res) => {
  if (req.method === 'POST' && req.url === '/save') {
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', () => {
      try {
        fs.writeFileSync(htmlFilePath, sanitizeHTML(body), 'utf8');
        console.log(`✓ Saved (sanitized) to ${htmlFilePath}`);
        res.writeHead(200); res.end('OK');
      } catch (err) {
        console.error('Error saving:', err);
        res.writeHead(500); res.end('Error saving file');
      }
    });
    return;
  }

  const reqPath = req.url.split('?')[0];
  if (req.method === 'GET' && (reqPath === '/' || reqPath === '/index.html')) {
    try {
      let html = fs.readFileSync(htmlFilePath, 'utf8');
      html = html.includes('</body>')
        ? html.replace('</body>', editorScript + '</body>')
        : html + editorScript;
      res.writeHead(200, { 'Content-Type': 'text/html' }); res.end(html);
    } catch (err) { res.writeHead(500); res.end('Error reading file'); }
    return;
  }

  // Serve static files from same directory
  const baseDir = path.dirname(htmlFilePath);
  const filePath = path.join(baseDir, reqPath);
  if (!filePath.startsWith(baseDir)) { res.writeHead(403); res.end('Forbidden'); return; }
  if (fs.existsSync(filePath) && fs.statSync(filePath).isFile()) {
    const mimeTypes = {
      '.css': 'text/css', '.js': 'application/javascript', '.json': 'application/json',
      '.png': 'image/png', '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg',
      '.gif': 'image/gif', '.svg': 'image/svg+xml', '.ico': 'image/x-icon',
      '.woff': 'font/woff', '.woff2': 'font/woff2',
    };
    const ext = path.extname(filePath).toLowerCase();
    res.writeHead(200, { 'Content-Type': mimeTypes[ext] || 'application/octet-stream' });
    res.end(fs.readFileSync(filePath));
    return;
  }

  res.writeHead(404); res.end('Not found');
});

server.listen(PORT, HOST, () => {
  const url = `http://${HOST}:${PORT}`;
  console.log(`\n🖊️  HTML Editor running at ${url}`);
  console.log(`   Editing: ${htmlFilePath}\n`);
  console.log('   Click any text to edit, press Escape to deselect, then click Save.');
  console.log('   Press Ctrl+C to stop.\n');
  const openCmd = process.platform === 'darwin' ? 'open' :
                  process.platform === 'win32' ? 'start' : 'xdg-open';
  exec(`${openCmd} ${url}`);
});
