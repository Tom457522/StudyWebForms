# Mermaid Diagrams in Reveal.js

Use Mermaid when you need flowcharts, sequence diagrams, ER diagrams, Gantt charts, or other structured diagrams that Chart.js cannot express.

## Setup

Add the Mermaid CDN before the closing `</body>` tag, and initialize after `Reveal.initialize()`:

```html
<script src="https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.min.js"></script>
<script>
  mermaid.initialize({ startOnLoad: false, theme: 'neutral' });
  Reveal.on('ready', () => mermaid.run());
  Reveal.on('slidechanged', () => mermaid.run());
</script>
```

`slidechanged` handler ensures diagrams in later slides render when navigated to.

## Usage

```html
<section>
  <h2>System Architecture</h2>
  <div class="mermaid">
    graph LR
      A[Client] --> B[API Gateway]
      B --> C[Service]
      C --> D[(Database)]
  </div>
</section>
```

## Sizing

Mermaid SVGs expand to container width by default. To constrain:

```html
<div class="mermaid" style="max-width: 700px; margin: 0 auto;">
```

For side-by-side with content, use the same grid pattern as charts:

```html
<section style="display: flex; flex-direction: column; height: 100%;">
  <h2>Title</h2>
  <div style="flex: 1; display: grid; grid-template-columns: 1fr 1fr; gap: 30px; min-height: 0;">
    <div style="display: flex; flex-direction: column; justify-content: center;">
      <ul>
        <li>Point A</li>
        <li>Point B</li>
      </ul>
    </div>
    <div style="display: flex; align-items: center; justify-content: center;">
      <div class="mermaid">
        graph TD
          A --> B
          B --> C
      </div>
    </div>
  </div>
</section>
```

## Theme

Match the presentation palette by overriding Mermaid theme variables:

```javascript
mermaid.initialize({
  startOnLoad: false,
  theme: 'base',
  themeVariables: {
    primaryColor: '#5EA8A7',
    primaryBorderColor: '#277884',
    lineColor: '#277884',
    textColor: '#333'
  }
});
```

## Supported Diagram Types

`flowchart` / `graph`, `sequenceDiagram`, `classDiagram`, `erDiagram`, `gantt`, `stateDiagram-v2`, `pie`, `gitgraph`, `mindmap`, `timeline`

## Tips

1. Keep diagrams simple — too many nodes overflow the slide
2. Use `graph LR` (left-right) for wide slides, `graph TD` (top-down) for tall content
3. Test rendering by opening the HTML in a browser — Mermaid errors appear in the console
