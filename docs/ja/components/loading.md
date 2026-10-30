# Loading ローディング

読み込みインジケーター。SwiftUI 端では自描画のリング（`Circle().trim` + 回転アニメーション）で、1 周の時間は `motion.duration.base`（秒）に従います。

> 契約ソース：`lh-ui-core/specs/loading.json` ·
> ゴールデンケース：`lh-ui-core/cases/loading.json`（5 件、XCTest に翻訳済み、macOS ホストだけで実行可能）

## 色調

5 種類の色調はセマンティックカラートークンを取ります。デフォルトは `.primary` です。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading 色調</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--success"></span>
      <span class="sim-loading sim-loading--warning"></span>
    </div>
    <div class="sim-row">
      <span class="sim-loading sim-loading--danger"></span>
      <span class="sim-loading sim-loading--info"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

```swift
LhLoading(tone: .success)
```

## サイズ

3 段階のサイズは `loading.size` トークンに対応付けられ、枠線の太さは `loading.strokeWidth` を取ります。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading サイズ</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML シミュレーションプレビュー（iOS / SwiftUI の外観）であり、実機でのレンダリングではありません</p>

## 静止フレーム

`animating: false` は回転を凍結します（ゴールデンケース `render-emits-ring-command` は静止リングの描画パラメータをアサートします）。
スクリーンショットテストやドキュメントの静止フレーム用途です。

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### プロパティ

| プロパティ | 説明 | 型 | デフォルト値 |
| --- | --- | --- | --- |
| `lhSize` | リングのサイズ。サイズトークンに対応付け | `LhLoadingSize` | `.medium` |
| `tone` | リングの色調。セマンティックカラートークンに対応付け | `LhLoadingTone` | `.primary` |
| `animating` | 回転するかどうか（`false` で静止フレームに凍結） | `Bool` | `true` |

### LhLoadingSize

| 値 | サイズ |
| --- | --- |
| `.small` | `loading.size.small`（16pt） |
| `.medium` | `loading.size.medium`（20pt） |
| `.large` | `loading.size.large`（24pt） |

### LhLoadingTone

| 値 | 色 |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## トークン対応表

| トークン | 用途 |
| --- | --- |
| `loading.size.{small,medium,large}` | 3 段階のサイズ |
| `loading.strokeWidth` | リングの枠線の太さ |
| `color.{primary,success,warning,danger,info}.default` | 5 種類の色調 |
| `motion.duration.base` | 1 周のアニメーション時間（iOS 端では秒） |

## ゴールデンケース対応表

| case id | アサーション | ローカルテスト |
| --- | --- | --- |
| `medium-size-uses-medium-token` | 中サイズは medium サイズトークンを取る | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | 大サイズは large サイズトークンを取る | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | primary 色調は primary カラートークンを取る | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | success 色調は success カラートークンを取る | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | リングの描画が strokeWidth トークンを消費 | `testRingUsesStrokeWidthToken` |

さらにダーク関連：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`。

```bash
swift test --filter LhLoadingTests    # macOS ホストだけで実行可能、シミュレーター不要
```
