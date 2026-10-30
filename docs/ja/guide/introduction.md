# 紹介

**lh-ui-ios** は lh-ui ファミリーの**ネイティブ血脈**における iOS 端の実装です：**Swift + SwiftUI** ベースの UI コンポーネントライブラリです。

## ファミリー内の位置

```
                        ┌── Web 血脈：share（TS core + SCSS）→ plus / vue2 / react / uniapp
lh-ui ファミリー（同一ブランド）─────┤
                        └── ネイティブ血脈：core（JSON トークン + 契約 + codegen）→ android / ios / harmony / windows
                                                                    ↑ 本リポジトリ
```

- **ビルド時の中心**：`lh-ui-core` はネイティブ血脈のトークン真源（`tokens/*.json`）、コンポーネント契約（`specs/`）、ゴールデンケース（`cases/`）、codegen ツールです。Swift のトークンスケルトン（`LhTokens` / `LhDarkTokens` / `LhShadow`）を生成しますが、**UI 実装は一切生成しません**。
- **本リポジトリの役割**：SwiftUI View のハンドライト、テーマの組み込み（Environment 注入）、props の列挙型とデフォルト値のバインディング、ゴールデンケースの XCTest への翻訳。
- **Web 血脈とは相互に独立**：`@lh-ui/share` に依存せず、リリース順の制約もありません。視覚的な一致性は『デザイン言語ベースライン』によって人の手で合わせます。

## デザイン言語

中華風テーマ：メインカラーは青花瓷ブルー（`#2B4C7C`）、背景は宣紙白（`#FAF6F0`）、成功は松花绿、警告は藤黄、危険は朱砂。セリフフォントスタック（Noto Serif SC → STSong → SimSun）。すべての視覚値がトークンであり、コンポーネントにリテラルは一切出現しません。

## なぜ SwiftUI か

- プラットフォーム第一級の宣言的 UI で、Compose / ArkUI とメンタルモデルが同型。クロスプラットフォームの契約を合わせやすい
- SPM でワンステップ導入。JS ランタイムもブリッジ層もない
- `#Preview` がドキュメント、`View` がコンポーネント、Web 血脈の SFC 開発体験と対称

## 現在の状態

- **button の全リンク工程のプロトタイプが完成**（トークン消費 + resolveAppearance による外観解決 + SwiftUI View + XCTest + `#Preview` + ドキュメントサイト）
- P0 の残り 13 コンポーネント（icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar）は同じパラダイムで順次追加予定
