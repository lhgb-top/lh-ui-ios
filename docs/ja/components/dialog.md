# Dialog ダイアログ

宣言的モーダルダイアログです。`@Binding var visible` で表示/非表示を制御し、オーバーレイ ＋ 中央配置のパネル、ボタンは `LhButton` を再利用します。

> 契約ソース：`lh-ui-core/specs/dialog.json` ·
> ゴールデンケース：`lh-ui-core/cases/dialog.json`（8 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## タイプ

6 種類のタイプが確認ボタンのセマンティックカラーを決定します（`buttonType(for:)` が `LhButtonType` にマッピング）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog タイプ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">デフォルトダイアログ</button>
      <button class="sim-btn sim-btn--danger">危険ダイアログ</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">削除の確認</div>
    <div class="sim-dialog__content">この操作によりこのアイテムは完全に削除されます。続行しますか？</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">キャンセル</button>
      <button class="sim-btn sim-btn--danger">確認</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "削除の確認",
  content: "この操作によりこのアイテムは完全に削除されます。続行しますか？",
  type: .danger,
  confirmText: "確認",
  cancelText: "キャンセル"
)
```

## 表示/非表示とコールバック

- `visible = true` でオーバーレイとパネルを描画します。`visible = false` のときは描画コマンドを一切発行しません（ゴールデンケース `hidden-not-rendered`）。
- 「確認」をタップすると `onConfirm` と `onClose` が順に発火します（`confirm-also-emits-onclose`）。
- 「キャンセル」をタップすると `onCancel` が発火します。`visible` を `false` に戻すのはコンポーネント内部の責務です（`withAnimation` 内で行われます）。
- `closable = true` のとき、オーバーレイのタップでも `onClose` を発火します（`closable-overlay-emits-onclose`）。デフォルトでは閉じません（`not-closable-blocks-overlay-close`）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog はオーバーレイで閉じる</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">お知らせ</div>
    <div class="sim-dialog__content">オーバーレイをタップすると閉じます</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">キャンセル</button>
      <button class="sim-btn sim-btn--primary">確認</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `visible` | 表示するかどうか（コントロールドな双方向バインディング） | `Bool` | — |
| `title` | タイトル | `String` | `""` |
| `content` | 本文の内容 | `String` | `""` |
| `type` | ダイアログのタイプ。確認ボタンのセマンティックカラーを決定 | `LhDialogType` | `.default` |
| `confirmText` | 確認ボタンのテキスト | `String` | `"确认"` |
| `cancelText` | キャンセルボタンのテキスト | `String` | `"取消"` |
| `closable` | オーバーレイのタップで閉じられるかどうか | `Bool` | `false` |
| `onConfirm` | 確認のコールバック | `(() -> Void)?` | `nil` |
| `onCancel` | キャンセルのコールバック | `(() -> Void)?` | `nil` |
| `onClose` | 閉じる際のコールバック（オーバーレイのタップ / キャンセルボタン / 確認ボタンのいずれでも発火） | `(() -> Void)?` | `nil` |

### LhDialogType

| 値 | 確認ボタンのタイプ | 背景色 |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` ＋ 枠線 |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `dialog.width` | パネルの幅（320pt） |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | パネルのパディング |
| `dialog.borderRadius` | パネルの角丸 |
| `dialog.titleFontSize` / `dialog.contentFontSize` | タイトルと本文のフォントサイズ |
| `dialog.gap` | 各領域の垂直方向の間隔 |
| `color.background.overlay` | オーバーレイの色 |
| `color.background.default` | パネルの背景色 |
| `color.text.{primary,regular}` | タイトルと本文の色 |
| `shadow.base` | パネルのシャドウ（LhShadow 構造体） |
| `zIndex.{modalBackdrop,modal}` | オーバーレイとパネルの重なり順 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `confirm-emits-onconfirm` | 確認で onConfirm を発火 | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | キャンセルで onCancel を発火 | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | 確認で onClose も発火 | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | オーバーレイのタップで onClose を発火 | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | デフォルトではオーバーレイで閉じない | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | 非表示のときは描画しない | `testHiddenNotRendered` |
| `title-renders-text` | タイトルが正しく描画 | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | 危険タイプが危険色トークンを消費 | `testDangerTypeUsesDangerToken` |

さらに関連テスト：`testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`。

```bash
swift test --filter LhDialogTests    # macOS ホストだけで実行可能、シミュレーター不要
```
