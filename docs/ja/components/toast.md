# Toast 通知

宣言型の軽量通知。`@Binding var visible` で表示を制御し、時間が来ると自動的に非表示になります。暗い底色は `color.ink` トークンを取ります。

> 契約ソース：`lh-ui-core/specs/toast.json` ·
> ゴールデンケース：`lh-ui-core/cases/toast.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## タイプ

デフォルトタイプはアイコンなしです。それ以外のタイプは文字の左側にセマンティック色の円点を表示します。暗い底色 ＋ 白字で、コントラストは `color.ink` で保証されます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast タイプ</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">デフォルト</button></div>
  </div>
  <div class="sim-toast">保存しました</div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast セマンティック</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">成功</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>操作成功</div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "保存しました", type: .success)
```

## 配置

3 種類の配置：`top`（上部）、`center`（中央、デフォルト）、`bottom`（下部）。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast 配置</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">bottom 配置</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>下部の通知</div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## 自動非表示

`visible` が `true` になると `.task` のタイマーを起動し、`duration` ミリ秒後に自動的に `false` に戻して `onClose` を発火します
（ゴールデンケース `auto-hides-after-duration`）。時間に達していないうちは表示を維持しコールバックしません
（`tick-before-duration-keeps-visible`）。外部から手動で `false` にしてもコールバックしません（`hide-is-silent`）。

::: tip 時間の単位
トークン `toast.duration` はミリ秒（2000）ですが、SwiftUI の `Task.sleep` は秒を必要とするため、
端側で `Double(duration) / 1000` の換算を行います（`LhToastStyle` 参照）。
:::

```swift
LhToast(visible: $visible, text: "操作成功", type: .success, duration: 2000) {
  // onClose（自動非表示のときのみ発火）
}
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `visible` | 表示するかどうか（コントロールドな双方向バインディング、時間が来ると自動的に false に戻る） | `Bool` | — |
| `text` | 通知文字 | `String` | — |
| `type` | 通知タイプ。円点の有無と色を決定 | `LhToastType` | `.default` |
| `lhPosition` | 表示位置 | `LhToastPosition` | `.center` |
| `duration` | 表示時間（ミリ秒） | `Int` | `2000`（`toast.duration` トークンから取得） |
| `onClose` | 自動非表示のコールバック（外部からの手動非表示では発火しない） | `(() -> Void)?` | `nil` |

### LhToastType

| 値 | 円点の色 |
| --- | --- |
| `.default` | 円点なし |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| 値 | 配置 |
| --- | --- |
| `.top` | 上部（余白 `spacing.xl`） |
| `.center` | 中央 |
| `.bottom` | 下部（余白 `spacing.xl`） |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | パディング |
| `toast.fontSize` | 通知文字のフォントサイズ |
| `toast.borderRadius` | 角丸（`radius.small` に追従） |
| `toast.gap` | 円点と文字の間隔 |
| `toast.duration` | デフォルトの表示時間（ミリ秒） |
| `color.ink` | 暗い底色（ダークモードでは専用の上書きがあり、ページの底色と階層を分ける） |
| `color.onPrimary` | 白字 |
| `color.{success,warning,danger,info}.default` | 円点のセマンティック色 |
| `zIndex.toast` | 重ね順 |
| `spacing.xl` | 上部 / 下部配置の余白 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `show-makes-visible` | 表示すれば描画される | `testShowMakesVisible` |
| `auto-hides-after-duration` | 時間が来たら自動非表示になり onClose を発火 | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | 時間に達していないうちは表示を維持 | `testVisibleDuringDuration` |
| `hide-is-silent` | 外部からの手動非表示はコールバックしない | `testHideIsSilent` |
| `success-type-uses-success-token` | success タイプが success 色と ink トークンを消費 | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | 非表示のとき描画コマンドは空 | `testHiddenNotRendered` |

さらに関連テスト：`testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`。

```bash
swift test --filter LhToastTests    # macOS ホストだけで実行可能、シミュレーター不要
```
