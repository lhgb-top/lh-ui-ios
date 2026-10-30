# Switch スイッチ

コントロールドなスイッチ。`@Binding var checked` で双方向バインディングし、トラックは 2:1、円点の直径 = 高さ − 2 × `switch.gap` です。

> 契約ソース：`lh-ui-core/specs/switch.json` ·
> ゴールデンケース：`lh-ui-core/cases/switch.json`（6 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 状態

オンのときトラックは primary 色、円点は右に移動します。オフのときトラックは枠線色です。`loading` 状態ではトラック内に小型インジケータを表示し、切り替えに反応しません。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch 状態</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row">
      <span class="sim-switch sim-switch--on sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## サイズ

3 段階のサイズは `switch.width` / `switch.height` トークンに対応付けられ、角丸は高さに合わせて自動的にトラックの半径になります。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## 読み込み中

`loading = true` のときトラック内に `LhLoading(lhSize: .small, tone: .primary)` を内蔵し、タップはゲートに遮断されます
（ゴールデンケース `loading-blocks-change`）。

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `checked` | スイッチの状態（コントロールドな双方向バインディング） | `Bool` | — |
| `disabled` | 無効にするかどうか（onChange を発火しない） | `Bool` | `false` |
| `loading` | 読み込み中かどうか（インジケータを内蔵、onChange を発火しない） | `Bool` | `false` |
| `lhSize` | スイッチのサイズ。サイズトークンに対応付け | `LhSwitchSize` | `.medium` |
| `onChange` | 状態変化のコールバック。payload は新しい値 | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| 値 | width | height | 円点の直径 |
| --- | --- | --- | --- |
| `.small` | `switch.width.small`（36pt） | `switch.height.small`（20pt） | height − 2 × `switch.gap`（16pt） |
| `.medium` | `switch.width.medium`（44pt） | `switch.height.medium`（24pt） | height − 2 × `switch.gap`（20pt） |
| `.large` | `switch.width.large`（52pt） | `switch.height.large`（28pt） | height − 2 × `switch.gap`（24pt） |

### 色

| 状態 | トラック | 円点 |
| --- | --- | --- |
| オフ | `color.border.base` | `color.onPrimary` |
| オン | `color.primary.default` | `color.onPrimary` |
| 無効 | `color.disabled.bg` | `color.disabled.text` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `switch.width.{small,medium,large}` | 3 段階のトラック幅 |
| `switch.height.{small,medium,large}` | 3 段階のトラック高さ |
| `switch.gap` | 円点とトラックの内側の間隔（円点の直径を決定） |
| `color.primary.default` | オンのトラック色 |
| `color.border.base` | オフのトラック色 |
| `color.onPrimary` | 円点の色 |
| `color.disabled.{bg,text}` | 無効状態の 2 色 |
| `motion.duration.base` | 円点のスライドアニメーション時間（iOS 端では秒） |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | タップでオンになり `onChange(true)` をコールバック | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | オン状態のタップでオフに | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | 無効状態は onChange を発火しない | `testDisabledBlocksChange` |
| `loading-blocks-change` | 読み込み中は onChange を発火しない | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | オンが primary カラートークンを消費し、枠線トークンは消費しない | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | オフが枠線トークンを消費 | `testUncheckedUsesBorderToken` |

さらに関連テスト：`testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`。

```bash
swift test --filter LhSwitchTests    # macOS ホストだけで実行可能、シミュレーター不要
```
