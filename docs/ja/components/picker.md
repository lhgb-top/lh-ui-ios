# Picker ピッカー

宣言型のボトムホイールピッカー。`@Binding var visible` で表示を制御し、`@Binding var value` が選択中のインデックスです。
ホイールは自描画（`DragGesture` + 離したときのスナップ）で、システムコントロールへの依存はありません。

> 契約ソース：`lh-ui-core/specs/picker.json` ·
> ゴールデンケース：`lh-ui-core/cases/picker.json`（8 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 基本形

底部からポップアップします。上部にツールバー（キャンセル / タイトル / 確認）、中央にホイールと 2 本のインジケータ線があります。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker 基本</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">ピッカー</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">キャンセル</span>
      <span class="sim-picker__title">選択</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">確認</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">オプション1</div>
      <div class="sim-picker__item sim-picker__item--selected">オプション2</div>
      <div class="sim-picker__item">オプション3</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["オプション1", "オプション2", "オプション3"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "選択"
)
```

## ホイール操作

- ドラッグで全体のオフセットを変え、離すと最も近い候補にスナップします（アニメーション時間は `motion.duration.base`）。
  選択インデックスが変化したとき `onValueChange` を発火します（ゴールデンケース `scroll-emits-onvaluechange`）。
- インジケータ線の間隔 = `picker.itemHeight` で、選択中の項目は常に 2 本の線の中央に来ます。

## コールバックと境界処理

- 「確認」が `onConfirm`（payload は現在のインデックス）と `onClose` を発火します（`confirm-also-emits-onclose`）。
- 「キャンセル」が `onCancel` を発火します。
- `value` が範囲外のとき端側で clamp します。負数は 0 に（`clamp-negative-value-to-zero`）、上限超えは末項に
  （`clamp-overflow-value-to-last`）。候補リストが空のときインデックスは常に 0 です。
- `visible = false` のとき描画コマンドを一切発行しません（`hidden-not-rendered`）。

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "選択",
  confirmText: "確認",
  cancelText: "キャンセル",
  onValueChange: { newIndex in
    // スナップ時のコールバック
  },
  onConfirm: { newIndex in
    // 確認コールバック（payload は現在のインデックス）
  },
  onCancel: {
    // キャンセルコールバック
  }
)
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `visible` | 表示するかどうか（コントロールドな双方向バインディング） | `Bool` | — |
| `options` | 候補文字列の配列（1 列） | `[String]` | — |
| `value` | 選択中のインデックス（コントロールドな双方向バインディング、範囲外は自動 clamp） | `Int` | — |
| `title` | ツールバーのタイトル | `String` | `""` |
| `confirmText` | 確認ボタンのテキスト。`nil`（省略時）は言語パックを使用 | `String?` | 言語パック（簡体字中国語 `"确认"`） |
| `cancelText` | キャンセルボタンのテキスト。`nil`（省略時）は言語パックを使用 | `String?` | 言語パック（簡体字中国語 `"取消"`） |
| `onValueChange` | スナップ時のコールバック。payload は新しいインデックス | `((Int) -> Void)?` | `nil` |
| `onConfirm` | 確認コールバック。payload は現在のインデックス | `((Int) -> Void)?` | `nil` |
| `onCancel` | キャンセルコールバック | `(() -> Void)?` | `nil` |
| `onClose` | 閉じるコールバック（確認 / キャンセルどちらでも発火） | `(() -> Void)?` | `nil` |

### 色

| 領域 | 色 |
| --- | --- |
| パネル底 | `color.background.default` |
| マスク | `color.background.overlay` |
| キャンセルボタン / 候補文字 | `color.text.primary` |
| タイトル / 確認ボタン | `color.primary.default` |
| インジケータ線 | `color.border.lighter`（幅は `cell.borderWidth`） |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `picker.height` | パネルの高さ（260pt） |
| `picker.toolbarHeight` | ツールバーの高さ（44pt） |
| `picker.itemHeight` | 1 項目の高さ（ホイールとインジケータ線の間隔を決定） |
| `picker.itemFontSize` | 候補とツールバーのフォントサイズ |
| `picker.borderRadius` | 上部の角丸 |
| `color.background.overlay` / `color.background.default` | マスクとパネル底色 |
| `color.border.lighter` / `cell.borderWidth` | インジケータ線の色と幅 |
| `color.primary.default` | 確認ボタンと選択項目の文字色 |
| `zIndex.{modalBackdrop,modal}` | マスクとパネルの重ね順 |
| `motion.duration.base` | スナップアニメーションの時間（iOS 端では秒） |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | 確認で `onConfirm(1)` を発火 | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | 確認と同時に onClose を発火 | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | キャンセルで onCancel を発火 | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | スナップで `onValueChange(2)` を発火 | View 層 `DragGesture.onEnded`（ジェスチャのアサーションにはシミュレーターが必要） |
| `clamp-negative-value-to-zero` | 負のインデックスを 0 に clamp | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | 範囲外インデックスを末項に clamp | `testClampOverflowValueToLast` |
| `title-renders-text` | タイトルが正しく描画される | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | 非表示のとき描画しない | `testHiddenNotRendered` |

さらに関連テスト：`testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`。

```bash
swift test --filter LhPickerTests    # macOS ホストだけで実行可能、シミュレーター不要
```
