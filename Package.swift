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
    .testTarget(
      name: "LhUITests",
      dependencies: ["LhUI"],
      path: "Tests/LhUITests"
    ),
  ]
)
