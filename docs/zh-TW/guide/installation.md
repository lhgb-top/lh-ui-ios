# 安裝

## 環境要求

- Xcode 15+，Swift 5.9+
- iOS 15.0+（macOS 12+ 僅用於宿主跑 XCTest）
- 構建期工具鏈：Node.js >= 20 + pnpm（僅令牌連接與文件站使用，**不進入執行時**）

## SPM 引入

Xcode：File → Add Package Dependencies…，填入本倉位址；或直接編輯 `Package.swift`：

```swift
dependencies: [
  .package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

令牌目標 `LhUITokens` 已隨 `LhUI` 依賴自動引入（SPM 包內 target，無需單獨宣告）。

## 同步令牌（源碼開發本倉時）

令牌是生成物，必須從 `lh-ui-core` 同步（唯一真源，禁止手改）：

```bash
cd ../lh-ui-core && pnpm codegen   # 生成 dist/ios 令牌產物
cd ../lh-ui-ios
pnpm install                        # 安裝構建期工具鏈
pnpm link:tokens                    # 同步令牌到 Sources/LhUITokens/
```

`pnpm link:tokens` 帶三級存在性守衛：本地 `../lh-ui-core/dist/ios` → npm `@lh-ui/core` 產物 → 報錯。

## 驗證安裝

```bash
swift build        # 編譯
swift test         # 黃金用例（macOS 宿主即可執行，無需模擬器）
```
