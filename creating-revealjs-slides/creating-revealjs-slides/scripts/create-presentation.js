#!/usr/bin/env node

/**
 * Creates a reveal.js presentation scaffold.
 * Usage: node create-presentation.js [options]
 */

const fs = require('fs');
const path = require('path');

const BASE_STYLES_PATH = path.join(__dirname, '..', 'references', 'base-styles.css');

function parseArgs(args) {
  const options = {
    slides: null, structure: null,
    output: 'presentation.html', title: 'Presentation',
  };
  for (let i = 0; i < args.length; i++) {
    const arg = args[i];
    if (arg === '--slides' || arg === '-s') options.slides = parseInt(args[++i], 10);
    else if (arg === '--structure') options.structure = args[++i].split(',').map(n => n === 'd' ? 'd' : parseInt(n, 10));
    else if (arg === '--output' || arg === '-o') options.output = args[++i];
    else if (arg === '--title') options.title = args[++i];
    else if (arg === '--help' || arg === '-h') { printHelp(); process.exit(0); }
  }
  return options;
}

function printHelp() {
  console.log(`
create-presentation.js - Generate a reveal.js presentation scaffold

Options:
  --slides, -s <num>    Number of horizontal slides
  --structure <list>    Mixed layout: 1=slide, N>1=vertical stack, d=divider
  --output, -o <file>   Output filename (default: presentation.html)
  --title <text>        Presentation title
  --help, -h            Show help

Examples:
  node create-presentation.js --slides 10 -o deck.html
  node create-presentation.js --structure 1,1,d,3,1,d,1 --title "Q4 Review"
`);
}

function generateSlides(structure) {
  let slides = '';
  let hIndex = 1;
  let dividerCount = 1;

  for (const item of structure) {
    if (item === 'd') {
      slides += `
      <section id="divider-${dividerCount}" class="section-divider" data-state="is-section-divider">
        <h1>Section ${dividerCount} Title</h1>
      </section>\n`;
      dividerCount++;
      hIndex++;
    } else if (item === 1) {
      if (hIndex === 1) {
        slides += `
      <section id="title" class="section-divider" data-state="is-section-divider">
        <h1>Presentation Title</h1>
      </section>\n`;
      } else {
        slides += `
      <section id="slide-${hIndex}">
        <h2>Slide ${hIndex} Title Here</h2>
      </section>\n`;
      }
      hIndex++;
    } else {
      slides += `
      <section>\n`;
      for (let v = 1; v <= item; v++) {
        slides += `        <section id="slide-${hIndex}-${v}">
          <h2>Slide ${hIndex}.${v} Title Here</h2>
        </section>\n`;
      }
      slides += `      </section>\n`;
      hIndex++;
    }
  }
  return slides;
}

function generateHTML(options) {
  return `<!doctype html>
<html lang="ja">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${options.title}</title>

  <!-- Reveal.js 5.1.0 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reset.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.css">

  <!-- Font Awesome 6.5.1 -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <!-- Custom styles (inline) -->
  <style>
${options.stylesContent}
  </style>

  <!-- Chart.js 4.4.7 -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.7"></script>
</head>
<body>
  <div class="reveal">
    <div class="slides">
${generateSlides(options.structure)}
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/reveal.js@5.1.0/dist/reveal.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/reveal.js-plugins@4.6.0/chart/plugin.js"></script>
  <script>
    Reveal.initialize({
      width: 1280,
      height: 720,
      margin: 0,
      controls: true,
      progress: true,
      slideNumber: false,
      hash: true,
      transition: 'slide',
      center: false,
      plugins: [ RevealChart ],
      chart: {
        defaults: Object.assign({
          color: 'rgba(0, 0, 0, 0.8)',
          borderColor: 'rgba(0, 0, 0, 0.8)',
          devicePixelRatio: 2
        }, window.location.search.includes('export') ? { animation: false } : {})
      }
    });
  </script>
</body>
</html>
`;
}

function main() {
  const options = parseArgs(process.argv.slice(2));

  if (options.slides !== null && options.structure !== null) {
    console.error('Error: Cannot use both --slides and --structure.');
    process.exit(1);
  }

  if (options.slides === null && options.structure === null) {
    options.structure = [1, 1, 1, 1, 1];
  } else if (options.slides !== null) {
    if (options.slides < 1 || isNaN(options.slides)) { console.error('Error: Slide count must be >= 1.'); process.exit(1); }
    options.structure = Array(options.slides).fill(1);
  } else {
    if (options.structure.some(n => n !== 'd' && (n < 1 || isNaN(n)))) {
      console.error('Error: Structure values must be positive integers or "d".');
      process.exit(1);
    }
  }

  const totalSlides = options.structure.reduce((a, b) => a + (b === 'd' ? 1 : b), 0);
  const outputDir = path.dirname(path.resolve(options.output));

  if (outputDir && outputDir !== '.') fs.mkdirSync(outputDir, { recursive: true });

  // Read base styles and embed inline
  if (fs.existsSync(BASE_STYLES_PATH)) {
    options.stylesContent = fs.readFileSync(BASE_STYLES_PATH, 'utf8');
  } else {
    console.warn(`Warning: Could not find ${BASE_STYLES_PATH}`);
    options.stylesContent = '/* base-styles.css not found */';
  }

  fs.writeFileSync(options.output, generateHTML(options));
  console.log(`Created ${options.output} (${totalSlides} slides, structure: ${options.structure.join(',')}).`);
  console.log(`Open in a browser to view. Edit CSS inside <style> to customize.`);
}

main();
