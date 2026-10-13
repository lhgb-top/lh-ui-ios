---
'@lh-ui/ios': minor
---

新增原生文档模块 `LhUIDocs`（D21：各端原生 docs 模块作为真交互主场），对标 Android `:docsui`：

- 新 SPM target / product `LhUIDocs`（依赖 `LhUI`）：宿主 `LhDocsView` 自管返回栈、dogfood
  自家 `LhNavbar` 与 `LhToast`、右上角切换明暗；App 侧引入产物拖入一个 View 即得真交互文档界面。
- `scripts/gen-doc-pages.mjs`（`pnpm gen:docs`）：从 `docs/**/*.md` 生成 19 个页面条目
  （14 组件 + 5 指南）与 `DocRegistry.swift`，生成物首行直接写「禁手改」文件头；分组顺序对齐
  `config.ts` 侧边栏；`##` 场景标题经 SCENE_MAP 映射到 `Previews/{Comp}Previews.swift` 的方法。
- `Previews/` 14 份手写 SwiftUI 真交互预览：取色取距一律走 `LhTokens.Docs.*` /
  `LhDarkTokens.Docs.*` / `Environment(\.lhColors)`，零字面量；`DocPreviewScope` 注入宿主的
  全局 Toast 通道，预览不自持浮层。
- 修复 `:::` VitePress 容器标记行泄漏进生成页正文的问题（剥标记行、保留正文）。
- 仓 `AGENTS.md`：目录树登记 `LhUIDocs/`，新增两条红线（docs 模块零字面量、生成物禁手改）、
  一条 gotcha（`LhInput` / `LhTextarea` 尾随闭包绑的是 `onBlur` 而非 `onValueChange`）、
  命令表补 `gen:docs`。

⚠ 验证缺口：本机为 Windows，Swift on Windows 无 SwiftUI，`swift build` 无法运行；已对全部新增 /
生成 Swift 文件跑 `swift-frontend -parse`（语法级 0 错误），类型级验证留待 macOS 宿主。
