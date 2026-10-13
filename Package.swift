// swift-tools-version:5.9

// lh-ui-ios —— Swift + SwiftUI 组件库（原生血脉）。
// LhUITokens 目标的源文件由 scripts/link-tokens.mjs 从 ../lh-ui-core/dist/ios
// 同步（生成物，gitignore）；产物内含 LhTokens / LhDarkTokens / LhShadow 三个类型。
import PackageDescription

let package = Package(
  name: "lh-ui-ios",
  platforms: [
    .iOS(.v15),
    .macOS(.v12), // 宿主跑 XCTest 用（黄金用例纯逻辑可在 macOS 验证）
  ],
  products: [
    .library(name: "LhUI", targets: ["LhUI"]),
    // 原生文档模块（D21）：宿主 LhDocsView + 生成页面 + 手写真交互预览。
    // 依赖 LhUI；App 侧引入本产物即可拖入一个真交互文档界面（对标 Android :docsui）。
    .library(name: "LhUIDocs", targets: ["LhUIDocs"]),
  ],
  targets: [
    .target(
      name: "LhUITokens",
      path: "Sources/LhUITokens"
    ),
    .target(
      name: "LhUI",
      dependencies: ["LhUITokens"],
      path: "Sources/LhUI"
    ),
    .target(
      name: "LhUIDocs",
      dependencies: ["LhUI"],
      path: "Sources/LhUIDocs"
    ),
    .testTarget(
      name: "LhUITests",
      dependencies: ["LhUI"],
      path: "Tests/LhUITests"
    ),
  ]
)
