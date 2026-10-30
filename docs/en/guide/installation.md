# Installation

## Requirements

- Xcode 15+, Swift 5.9+
- iOS 15.0+ (macOS 12+ is only needed to run XCTest on the host)
- Build-time toolchain: Node.js >= 20 + pnpm (used only for token linking and the docs site; **never enters the runtime**)

## Adding via SPM

In Xcode: File → Add Package Dependencies…, and enter this repo's URL; or edit `Package.swift` directly:

```swift
dependencies: [
  .package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

The token target `LhUITokens` is pulled in automatically with the `LhUI` dependency (a target inside the SPM package, no separate declaration needed).

## Syncing tokens (when developing this repo from source)

Tokens are generated artifacts and must be synced from `lh-ui-core` (the single source of truth — hand-editing is forbidden):

```bash
cd ../lh-ui-core && pnpm codegen   # Generates the dist/ios token artifacts
cd ../lh-ui-ios
pnpm install                        # Installs the build-time toolchain
pnpm link:tokens                    # Syncs tokens into Sources/LhUITokens/
```

`pnpm link:tokens` carries a three-level existence guard: local `../lh-ui-core/dist/ios` → the npm `@lh-ui/core` artifact → error.

## Verifying the installation

```bash
swift build        # Compiles
swift test         # Golden cases (runs on the macOS host, no simulator required)
```
