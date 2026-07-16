# Design Guide

## Color Palette Selection

Choose colors that match the subject matter, industry, mood, and audience. Build a palette of 3-5 colors (dominant + supporting + accent). Ensure text contrast.

**Example palettes** (adapt or create your own):

1. **Classic Blue**: #1C2833, #2E4053, #AAB7B8, #F4F6F6
2. **Teal & Coral**: #5EA8A7, #277884, #FE4447, #FFFFFF
3. **Bold Red**: #C0392B, #E74C3C, #F39C12, #F1C40F, #2ECC71
4. **Warm Blush**: #A49393, #EED6D3, #E8B4B8, #FAF7F2
5. **Burgundy Luxury**: #5D1D2E, #951233, #C15937, #997929
6. **Deep Purple & Emerald**: #B165FB, #181B24, #40695B, #FFFFFF
7. **Cream & Forest Green**: #FFE1C7, #40695B, #FCFCFC
8. **Pink & Purple**: #F8275B, #FF574A, #FF737D, #3D2F68
9. **Lime & Plum**: #C5DE82, #7C3A5F, #FD8C6E, #98ACB5
10. **Black & Gold**: #BF9A4A, #000000, #F4F6F6
11. **Sage & Terracotta**: #87A96B, #E07A5F, #F4F1DE, #2C2C2C
12. **Charcoal & Red**: #292929, #E33737, #CCCBCB
13. **Vibrant Orange**: #F96D00, #F2F2F2, #222831
14. **Forest Green**: #191A19, #4E9F3D, #1E5128, #FFFFFF
15. **Retro Rainbow**: #722880, #D72D51, #EB5C18, #F08800, #DEB600
16. **Vintage Earthy**: #E3B448, #CBD18F, #3A6B35, #F4F1DE
17. **Coastal Rose**: #AD7670, #B49886, #F3ECDC, #BFD5BE
18. **Orange & Turquoise**: #FC993E, #667C6F, #FCFCFC

## Slide Content Principles

**Diverse presentation is key.** Even with similar content types, vary the visual layout:

- Use different layouts across slides: columns, stacked containers, styled cards
- Mix container styles: plain text, custom styled containers, blockquotes
- Use visual hierarchy: `<strong>` for key terms, different colors for categories
- Break up lists with other elements (quotes, styled containers, columns)
- Don't repeat the same layout on consecutive slides

**When a slide has less content, make it bigger** — don't leave empty space with tiny text.

**Keep it scannable:**
- Short bullet points, not paragraphs
- One main idea per slide when possible
- Use Font Awesome icons for visual interest

## Multi-Column Layouts

Always use inline CSS grid (do NOT create utility classes):

```html
<!-- Equal columns -->
<div style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 30px;">

<!-- Three columns -->
<div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px;">

<!-- Unequal columns -->
<div style="display: grid; grid-template-columns: 1fr 2fr; gap: 30px;">
```

## CSS Components

### Blockquotes
```css
.reveal blockquote {
  border-left: 4px solid var(--primary-color);
  padding-left: 20px;
  margin: 20px 0;
  font-style: italic;
  background: none;
  box-shadow: none;
  width: 100%;
}
```

### Icons (Font Awesome)
```html
<i class="fa-solid fa-lightbulb"></i>
<i class="fa-solid fa-check"></i>
<i class="fa-solid fa-gears"></i>
```

### Custom CSS Classes

Use inline styles for per-slide layout. But when a visual pattern repeats 3+ times, create a CSS class in `styles.css`. Common examples: stat boxes, feature cards, timeline steps, profile cards.

## Visual Review Checklist

After capturing screenshots, check every slide for:

1. **Color inheritance in containers**: Text inside styled containers may inherit wrong color from parent. Light text on dark background + light container = unreadable unless you set dark text explicitly.
2. **Custom bullet styling**: Bullets may not contrast on all container backgrounds.
3. **Icons not rendering**: Empty squares where Font Awesome icons should be.
4. **Overflow edge cases**: Complex nested layouts may slip through the script.
5. **Unexpected text wrap**: Text overflowing to two lines in column layouts, making headers uneven.
