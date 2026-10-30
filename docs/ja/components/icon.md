# Icon アイコン

ベクターアイコン。論理名からプラットフォームのシステムシンボル（iOS では SF Symbol）へマッピングされ、サイズと色調はすべてトークン経由です。

> 契約ソース：`lh-ui-core/specs/icon.json` ·
> ゴールデンケース：`lh-ui-core/cases/icon.json`（5 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 色調

`tone` がアイコンの色を決定します。`default` は主要文字色に追従し、`regular` / `secondary` は対応する階層の文字色を取ります。それ以外はセマンティック色を取ります。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon 色調</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません。実機では SF Symbol のベクターが描画されます</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## サイズ

3 段階のサイズは `icon.size` トークンに対応付けられます。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icon サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## アイコン名のマッピング

`name` は Web 血脈と揃えた論理名で、端側では `LhIconMap.symbol(for:)` を経由して SF Symbol にマッピングされます。

| 論理名 | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

未登録の名前は描画されず（`nil` を返す）、クラッシュすることはありません。

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `name` | アイコンの論理名（`LhIconMap` で SF Symbol にマッピング） | `String` | — |
| `lhSize` | アイコンのサイズ。サイズトークンに対応付け | `LhIconSize` | `.medium` |
| `tone` | アイコンの色調。文字 / セマンティックカラートークンに対応付け | `LhIconTone` | `.default` |
| `lhOnClick` | タップ時のコールバック。未指定ならタップに反応しない | `(() -> Void)?` | `nil` |

### LhIconSize

| 値 | サイズ |
| --- | --- |
| `.small` | `icon.size.small`（16pt） |
| `.medium` | `icon.size.medium`（20pt） |
| `.large` | `icon.size.large`（24pt） |

### LhIconTone

| 値 | 色 |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `icon.size.{small,medium,large}` | 3 段階のサイズ |
| `color.text.{primary,regular,secondary}` | 文字色調 |
| `color.{primary,success,warning,danger,info}.default` | セマンティック色調 |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `click-emits-onclick` | タップで `lhOnClick` を 1 回発火 | View 層 `onTapGesture`（ジェスチャのアサーションにはシミュレーターが必要、#Preview 参照） |
| `default-tone-uses-text-primary` | デフォルト色調は主要文字色を取る | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | primary 色調は primary カラートークンを取る | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | 小サイズは small サイズトークンを取る | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | 描画コマンドは 1 件のみ発行 | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

さらにダーク関連：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`。

```bash
swift test --filter LhIconTests    # macOS ホストだけで実行可能、シミュレーター不要
```
