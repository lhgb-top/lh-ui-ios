# 安装

## 环境要求

- Xcode 15+，Swift 5.9+
- iOS 15.0+（macOS 12+ 仅用于宿主跑 XCTest）
- 构建期工具链：Node.js >= 20 + pnpm（仅令牌连接与文档站使用，**不进入运行时**）

## SPM 引入

Xcode：File → Add Package Dependencies…，填入本仓地址；或直接编辑 `Package.swift`：

```swift
dependencies: [
  .package(url: "https://github.com/lhgb/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

令牌目标 `LhUITokens` 已随 `LhUI` 依赖自动引入（SPM 包内 target，无需单独声明）。

## 同步令牌（源码开发本仓时）

令牌是生成物，必须从 `lh-ui-core` 同步（唯一真源，禁止手改）：

```bash
cd ../lh-ui-core && pnpm codegen   # 生成 dist/ios 令牌产物
cd ../lh-ui-ios
pnpm install                        # 安装构建期工具链
pnpm link:tokens                    # 同步令牌到 Sources/LhUITokens/
```

`pnpm link:tokens` 带三级存在性守卫：本地 `../lh-ui-core/dist/ios` → npm `@lh-ui/core` 产物 → 报错。

## 验证安装

```bash
swift build        # 编译
swift test         # 黄金用例（macOS 宿主即可跑，无需模拟器）
```
