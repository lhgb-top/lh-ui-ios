# docsapp —— 独立文档 App（打包壳）

对标 `lh-ui-android` 的 `:docsapp` 模块（极薄 `com.android.application`：一个 LAUNCHER Activity，
`setContent { LhDocsContent() }`）。iOS 侧等价物 = 一个极薄 App target，`@main` 的 `App` 直接宿主
`LhDocsView()`。

## 结构

```
docsapp/
├── LhUIDocsApp.xcodeproj/project.pbxproj   # 最小工程：单 App target + 本地 SPM 包依赖
└── LhUIDocsApp/
    ├── LhUIDocsApp.swift                   # @main App → WindowGroup { LhDocsView() }（全部内容由库自管）
    └── Info.plist                          # 经典最小集（SwiftUI App 生命周期，无 SceneManifest）
```

依赖只有一条：App → `LhUIDocs` 产物（传递拉入 `LhUI` / `LhUITokens`），与 Android
`docsapp → docsui` 单依赖结构一致。`LhDocsView` 自管返回栈、明暗切换与全局 Toast，
App 壳不写任何 UI 逻辑。

## 前置条件（重要）

`Sources/LhUITokens` 是**生成物（gitignore）**，不同步则本地 SPM 包解析失败。首次打开前：

```bash
pnpm install && pnpm link:tokens   # 从 ../lh-ui-core/dist/ios 同步令牌
```

## 打开 / 运行 / 打包

```bash
open docsapp/LhUIDocsApp.xcodeproj
```

- **Run**：选模拟器直接跑，应展示完整文档界面（侧边栏分组导航 + 页面正文 + 真交互预览 +
  右上角「切换主题」+ 预览里的全局 Toast）。
- **Archive**：Product → Archive，产出「lh-ui 文档」IPA（bundle id `top.lhgb.ui.docsapp`，
  与 Android `applicationId` 同名，version 0.0.1 / build 1）。
- Xcode 打开时会**自动生成** scheme；若提示迁移工程格式，点是即可（不影响 Package.swift）。

## 为什么不是 SPM executable target

SwiftUI iOS App 的打包（IPA / 真机 /上架）必须经 Xcode App target；SPM executable 只能
在 macOS 宿主 `swift run`，不满足「直接打包」诉求。本工程保持 Package.swift 纯库，
打包能力独立放 `docsapp/`，两条路径互不干扰。
