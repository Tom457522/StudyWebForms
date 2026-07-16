---
name: creating-revealjs-slides
description: "Use when asked to create slides, a presentation, a deck, or a slideshow using reveal.js. Generates single-file HTML with no build step."
---

# Reveal.js Presentations

Create HTML presentations using reveal.js. No build step — just open the HTML in a browser.

## Output

Single **HTML file** — slides + reveal.js from CDN (fixed versions) + CSS inline. No external files needed.

## Design Defaults

- **Font**: IBM Plex Sans JP (Google Fonts CDN)
- **Palette**: Teal & Coral (`--primary-color: #5EA8A7`, `--secondary-color: #277884`, accent `#FE4447`)
- **Background**: flexible per-slide via CSS variables or `data-background-color`
- **Confidential badge**: red text, fixed top-right on every slide — **NEVER remove or override the `::after` rule in CSS, even when customizing themes**
- **Text size**: base 18pt (readable + information-dense)

### Icons

- Use **Font Awesome** (`<i class="fa-solid fa-xxx">`) for all icons in slides. The CDN is already loaded.
- Do **NOT** use Unicode emoji (e.g. `🏅📊🔗`) directly in slide HTML. Headless Chromium requires a system emoji font (e.g. `fonts-noto-color-emoji`) to render them — without it they appear as `□` (tofu).
- If Unicode emoji is unavoidable, ensure the export environment has `fonts-noto-color-emoji` installed.

Before creating any presentation, analyze the content and choose appropriate design elements. State your design approach before writing code. See [references/design-guide.md](references/design-guide.md) for palettes and patterns.

## Workflow

### Step 1: Plan Structure

Determine slide count, section dividers, vertical stacks.

### Step 2: Generate Scaffold

```bash
node <skill-path>/scripts/create-presentation.js \
  --structure 1,1,d,3,1,d,1 \
  --title "My Presentation" \
  --output presentation.html
```

Options: `--slides N`, `--structure <list>` (1=slide, N>1=vertical stack, d=divider), `--output`, `--title`

### Step 3: Customize CSS

CSS is embedded inline in the HTML `<style>` block. Edit CSS variables (colors, fonts) directly in the generated file.

### Step 4: Fill HTML Content

Use Edit tool incrementally — one or a few slides at a time. Each scaffold slide has unique placeholder text for targeting.

**Key patterns:**
- Every `<section>` needs a unique `id`
- `class="section-divider"` for centered title slides
- Wrap content in `<div class="content">` for consistent spacing
- All visible text inside `<p>`, `<li>`, or `<h1>`–`<h6>` (never bare text in `<div>`/`<span>`)
- Inline CSS grid for multi-column layouts (vary per slide)
- Use `.text-lg` through `.text-4xl` to scale up text on lighter slides

### Step 5: Check Overflow

```bash
node <skill-path>/scripts/check-overflow.js presentation.html
```

### Step 6: Visual Review

```bash
node <skill-path>/scripts/export-pdf.js presentation.html
```

Review EVERY slide screenshot. See [references/design-guide.md](references/design-guide.md) for what to look for.

### PDF Export In Codex / Sandbox Environments

Start with the skill script:

```bash
node <skill-path>/scripts/export-pdf.js presentation.html
```

Do not bypass the script as the first attempt. It is the canonical entry point for this skill.

If export fails with a browser launch error such as:

- `setsockopt: Operation not permitted`
- `Failed to launch the browser process`

the usual cause is the sandbox blocking Chromium, not the HTML file itself.

In that case:

1. Keep the same entry point and rerun `node <skill-path>/scripts/export-pdf.js presentation.html` outside the sandbox or with escalated permissions.
2. Do not switch to ad-hoc `decktape` commands unless you are debugging the script itself.
3. Explain briefly that `export-pdf.js` launches `decktape` and Chromium internally, so browser-launch permissions are required.

Use direct `decktape` invocation only for diagnosis, not as the normal workflow.

### Step 7: Suggest Browser Editing

```bash
node <skill-path>/scripts/edit-html.js presentation.html
```

Click text to edit inline, Save to write back. Server binds to 127.0.0.1 only.

## Charts

**MUST read [references/charts.md](references/charts.md) before adding any chart.** Charts require specific flexbox/grid patterns and `maintainAspectRatio: false`.

## Mermaid Diagrams

Flowcharts, sequence diagrams, ER diagrams など構造的なダイアグラムが必要な場合は Mermaid を使ってよい。**使う前に [references/mermaid.md](references/mermaid.md) を読むこと。**

## Advanced Features

Fragments, speaker notes, backgrounds, auto-animate, transitions — see [references/advanced-features.md](references/advanced-features.md).

## Reveal.js Config

```javascript
Reveal.initialize({
  controls: true, progress: true, slideNumber: true,
  hash: true, transition: 'slide', center: false,
});
```

## Built-in Classes

- `r-fit-text` — auto-size text to fill slide
- `r-stretch` — stretch element to fill remaining space
- `r-stack` — layer elements on top of each other

## CDN Versions (Fixed)

- reveal.js: `5.1.0`
- reveal.js-plugins (chart): `4.6.0`
- Chart.js: `4.4.7`
- Font Awesome: `6.5.1`
- IBM Plex Sans JP: Google Fonts

## Dependencies

- Node.js (scripts)
- Puppeteer (`npm install puppeteer`) for overflow check
- Decktape (`npx decktape`) for screenshots
