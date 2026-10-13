# Picker 选择器

声明式底部滚轮选择器。`@Binding var visible` 控制显隐，`@Binding var value` 是选中项索引，
滚轮为自绘（`DragGesture` + 松手吸附），无系统控件依赖。

> 契约源：`lh-ui-core/specs/picker.json` ·
> 黄金用例：`lh-ui-core/cases/picker.json`（8 条，已翻译为 XCTest，macOS 宿主即可运行）

## 基本形态

底部弹出：顶部工具栏（取消 / 标题 / 确认），中间是滚轮与两条指示线。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">选择器</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">取消</span>
      <span class="sim-picker__title">选择</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">确认</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">选项一</div>
      <div class="sim-picker__item sim-picker__item--selected">选项二</div>
      <div class="sim-picker__item">选项三</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["选项一", "选项二", "选项三"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "选择"
)
```

## 滚轮交互

- 拖动改变整体偏移；松手后吸附到最近候选项（动画时长 `motion.duration.base`），
  选中索引变化时触发 `onValueChange`（黄金用例 `scroll-emits-onvaluechange`）。
- 指示线间距 = `picker.itemHeight`，选中项恒落在两线正中。

## 回调与边界

- 「确认」触发 `onConfirm`（payload 为当前索引）与 `onClose`（`confirm-also-emits-onclose`）。
- 「取消」触发 `onCancel`。
- `value` 越界时端侧 clamp：负数归零（`clamp-negative-value-to-zero`），超界归到末项
  （`clamp-overflow-value-to-last`）；空选项列表时索引恒为 0。
- `visible = false` 时不发射任何绘制指令（`hidden-not-rendered`）。

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "选择",
  confirmText: "确认",
  cancelText: "取消",
  onValueChange: { newIndex in
    // 滚动吸附回调
  },
  onConfirm: { newIndex in
    // 确认回调（payload 为当前索引）
  },
  onCancel: {
    // 取消回调
  }
)
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `visible` | 是否显示（受控双向绑定） | `Bool` | — |
| `options` | 候选项文字数组（单列） | `[String]` | — |
| `value` | 选中项索引（受控双向绑定，越界自动 clamp） | `Int` | — |
| `title` | 工具栏标题 | `String` | `""` |
| `confirmText` | 确认按钮文字 | `String` | `"确认"` |
| `cancelText` | 取消按钮文字 | `String` | `"取消"` |
| `onValueChange` | 滚动吸附回调，payload 为新索引 | `((Int) -> Void)?` | `nil` |
| `onConfirm` | 确认回调，payload 为当前索引 | `((Int) -> Void)?` | `nil` |
| `onCancel` | 取消回调 | `(() -> Void)?` | `nil` |
| `onClose` | 关闭回调（确认 / 取消都会触发） | `(() -> Void)?` | `nil` |

### 颜色

| 区域 | 颜色 |
| --- | --- |
| 面板底 | `color.background.default` |
| 遮罩 | `color.background.overlay` |
| 取消按钮 / 候选项文字 | `color.text.primary` |
| 标题 / 确认按钮 | `color.primary.default` |
| 指示线 | `color.border.lighter`（宽度取 `cell.borderWidth`） |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `picker.height` | 面板高度（260pt） |
| `picker.toolbarHeight` | 工具栏高度（44pt） |
| `picker.itemHeight` | 单项高度（决定滚轮与指示线间距） |
| `picker.itemFontSize` | 候选项与工具栏字号 |
| `picker.borderRadius` | 顶部圆角 |
| `color.background.overlay` / `color.background.default` | 遮罩与面板底色 |
| `color.border.lighter` / `cell.borderWidth` | 指示线颜色与宽度 |
| `color.primary.default` | 确认按钮与选中项文字色 |
| `zIndex.{modalBackdrop,modal}` | 遮罩与面板的层级 |
| `motion.duration.base` | 吸附动画时长（iOS 端为秒） |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | 确认触发 `onConfirm(1)` | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | 确认同时触发 onClose | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | 取消触发 onCancel | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | 滚动吸附触发 `onValueChange(2)` | View 层 `DragGesture.onEnded`（手势断言需模拟器） |
| `clamp-negative-value-to-zero` | 负索引 clamp 到 0 | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | 超界索引 clamp 到末项 | `testClampOverflowValueToLast` |
| `title-renders-text` | 标题正确渲染 | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | 隐藏时不渲染 | `testHiddenNotRendered` |

另有专项：`testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`。

```bash
swift test --filter LhPickerTests    # macOS 宿主即可跑，无需模拟器
```
