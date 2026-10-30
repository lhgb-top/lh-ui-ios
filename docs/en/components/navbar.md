# Navbar

The top navigation bar for a page. A centered title with content on both sides, a bottom divider, and a stacking order from `zIndex.sticky`.

> Spec source: `lh-ui-core/specs/navbar.json` ·
> Golden cases: `lh-ui-core/cases/navbar.json` (6 entries, translated into XCTest, runnable on the macOS host)

## Basic usage

`title` is centered (absolutely positioned, so it never overlaps the content on either side); `leftText` / `rightText` hug the left and right edges respectively.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar basic</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">Back</span>
    <span class="sim-navbar__title">青花瓷 (ceramic blue)</span>
    <span class="sim-navbar__side">More</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">Page content</span></div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

```swift
LhNavbar(
  title: "青花瓷 (ceramic blue)",
  leftText: "Back",
  rightText: "More",
  onLeftClick: { /* Back */ },
  onRightClick: { /* More */ }
)
```

## Icons and border

`leftIcon` / `rightIcon` go through the `LhIconMap` mapping and are displayed alongside the text; `bordered = false` removes the bottom divider.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar icons</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>Back</span>
    </span>
    <span class="sim-navbar__title">Title</span>
    <span class="sim-navbar__side">
      <span>Settings</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">Borderless navbar</span></div>
  </div>
</div>
<p class="sim-note">HTML mock preview (iOS / SwiftUI appearance), not an on-device render</p>

## Tap gate

When neither `leftText` nor `leftIcon` is provided, the left side does not respond to taps (golden case `no-left-content-no-onleftclick`);
the same holds for the right side. Floating positioning is mounted by the caller with `.overlay` (the SwiftUI convention), while the component itself supplies the `zIndex.sticky` stacking order.

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷 (ceramic blue)", leftText: "Back", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Props

| Prop | Description | Type | Default |
| --- | --- | --- | --- |
| `title` | Centered title | `String` | `""` |
| `leftText` | Left-side text (not tappable when empty and there is no leftIcon) | `String` | `""` |
| `leftIcon` | Logical name of the left icon (mapped via `LhIconMap`) | `String?` | `nil` |
| `rightText` | Right-side text (not tappable when empty and there is no rightIcon) | `String` | `""` |
| `rightIcon` | Logical name of the right icon | `String?` | `nil` |
| `bordered` | Whether to show the bottom divider | `Bool` | `true` |
| `onLeftClick` | Left-side tap callback | `(() -> Void)?` | `nil` |
| `onRightClick` | Right-side tap callback | `(() -> Void)?` | `nil` |

### Colors

| Area | Color |
| --- | --- |
| Background | `color.background.default` |
| Title / side texts / icons | `color.text.primary` |
| Divider | `color.border.lighter` (width from `navbar.borderWidth`) |

## Token Reference

| Token | Purpose |
| --- | --- |
| `navbar.height` | Navbar height (44pt) |
| `navbar.paddingHorizontal` | Horizontal padding on both sides (12pt) |
| `navbar.titleFontSize` | Title and side text font size (16pt) |
| `navbar.iconSize` | Side icon size (20pt) |
| `navbar.borderWidth` | Bottom divider width |
| `color.border.lighter` | Divider color |
| `color.text.primary` | Title and side content color |
| `color.background.default` | Background |
| `zIndex.sticky` | Floating stacking order |

## Golden Case Mapping

| case id | Assertion | Local test |
| --- | --- | --- |
| `title-renders-text` | The title renders correctly | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | A left tap fires onLeftClick | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | A right tap fires onRightClick | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | With no left content, nothing is fired | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | The divider consumes the border.lighter token | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | The height consumes the navbar.height token | `testHeightUsesNavbarHeightToken` |

Plus dedicated tests: `testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`.

```bash
swift test --filter LhNavbarTests    # Runs on the macOS host, no simulator required
```
