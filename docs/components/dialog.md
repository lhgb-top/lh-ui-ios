# Dialog 对话框

声明式模态对话框。`@Binding var visible` 控制显隐，遮罩 + 居中面板，按钮复用 `LhButton`。

> 契约源：`lh-ui-core/specs/dialog.json` ·
> 黄金用例：`lh-ui-core/cases/dialog.json`（8 条，已翻译为 XCTest，macOS 宿主即可运行）

## 类型

六种类型决定确认按钮的语义色（`buttonType(for:)` 映射到 `LhButtonType`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 类型</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">默认对话框</button>
      <button class="sim-btn sim-btn--danger">危险对话框</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">删除确认</div>
    <div class="sim-dialog__content">此操作将永久删除该项，是否继续？</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">取消</button>
      <button class="sim-btn sim-btn--danger">确认</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "删除确认",
  content: "此操作将永久删除该项，是否继续？",
  type: .danger,
  confirmText: "确认",
  cancelText: "取消"
)
```

## 显隐与回调

- `visible = true` 渲染遮罩与面板；`visible = false` 不发射任何绘制指令（黄金用例 `hidden-not-rendered`）。
- 点击「确认」依次触发 `onConfirm` 与 `onClose`（`confirm-also-emits-onclose`）。
- 点击「取消」触发 `onCancel`；`onClose` 由组件内部负责把 `visible` 置回 `false`（包在 `withAnimation` 内）。
- `closable = true` 时点击遮罩也会触发 `onClose`（`closable-overlay-emits-onclose`）；默认不关闭（`not-closable-blocks-overlay-close`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog 遮罩可关闭</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">提示</div>
    <div class="sim-dialog__content">点击遮罩即可关闭</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">取消</button>
      <button class="sim-btn sim-btn--primary">确认</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `visible` | 是否显示（受控双向绑定） | `Bool` | — |
| `title` | 标题 | `String` | `""` |
| `content` | 正文内容 | `String` | `""` |
| `type` | 对话框类型，决定确认按钮语义色 | `LhDialogType` | `.default` |
| `confirmText` | 确认按钮文字 | `String` | `"确认"` |
| `cancelText` | 取消按钮文字 | `String` | `"取消"` |
| `closable` | 点击遮罩是否可关闭 | `Bool` | `false` |
| `onConfirm` | 确认回调 | `(() -> Void)?` | `nil` |
| `onCancel` | 取消回调 | `(() -> Void)?` | `nil` |
| `onClose` | 关闭回调（遮罩点击 / 按钮·取消 / 按钮·确认 都会触发） | `(() -> Void)?` | `nil` |

### LhDialogType

| 值 | 确认按钮类型 | 底色 |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + 描边 |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `dialog.width` | 面板宽度（320pt） |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | 面板内边距 |
| `dialog.borderRadius` | 面板圆角 |
| `dialog.titleFontSize` / `dialog.contentFontSize` | 标题与正文字号 |
| `dialog.gap` | 各区块纵向间距 |
| `color.background.overlay` | 遮罩色 |
| `color.background.default` | 面板底色 |
| `color.text.{primary,regular}` | 标题与正文颜色 |
| `shadow.base` | 面板阴影（LhShadow 载体） |
| `zIndex.{modalBackdrop,modal}` | 遮罩与面板的层级 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `confirm-emits-onconfirm` | 确认触发 onConfirm | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | 取消触发 onCancel | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | 确认同时触发 onClose | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | 遮罩点击触发 onClose | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | 默认遮罩不关闭 | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | 隐藏时不渲染 | `testHiddenNotRendered` |
| `title-renders-text` | 标题正确渲染 | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | 危险类型消费危险色令牌 | `testDangerTypeUsesDangerToken` |

另有专项：`testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`。

```bash
swift test --filter LhDialogTests    # macOS 宿主即可跑，无需模拟器
```
