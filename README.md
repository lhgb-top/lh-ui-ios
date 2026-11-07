# lh-ui-ios

> lh-ui 家族 · 原生血脉 · iOS 端 —— **Swift + SwiftUI** UI 组件库（Swift Package）。
>
> 📖 **文档站**：<https://www.lhgb.top/lhui/ios/>
>
> 同品牌的设计令牌、组件契约与黄金用例定义在 `lh-ui-core`（构建期中心，移动端运行时零 JS）；
> 本仓只手写 SwiftUI UI。与 web 血脉（plus / vue2 / react / uniapp）互相独立、不共享运行时代码，
> 视觉一致性靠《设计语言基线》人工对齐。

## 特性

- **国风设计语言**：青花瓷蓝主色、宣纸白底、藤黄朱砂点缀，衬线字体栈（由 core 令牌驱动）。
- **令牌驱动**：组件零硬编码色值/间距，全部消费 codegen 生成的 `LhTokens` / `LhDarkTokens`。
- **明暗双主题**：`LhTheme` 一行切换（Environment 注入），暗色令牌由 core 预计算（无运行时调色）。
- **契约一致**：props 命名与 `lh-ui-core/specs` 逐条对齐，四端 + web 行为共享。
- **黄金用例**：`cases/button.json` 的 8 条断言翻译为 XCTest，**macOS 宿主即可运行**（无需模拟器）。

## 快速开始

### 1. SPM 引入

Xcode：File → Add Package Dependencies… 填入本仓地址；或：

```swift
.package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
```

### 2. 使用组件

```swift
import SwiftUI
import LhUI

LhTheme {
    LhButton(lhOnClick: { /* ... */ }, type: .primary, lhSize: .large, text: "主要按钮")
}
```

### 3. 明暗主题

```swift
LhTheme(isDark: isDark) {
    // 内部所有 Lh 组件自动消费暗色令牌
}
```

## 嵌入原生文档界面

本仓自带一套**真交互文档 UI**（SwiftUI 实现，对标 Android `:docsui`）：全部组件文档 +
指南 + 明暗切换 + 实时可交互预览。引入 `LhUIDocs` 产物即可拖入使用（对标 Android 的
拖入即用）。

### SwiftUI 宿主

```swift
import SwiftUI
import LhUIDocs

// 直接放进窗口，或 push 进 NavigationStack；零配置
LhDocsView()
```

### UIKit 宿主

```swift
import LhUIDocs

present(LhDocsViewController(), animated: true)
// 等价 Android：LhDocs.launch(context)
```

## 独立文档 App（打包）

`docsapp/` 是一个极薄 Xcode App 工程（对标 Android `:docsapp`），唯一职责是把
`LhDocsView()` 装进可打包的 App 壳，直接打出「lh-ui 文档」IPA：

```bash
pnpm install && pnpm link:tokens   # 前置：同步令牌生成物（Sources/LhUITokens 是 gitignore）
open docsapp/LhUIDocsApp.xcodeproj # Run（模拟器）/ Product → Archive
```

详见 [docsapp/README.md](./docsapp/README.md)。

## 源码开发（本仓）

```bash
cd ../lh-ui-core && pnpm codegen   # 生成 dist/ios 令牌产物
cd ../lh-ui-ios
pnpm install && pnpm link:tokens   # 同步令牌到 Sources/LhUITokens/（生成物，gitignore）
swift build && swift test
```

## 文档

```bash
pnpm docs:dev    # 本地文档站（含 HTML 模拟器预览），端口 5182
```

组件示例预览说明：原生 UI 无法在浏览器实时渲染，文档站用**内联静态 HTML 手机框模拟器**
展示外观效果（样式由 core 令牌快照生成的 CSS 变量驱动，与真机同源同值）。真机外观以
`#Preview`（`LhButtonPreviews.swift`）与设备截图为准。

## 仓库规范

见 [AGENTS.md](./AGENTS.md)（本仓权威规范：目录职责、红线、命令、gotchas）。

## 家族

| 成员 | 血脉 | 技术栈 |
| --- | --- | --- |
| lh-ui-share → plus / vue2 / react / uniapp | web | TS core + SCSS + 各框架 |
| lh-ui-core → android / **ios** / harmony / windows | 原生 | JSON 令牌 + codegen → 各端原生 |
