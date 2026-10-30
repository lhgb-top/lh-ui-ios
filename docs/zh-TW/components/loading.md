# Loading 載入

載入指示器。SwiftUI 端為自繪圓環（`Circle().trim` + 旋轉動畫），時長走 `motion.duration.base`（秒）。

> 契約源：`lh-ui-core/specs/loading.json` ·
> 黃金用例：`lh-ui-core/cases/loading.json`（5 條，已翻譯為 XCTest，macOS 宿主即可執行）

## 色調

五種色調取語義色令牌，預設 `.primary`。

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
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

```swift
LhLoading(tone: .success)
```

## 尺寸

三檔尺寸對應到 `loading.size` 令牌，描邊寬度取 `loading.strokeWidth`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading 尺寸</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 模擬預覽（iOS / SwiftUI 外觀），非真機渲染</p>

## 靜態幀

`animating: false` 凍結旋轉（黃金用例 `render-emits-ring-command` 斷言靜止圓環的繪製參數），
用於截圖測試與文件靜態幀。

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### Props

| 屬性 | 說明 | 類型 | 預設值 |
| --- | --- | --- | --- |
| `lhSize` | 圓環尺寸，對應到尺寸令牌 | `LhLoadingSize` | `.medium` |
| `tone` | 圓環色調，對應到語義色令牌 | `LhLoadingTone` | `.primary` |
| `animating` | 是否旋轉（`false` 凍結為靜態幀） | `Bool` | `true` |

### LhLoadingSize

| 值 | 尺寸 |
| --- | --- |
| `.small` | `loading.size.small`（16pt） |
| `.medium` | `loading.size.medium`（20pt） |
| `.large` | `loading.size.large`（24pt） |

### LhLoadingTone

| 值 | 顏色 |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## 令牌對照

| 令牌 | 用途 |
| --- | --- |
| `loading.size.{small,medium,large}` | 三檔尺寸 |
| `loading.strokeWidth` | 圓環描邊寬度 |
| `color.{primary,success,warning,danger,info}.default` | 五種色調 |
| `motion.duration.base` | 旋轉一圈的動畫時長（iOS 端為秒） |

## 黃金用例對照

| case id | 斷言 | 本地測試 |
| --- | --- | --- |
| `medium-size-uses-medium-token` | 中號取 medium 尺寸令牌 | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | 大號取 large 尺寸令牌 | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | 主色調取主色令牌 | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | 成功色調取成功色令牌 | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | 圓環描邊消費 strokeWidth 令牌 | `testRingUsesStrokeWidthToken` |

另有暗色專項：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`。

```bash
swift test --filter LhLoadingTests    # macOS 宿主即可執行，無需模擬器
```
