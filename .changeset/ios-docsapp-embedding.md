'@lh-ui/ios': minor
---

补齐与 Android 双模块（`:docsui` + `:docsapp`）对齐的「打包 + 嵌入」能力：

- 新增 `docsapp/` 独立 Xcode 工程（对标 Android `:docsapp` 极薄 application 模块）：单 App target
  `LhUIDocsApp`，`@main` 的 `App` 直接宿主 `LhDocsView()`；通过本地 Swift Package 引用仓库根
  `Package.swift`，依赖只有 `LhUIDocs` 一个产物。`open docsapp/LhUIDocsApp.xcodeproj` 即可
  Run 模拟器 / Archive 出「lh-ui 文档」IPA（bundle id `top.lhgb.ui.docsapp`，与 Android
  `applicationId` 同名）。前置条件：先 `pnpm link:tokens`（`Sources/LhUITokens` 是 gitignore 生成物）。
- 新增 UIKit 嵌入桥 `Sources/LhUIDocs/LhDocsUIKit.swift`（对标 Android `LhDocs.launch(context)`）：
  `LhDocsViewController`（`UIHostingController<LhDocsView>` 子类），UIKit 宿主
  `present(LhDocsViewController(), animated: true)` 一行即得完整文档界面；经
  `#if canImport(UIKit)` 门控，macOS 宿主的 `swift build` / `swift test`（黄金用例环境）
  不受影响。
- 文档补嵌入说明：`README.md` 新增「嵌入原生文档界面」与「独立文档 App（打包）」两节；
  `docs/guide/quickstart.md` 末尾新增同名小节（SwiftUI / UIKit 两种嵌入方式 + docsapp 指引）。
- 仓 `AGENTS.md`：目录树登记 `docsapp/` 与 `LhDocsUIKit.swift`，命令表补打包文档 App，
  gotcha 区新增两条（UIKit 桥经 `canImport(UIKit)` 门控、其编译只能靠 docsapp 的 iOS 构建
  验证；docsapp 是 Xcode 工程不参与 `swift build`）。

⚠ 验证缺口：本机为 Windows，无法运行 Xcode / `swift build`；已对新增 Swift 文件跑
`swift-frontend -parse`（语法级 0 错误），并用 node 脚本解析 `project.pbxproj` 的 OpenStep
plist 结构校验 UUID 引用闭合。编译与运行（模拟器 Run、Archive 出 IPA、UIKit 桥编译）
留待 macOS 宿主验证。
