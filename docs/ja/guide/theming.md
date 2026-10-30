# テーマとダークモード

## トークンモデル

ネイティブ血脈のトークン真源は `lh-ui-core/tokens/*.json` で、codegen が iOS 向け成果物を生成します：

| 成果物 | 内容 | ダーク形態 |
| --- | --- | --- |
| `LhTokens` | ライト全量：Button のサイズ、Color パレット、Motion、Radius、Shadow、Spacing、Typography、ZIndex | — |
| `LhDarkTokens` | `Color` サブオブジェクトのみ（**並列オブジェクト**モデル） | ダークは色のみ上書き、サイズ/モーション/角丸はダークでも変化なし |
| `LhShadow` | SwiftUI のシャドウ用構造体（color/opacity/radius/x/y） | — |

> これは android / harmony / windows と一致します（並列オブジェクト）が、docs 端（JSON の浅いマージ）とは形態が異なります。
> テーマレイヤーはこれに基づいて設計されています：`LhColors` は色のみを担い、サイズはコンポーネントが直接 `LhTokens` から取得します。

## LhColors

`LightLhColors` / `DarkLhColors` は、生成された 2 つの enum を平坦化して 1 つの `Equatable` な値型にします：

```swift
public struct LhColors: Equatable {
  public let primary: Color
  public let onPrimary: Color
  // ... 全セマンティックカラー
}

public let LightLhColors = LhColors(primary: LhTokens.Color.Primary.`default`, /* ... */)
public let DarkLhColors = LhColors(primary: LhDarkTokens.Color.Primary.`default`, /* ... */)
```

イニシャライザは公開されています：単体テストでは直接パレットを構築してアサーションできます。アプリ側では `LhTheme` 経由で消費してください。

## LhTheme

```swift
LhTheme(isDark: true) {
  // Environment(\.lhColors) が DarkLhColors を注入し、内側のコンポーネントが自動的に消費
}
```

`LhTheme` でラップしない場合、Environment キーの defaultValue は `LightLhColors` にフォールバックします（デフォルトはライト）。

## ダークの事前計算（重要）

Web 血脈のダークは CSS の `color-mix()` で動的に評価しますが、ネイティブには CSS カスケードがないため、core はダークの式をすでにリテラルへ事前計算しています（例：`rgba(61,100,158,0.25)`、`#B1C1D8`）。その影響（マスタープラン R-n6）：

> **プリセットのメインカラーを変更する場合、ダークの事前計算値は自動では追従しません。**手動で再計算して
> `lh-ui-core/tokens/color-dark.json` を更新し、『デザイン言語ベースライン』も同期して更新してください。

## iOS 固有の取り決め

- **時間の単位は秒**：`LhTokens.Motion.Duration.base = 0.300`（android/harmony はミリ秒、C はミリ秒）。
  SwiftUI のアニメーション API がそのまま消費するため、単位の変換は不要です。
- **色値の表現**：生成成果物は正規化 RGB（`SwiftUI.Color(red:green:blue:)` + `.opacity()`）を使用し、
  hex 文字列は使いません。
- **角丸**：`Radius.circle` は 0.5 の分数で、端側で `min(幅, 高さ) / 2` に換算します。pt として扱わないでください。
- **シャドウ**：SwiftUI は拡散量（spread）をサポートしないため、生成される `LhShadow` では spread を無視してコメントを付けてあります。
- **フォント**：`Typography.fontFamily` はフォントスタック文字列で、端側で最初に利用可能なファミリーを採用します。
  中華風セリフがデフォルトの調性です。

## トークン早見表

完全なトークン表（ライト/ダーク/説明）は core リポジトリの `dist/docs/tokens.md` を参照してください（`pnpm codegen` の実行後に生成）。
コンポーネント別のトークンマッピングは [Button のトークン対応表](/ja/components/button#トークン対応表) を参照してください。
