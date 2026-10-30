# 介紹

**lh-ui-ios** 是 lh-ui 家族**原生血脈**的 iOS 端實現：基於 **Swift + SwiftUI** 的 UI 元件庫。

## 家族中的位置

```
                        ┌── web 血脈：share（TS core + SCSS）→ plus / vue2 / react / uniapp
lh-ui 家族（同品牌）─────┤
                        └── 原生血脈：core（JSON 令牌 + 契約 + codegen）→ android / ios / harmony / windows
                                                                    ↑ 本倉
```

- **構建期中心**：`lh-ui-core` 是原生血脈的令牌真源（`tokens/*.json`）、元件契約（`specs/`）、黃金用例（`cases/`）與 codegen 工具。它生成 Swift 令牌骨架（`LhTokens` / `LhDarkTokens` / `LhShadow`），**不生成任何 UI 實現**。
- **本倉職責**：手寫 SwiftUI View、主題接入（Environment 注入）、props 列舉與預設值綁定、把黃金用例翻譯為 XCTest。
- **與 web 血脈互相獨立**：不依賴 `@lh-ui/share`，發版互不約束。視覺一致性靠《設計語言基線》人工對齊。

## 設計語言

國風主題：青花瓷藍主色（`#2B4C7C`）、宣紙白底（`#FAF6F0`）、松花綠成功、藤黃警告、朱砂危險，襯線字體棧（Noto Serif SC → STSong → SimSun）。所有視覺值都是令牌，元件不出現任何字面量。

## 為什麼是 SwiftUI

- 平台一等公民的宣告式 UI，與 Compose / ArkUI 心智同構，跨端契約容易對齊
- SPM 一鍵接入，無 JS 執行時、無橋接層
- `#Preview` 即文件，`View` 即元件，與 web 血脈的 SFC 開發體驗對稱

## 當前狀態

- **button 全鏈路打樣已交付**（令牌消費 + resolveAppearance 外觀解析 + SwiftUI View + XCTest + `#Preview` + 文件站）
- P0 其餘 13 個元件（icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar）按同範式後續補齊
