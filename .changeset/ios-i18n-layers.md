'@lh-ui/ios': minor
---

组件库新增多语言层（家族原生端首创），并核对补全明暗主题：

- 新增 `Sources/LhUI/Locale/`：`LhTexts` 值类型 + 10 个内置语言包（与 web 血脉
  `@lh-ui/share` 的 `LH_LANGUAGE_CONST` 逐字对齐：zh-CN / zh-TW / en-US / ja-JP / ko-KR /
  de-DE / fr-FR / es / ar / ru），`LhLocale` 单例提供 `setLocale` / `register`（自定义语言包，
  遮蔽内置表、内置包永不被覆写），语义与 web 血脉 `LhLocale` 对齐（未注册语言回退 zh-CN 包）。
  `LhTheme` 内部以 `@ObservedObject` 持有单例：语言切换即整树重渲染，宿主零接线；
  同时注入 `\.locale`（ar 自动 RTL）。无 `LhTheme` 包裹时 Environment 键回退简体中文
  （缺省即中文，镜像「缺省即明色」）。新增 `View.lhTexts(_:)` 逐级覆盖入口。
- 组件改造：Dialog / Picker 的 `confirmText` / `cancelText` 改为 `String?`——`nil`（缺省）
  取当前语言包（`LhDialogStyle` / `LhPickerStyle.resolveAppearance` 增 `texts: LhTexts`
  参数，默认参数保现有纯函数调用不破），`""` 仍是「隐藏按钮」哨兵；调用点传字面量
  源码级兼容（String 隐式提升）。同时补齐 Dialog 遗漏的 spec 行为：确认/取消按钮
  空字符串时不渲染。Loading / Switch / Input / Textarea 的无障碍标签回退改走
  `Environment(\.lhTexts)`，不再硬编码中文。
- ⚠ 轻微 API 调整：`LhDialog.confirmText` / `cancelText` 与 `LhPicker` 同名字段类型
  `String → String?`（调用点源码级兼容；读取字段类型的代码需相应更新）。
- 文档宿主 `LhDocsView` 侧边栏新增「设置」区：主题（跟随系统 / 明色 / 暗色，
  首选项跟系统）与语言（10 内置 + 一个注册的 `vi` 越南语自定义包演示）切换，
  可直接验证多语言与明暗主题联动。Navbar 右侧保留明暗快捷切换。
- 测试：新增 `LhLocaleTests`（10 包完整性、spec 默认值逐字对齐、setLocale 回退、
  自定义包注册遮蔽与即时生效）；Dialog / Picker 测试补语言包默认解析、显式透传、
  空串哨兵用例。暗色断言在 15 个组件测试文件中已全覆盖（复核确认）。
- 文档：新增 `docs/guide/i18n.md`（语言范围 / 切换 / 自定义语言 / 与主题层对照表）
  并登记侧边栏；`docs/components/dialog.md` / `picker.md` 的默认值列改为语言包说明。
  `AGENTS.md` 新增红线「库内运行时字符串禁止字面量」与 LhTexts 消费机制说明。

⚠ 验证缺口：本机为 Windows，无法 `swift build` / `swift test`（macOS 专属）；
新增与修改的 Swift 文件已跑 `swift-frontend -parse`（语法级），类型级验证留待
macOS 宿主（`pnpm link:tokens` → `swift build` → `swift test`）。
