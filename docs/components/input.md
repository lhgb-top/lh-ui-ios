# Input 输入框

受控单行输入框。`@Binding var value` 双向绑定，支持明暗密文、清除按钮、字数上限与聚焦环。

> 契约源：`lh-ui-core/specs/input.json` ·
> 黄金用例：`lh-ui-core/cases/input.json`（8 条，已翻译为 XCTest，macOS 宿主即可运行）

## 基本形态

高度与 Button 对齐（三档 `input.height` 令牌），聚焦时描边换 `color.focus` 并加宽为聚焦环。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="请输入内容" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷" /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "请输入内容") { newValue in
  // onValueChange
}
```

## 尺寸

三档尺寸映射到 `input.height` / `paddingHorizontal` / `fontSize` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="小号" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="中号" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="大号" /></span></div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 密码与清除

`type: .password` 落地为 `SecureField`（测试 `testPasswordTypeIsSecure`）；
`clearable` 在有值时显示清除按钮，点击触发 `onValueChange("")`（黄金用例 `clearable-emits-empty-value`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 扩展</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="禁用态" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `value` | 输入内容（受控双向绑定） | `String` | — |
| `placeholder` | 占位提示文字 | `String` | `""` |
| `type` | 输入类型（明文 / 密文） | `LhInputType` | `.text` |
| `size` | 输入框尺寸，映射到尺寸令牌 | `LhInputSize` | `.medium` |
| `disabled` | 是否禁用（不触发任何回调） | `Bool` | `false` |
| `readonly` | 是否只读（不触发 onValueChange，保留聚焦样式） | `Bool` | `false` |
| `clearable` | 是否显示清除按钮 | `Bool` | `false` |
| `maxlength` | 最大字数（超出截断，黄金用例 `maxlength-truncates-input`） | `Int?` | `nil` |
| `onValueChange` | 内容变化回调，payload 为新值 | `((String) -> Void)?` | `nil` |
| `onFocus` | 聚焦回调 | `(() -> Void)?` | `nil` |
| `onBlur` | 失焦回调 | `(() -> Void)?` | `nil` |

### LhInputSize

| 值 | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small`（32pt） | `input.paddingHorizontal.small`（12pt） | `input.fontSize.small`（13pt） |
| `.medium` | `input.height.medium`（40pt） | `input.paddingHorizontal.medium`（16pt） | `input.fontSize.medium`（14pt） |
| `.large` | `input.height.large`（48pt） | `input.paddingHorizontal.large`（20pt） | `input.fontSize.large`（16pt） |

### LhInputType

| 值 | 落地 |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### 颜色

| 状态 | 描边 | 文字 / 占位 |
| --- | --- | --- |
| 默认 | `color.border.base`（`input.borderWidth`） | `color.text.primary` / `color.text.placeholder` |
| 聚焦 | `color.focus`（`input.focusRingWidth`） | 同上 |
| 禁用 | `color.disabled.border` | `color.disabled.text` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `input.height.{small,medium,large}` | 三档高度 |
| `input.paddingHorizontal.{small,medium,large}` | 三档横向内边距 |
| `input.fontSize.{small,medium,large}` | 三档字号 |
| `input.borderRadius` / `input.borderWidth` | 圆角（跟随 `radius.small`）与描边宽度 |
| `input.focusRingWidth` | 聚焦环宽度 |
| `input.clearIconSize` | 清除按钮图标尺寸 |
| `color.focus` | 聚焦描边色 |
| `color.text.{primary,placeholder,disabled}` | 文字与占位色 |
| `color.border.base` / `color.disabled.border` | 描边色 |
| `color.background.default` / `color.disabled.bg` | 底色 |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 输入触发 `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | 清除触发 `onValueChange("")` | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | 禁用态不触发 onValueChange | `testDisabledBlocksInput` |
| `readonly-blocks-input` | 只读态不触发 onValueChange | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | 占位文字取占位色令牌 | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | 聚焦消费 focus 令牌并触发 onFocus | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | 小号消费 small 尺寸令牌 | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | 超出字数截断 | `testMaxlengthTruncatesInput` |

另有专项：`testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`。

```bash
swift test --filter LhInputTests    # macOS 宿主即可跑，无需模拟器
```
