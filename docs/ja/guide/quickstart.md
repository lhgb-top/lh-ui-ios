# クイックスタート

## 最小例

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* タップを処理 */ },
        type: .primary,
        text: "メインボタン"
      )
    }
  }
}
```

`LhTheme` はテーマコンテナです。内側のすべての Lh コンポーネントは Environment を通じて自動的にトークンを消費します。ラップしない場合はライトカラーパレットにフォールバックします。

## タイプとサイズ

```swift
// 6 種類のタイプ
LhButton(lhOnClick: {}, text: "デフォルト")                // .default
LhButton(lhOnClick: {}, type: .primary, text: "メイン")
LhButton(lhOnClick: {}, type: .success, text: "成功")
LhButton(lhOnClick: {}, type: .warning, text: "警告")
LhButton(lhOnClick: {}, type: .danger, text: "危険")
LhButton(lhOnClick: {}, type: .info, text: "情報")

// 3 種類のサイズ
LhButton(lhOnClick: {}, lhSize: .small, text: "小型")
LhButton(lhOnClick: {}, lhSize: .medium, text: "中型")
LhButton(lhOnClick: {}, lhSize: .large, text: "大型")
```

## 状態

```swift
// 無効：タップに応答せず、無効状態のスタイルを表示
LhButton(lhOnClick: {}, disabled: true, text: "無効")

// 読み込み中：インジケーターを表示し、lhOnClick は発火しない
LhButton(lhOnClick: {}, loading: true, text: "読み込み中")

// 両方指定時：無効を優先（ゴールデンケース disabled-precedes-loading）
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "無効優先")
```

## アイコンと柄背景

```swift
// アイコン名はローカルのアイコン体系で解決される（SF Symbol へのマッピングは LhButtonStyle.icon(for:) を参照、未登録名は描画しない）
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "検索")

// 中華風の柄（color.decoration トークンを消費）
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "柄背景")
```

## ライト・ダークテーマ

```swift
LhTheme(isDark: isDark) {
  // 内側のすべてのコンポーネントが自動的にダークトークンに切り替わる（core が事前計算した値、ランタイムでの調色なし）
}
```

## コンポーネント例のプレビュー

ネイティブ UI はブラウザでリアルタイムにレンダリングできないため、本サイトではインラインの静的 HTML 製スマートフォンフレームシミュレーターで外観を示します：

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">デフォルトボタン</button>
      <button class="sim-btn sim-btn--primary">メインボタン</button>
      <button class="sim-btn sim-btn--success">成功</button>
      <button class="sim-btn sim-btn--warning">警告</button>
      <button class="sim-btn sim-btn--danger">危険</button>
      <button class="sim-btn sim-btn--info">情報</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">小型</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">大型</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">無効</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>読み込み中
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>検索</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">柄背景</button>
    </div>
  </div>
</div>
<p class="sim-note">iOS（SwiftUI）外観の HTML シミュレーションプレビューであり、実機レンダリングではありません。スタイル値はすべて core のトークンスナップショットから取得しており、実機と同じソース・同じ値です。実機の外観は <code>#Preview</code> とデバイスのスクリーンショットを基準にしてください。</p>

> シミュレーターのダーク表示はサイトと連動します：右上でテーマを切り替えると、スマートフォンフレーム内の色も変わります（ダークトークンは core が事前計算）。
