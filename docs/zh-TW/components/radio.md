# Radio 單選鈕

受控單選鈕。`@Binding var checked` 表示「該項是否選中」，通常配合分組使用；同一組內只能有一項為 `true`。

> 契約源：`lh-ui-core/specs/radio.json` ·
> 黃金用例：`lh-ui-core/cases/radio.json`（6 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 狀態

選中態為描邊主色圓環 + 實心主色圓點；未選中為描邊空環。圓點直徑為尺寸乘 `radio.dotScale`（50%）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 狀態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>未選中</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>已選中</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>停用選中</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>停用未選中</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷") { _ in
  picked = "blue"
}
```

## 尺寸

三檔尺寸對應到 `radio.size` 令牌；圓環描邊取 `radio.ringWidth`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Radio 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>小號</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>中號</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>大號</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 點選 gate

已選中再點選保持選中且不觸發 `onChange`（黃金用例 `tap-checked-keeps-checked`）；
停用態不觸發（`disabled-blocks-change`）。分組容器留待後續版本。

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `checked` | 該項是否選中（受控雙向綁定） | `Bool` | — |
| `value` | 該項代表的值（與 `checked` 配合實現單選組） | `String` | `""` |
| `disabled` | 是否停用（不觸發 onChange） | `Bool` | `false` |
| `lhSize` | 單選鈕尺寸，對應到尺寸令牌 | `LhRadioSize` | `.medium` |
| `label` | 文字標籤 | `String` | `""` |
| `onChange` | 選中變化回呼，payload 為新值 | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| 值 | 環尺寸 | 圓點直徑 |
| --- | --- | --- |
| `.small` | `radio.size.small`（16pt） | 尺寸 × `radio.dotScale`（8pt） |
| `.medium` | `radio.size.medium`（20pt） | 尺寸 × `radio.dotScale`（10pt） |
| `.large` | `radio.size.large`（24pt） | 尺寸 × `radio.dotScale`（12pt） |

### 顏色

| 狀態 | 環描邊 | 圓點 |
| --- | --- | --- |
| 未選中 | `color.border.base`（`radio.ringWidth`） | — |
| 選中 | `color.primary.default` | `color.primary.default` |
| 停用 | `color.disabled.border` | `color.disabled.text` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `radio.size.{small,medium,large}` | 三檔環尺寸 |
| `radio.dotScale` | 圓點相對環尺寸的比例（50%） |
| `radio.ringWidth` | 環描邊寬度 |
| `radio.gap` | 環與文字間距（跟隨 `spacing.sm`） |
| `color.primary.default` | 選中態描邊與圓點色 |
| `color.border.base` | 未選中描邊色 |
| `color.disabled.{border,text}` | 停用態描邊與圓點色 |
| `color.text.{primary,disabled}` | 標籤文字色 |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | 未選中點選觸發 `onChange(true)` | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | 已選中點選保持選中且不回呼 | `testCheckedShowsDot` |
| `disabled-blocks-change` | 停用態不觸發 onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | 選中態消費主色令牌 | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | 未選中消費描邊令牌 | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | 小號消費 small 尺寸令牌 | `testSmallSizeUsesSmallToken` |

另有專項：`testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`。

```bash
swift test --filter LhRadioTests    # macOS 宿主即可執行，無需模擬器
```
