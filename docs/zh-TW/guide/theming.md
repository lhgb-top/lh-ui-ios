# 主題與暗色

## 令牌模型

原生血脈的令牌真源在 `lh-ui-core/tokens/*.json`，codegen 生成 iOS 產物：

| 產物 | 內容 | 暗色形態 |
| --- | --- | --- |
| `LhTokens` | 明色全量：Button 尺寸、Color 色板、Motion、Radius、Shadow、Spacing、Typography、ZIndex | — |
| `LhDarkTokens` | 僅 `Color` 子物件（**並列物件**模型） | 暗色只覆蓋顏色，尺寸/動效/圓角暗色不變 |
| `LhShadow` | SwiftUI 陰影載體結構（color/opacity/radius/x/y） | — |

> 這與 android / harmony / windows 一致（並列物件），與 docs 端（淺合併 JSON）形態不同。
> 主題層據此設計：`LhColors` 只承載顏色，尺寸由元件直接取 `LhTokens`。

## LhColors

`LightLhColors` / `DarkLhColors` 把生成的兩個 enum 平鋪為一份 `Equatable` 值類型：

```swift
public struct LhColors: Equatable {
  public let primary: Color
  public let onPrimary: Color
  // ... 全部語義色
}

public let LightLhColors = LhColors(primary: LhTokens.Color.Primary.`default`, /* ... */)
public let DarkLhColors = LhColors(primary: LhDarkTokens.Color.Primary.`default`, /* ... */)
```

建構器公開：單測可直接建構色板做斷言；應用側應透過 `LhTheme` 消費。

## LhTheme

```swift
LhTheme(isDark: true) {
  // Environment(\.lhColors) 注入 DarkLhColors，內部元件自動消費
}
```

無 `LhTheme` 包裹時 Environment 鍵的 defaultValue 回退 `LightLhColors`（缺省即明色）。

## 暗色預計算（重要）

web 血脈的暗色用 CSS `color-mix()` 動態求值，原生無 CSS 級聯，故 core 已把暗色運算式
**預計算為字面量**（如 `rgba(61,100,158,0.25)`、`#B1C1D8`）。後果（總綱 R-n6）：

> **改預設主色時，暗色預計算值不會自動跟隨**，必須重新人工計算並更新
> `lh-ui-core/tokens/color-dark.json`，同步重新整理《設計語言基線》。

## iOS 端特有約定

- **時長單位是秒**：`LhTokens.Motion.Duration.base = 0.300`（android/harmony 是毫秒、C 是毫秒），
  SwiftUI 動畫 API 直接消費，無需換算。
- **色值表達**：生成產物用歸一化 RGB（`SwiftUI.Color(red:green:blue:)` + `.opacity()`），
  不用 hex 字串。
- **圓角**：`Radius.circle` 是 0.5 分數，端側取 `min(寬,高)/2` 換算，不能當 pt 用。
- **陰影**：SwiftUI 不支援擴展量（spread），生成的 `LhShadow` 已忽略 spread 並加註。
- **字體**：`Typography.fontFamily` 是字體棧字串，端側取首個可用族；國風襯線是預設調性。

## 令牌速查

完整令牌表（明/暗/說明）見 core 倉 `dist/docs/tokens.md`（`pnpm codegen` 後生成）。
元件級令牌對應見 [Button 令牌對照](/zh-TW/components/button#令牌對照)。
