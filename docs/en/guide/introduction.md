# Introduction

**lh-ui-ios** is the iOS implementation of the lh-ui family's **native bloodline**: a UI component library built on **Swift + SwiftUI**.

## Position in the family

```
                        ┌── web bloodline: share (TS core + SCSS) → plus / vue2 / react / uniapp
lh-ui family (one brand)├────┤
                        └── native bloodline: core (JSON tokens + specs + codegen) → android / ios / harmony / windows
                                                                    ↑ this repo
```

- **Build-time center**: `lh-ui-core` is the native bloodline's token source of truth (`tokens/*.json`), component specs (`specs/`), golden cases (`cases/`) and codegen tooling. It generates the Swift token skeletons (`LhTokens` / `LhDarkTokens` / `LhShadow`) but **generates no UI implementation**.
- **This repo's responsibilities**: hand-written SwiftUI Views, theme integration (Environment injection), prop enums and default-value binding, and translating the golden cases into XCTest.
- **Independent from the web bloodline**: it does not depend on `@lh-ui/share`, and releases constrain each other in no way. Visual consistency is kept by manually aligning against the *Design Language Baseline*.

## Design language

A Chinese-style theme: 青花瓷 (ceramic blue) primary (`#2B4C7C`), 宣纸白 (rice-paper white) background (`#FAF6F0`), 松花绿 (pine-flower green) for success, 藤黄 (gamboge) for warning, 朱砂 (cinnabar) for danger, and a serif font stack (Noto Serif SC → STSong → SimSun). Every visual value is a token; no literal values appear inside components.

## Why SwiftUI

- A first-class declarative UI on the platform, mentally isomorphic with Compose / ArkUI, which makes cross-platform spec alignment easy.
- One-step SPM integration, no JS runtime, no bridging layer.
- `#Preview` is the documentation and a `View` is a component — symmetric with the SFC experience of the web bloodline.

## Current status

- **The button full-pipeline prototype is delivered** (token consumption + resolveAppearance styling + SwiftUI View + XCTest + `#Preview` + docs site).
- The remaining 13 P0 components (icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar) will follow in the same paradigm.
