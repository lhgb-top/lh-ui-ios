# Input 輸入框

受控單行輸入框。`@Binding var value` 雙向綁定，支援明暗密文、清除按鈕、字數上限與聚焦環。

> 契約源：`lh-ui-core/specs/input.json` ·
> 黃金用例：`lh-ui-core/cases/input.json`（8 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 基本形態

高度與 Button 對齊（三檔 `input.height` 令牌），聚焦時描邊換 `color.focus` 並加寬為聚焦環。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="請輸入內容" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷" /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "請輸入內容") { newValue in
  // onValueChange
}
```

## 尺寸

三檔尺寸對應到 `input.height` / `paddingHorizontal` / `fontSize` 令牌。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="小號" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="中號" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="大號" /></span></div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 密碼與清除

`type: .password` 落地為 `SecureField`（測試 `testPasswordTypeIsSecure`）；
`clearable` 在有值時顯示清除按鈕，點選觸發 `onValueChange("")`（黃金用例 `clearable-emits-empty-value`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input 擴充</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="停用態" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `value` | 輸入內容（受控雙向綁定） | `String` | — |
| `placeholder` | 佔位提示文字 | `String` | `""` |
| `type` | 輸入類型（明文 / 密文） | `LhInputType` | `.text` |
| `lhSize` | 輸入框尺寸，對應到尺寸令牌 | `LhInputSize` | `.medium` |
| `disabled` | 是否停用（不觸發任何回呼） | `Bool` | `false` |
| `readonly` | 是否唯讀（不觸發 onValueChange，保留聚焦樣式） | `Bool` | `false` |
| `clearable` | 是否顯示清除按鈕 | `Bool` | `false` |
| `maxlength` | 最大字數（超出截斷，黃金用例 `maxlength-truncates-input`） | `Int?` | `nil` |
| `onValueChange` | 內容變化回呼，payload 為新值 | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | 聚焦回呼 | `(() -> Void)?` | `nil` |
| `lhOnBlur` | 失焦回呼 | `(() -> Void)?` | `nil` |

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

### 顏色

| 狀態 | 描邊 | 文字 / 佔位 |
| --- | --- | --- |
| 預設 | `color.border.base`（`input.borderWidth`） | `color.text.primary` / `color.text.placeholder` |
| 聚焦 | `color.focus`（`input.focusRingWidth`） | 同上 |
| 停用 | `color.disabled.border` | `color.disabled.text` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `input.height.{small,medium,large}` | 三檔高度 |
| `input.paddingHorizontal.{small,medium,large}` | 三檔橫向內邊距 |
| `input.fontSize.{small,medium,large}` | 三檔字號 |
| `input.borderRadius` / `input.borderWidth` | 圓角（跟隨 `radius.small`）與描邊寬度 |
| `input.focusRingWidth` | 聚焦環寬度 |
| `input.clearIconSize` | 清除按鈕圖示尺寸 |
| `color.focus` | 聚焦描邊色 |
| `color.text.{primary,placeholder,disabled}` | 文字與佔位色 |
| `color.border.base` / `color.disabled.border` | 描邊色 |
| `color.background.default` / `color.disabled.bg` | 底色 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `input-emits-onvaluechange` | 輸入觸發 `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | 清除觸發 `onValueChange("")` | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | 停用態不觸發 onValueChange | `testDisabledBlocksInput` |
| `readonly-blocks-input` | 唯讀態不觸發 onValueChange | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | 佔位文字取佔位色令牌 | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | 聚焦消費 focus 令牌並觸發 lhOnFocus | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | 小號消費 small 尺寸令牌 | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | 超出字數截斷 | `testMaxlengthTruncatesInput` |

另有專項：`testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`。

```bash
swift test --filter LhInputTests    # macOS 宿主即可執行，無需模擬器
```
