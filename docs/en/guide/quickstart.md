# Quick Start

## Minimal example

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* Handle the tap */ },
        type: .primary,
        text: "Primary"
      )
    }
  }
}
```

`LhTheme` is the theme container: every Lh component inside it consumes tokens automatically through the Environment; without the wrapper they fall back to the light palette.

## Types and sizes

```swift
// Six types
LhButton(lhOnClick: {}, text: "Default")                      // .default
LhButton(lhOnClick: {}, type: .primary, text: "Primary")
LhButton(lhOnClick: {}, type: .success, text: "Success")
LhButton(lhOnClick: {}, type: .warning, text: "Warning")
LhButton(lhOnClick: {}, type: .danger, text: "Danger")
LhButton(lhOnClick: {}, type: .info, text: "Info")

// Three sizes
LhButton(lhOnClick: {}, lhSize: .small, text: "Small")
LhButton(lhOnClick: {}, lhSize: .medium, text: "Medium")
LhButton(lhOnClick: {}, lhSize: .large, text: "Large")
```

## States

```swift
// Disabled: does not respond to taps and renders the disabled style
LhButton(lhOnClick: {}, disabled: true, text: "Disabled")

// Loading: shows an indicator and does not fire lhOnClick
LhButton(lhOnClick: {}, loading: true, text: "Loading")

// Both present: disabled wins (golden case disabled-precedes-loading)
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "Disabled wins")
```

## Icon and pattern background

```swift
// Icon names resolve against the local icon system (SF Symbol mapping, see LhButtonStyle.icon(for:); unregistered names are not drawn)
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "Search")

// Chinese-style decorative pattern (consumes the color.decoration token)
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "Pattern")
```

## Light and dark themes

```swift
LhTheme(isDark: isDark) {
  // Every component inside switches to dark tokens automatically (core pre-computed values, no runtime color mixing)
}
```

## Component preview

Native UI cannot be rendered live in the browser, so this site shows its appearance with an **inline static HTML phone-frame simulator**:

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">Default</button>
      <button class="sim-btn sim-btn--primary">Primary</button>
      <button class="sim-btn sim-btn--success">Success</button>
      <button class="sim-btn sim-btn--warning">Warning</button>
      <button class="sim-btn sim-btn--danger">Danger</button>
      <button class="sim-btn sim-btn--info">Info</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Small</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">Large</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Disabled</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Loading
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Search</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Pattern</button>
    </div>
  </div>
</div>
<p class="sim-note">An HTML mock preview of the iOS (SwiftUI) appearance — not an on-device render. Every style value is taken from the core token snapshot, same source and same values as on a real device. For the true on-device appearance, refer to <code>#Preview</code> and device screenshots.</p>

> The simulator's dark mode follows the site: toggle the theme in the top-right corner and the colors inside the phone frame change (dark tokens are pre-computed by core).
