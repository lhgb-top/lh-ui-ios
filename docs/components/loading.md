# Loading 加载

加载指示器。SwiftUI 端为自绘圆环（`Circle().trim` + 旋转动画），时长走 `motion.duration.base`（秒）。

> 契约源：`lh-ui-core/specs/loading.json` ·
> 黄金用例：`lh-ui-core/cases/loading.json`（5 条，已翻译为 XCTest，macOS 宿主即可运行）

## 色调

五种色调取语义色令牌，默认 `.primary`。

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading 色调</span></div>
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
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

```swift
LhLoading(tone: .success)
```

## 尺寸

三档尺寸映射到 `loading.size` 令牌，描边宽度取 `loading.strokeWidth`。

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
<p class="sim-note">HTML 模拟预览（iOS / SwiftUI 外观），非真机渲染</p>

## 静态帧

`animating: false` 冻结旋转（黄金用例 `render-emits-ring-command` 断言静止圆环的绘制参数），
用于截图测试与文档静态帧。

```swift
LhLoading(size: .large, animating: false)
```

## API

### Props

| 属性 | 说明 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `size` | 圆环尺寸，映射到尺寸令牌 | `LhLoadingSize` | `.medium` |
| `tone` | 圆环色调，映射到语义色令牌 | `LhLoadingTone` | `.primary` |
| `animating` | 是否旋转（`false` 冻结为静态帧） | `Bool` | `true` |

### LhLoadingSize

| 值 | 尺寸 |
| --- | --- |
| `.small` | `loading.size.small`（16pt） |
| `.medium` | `loading.size.medium`（20pt） |
| `.large` | `loading.size.large`（24pt） |

### LhLoadingTone

| 值 | 颜色 |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## 令牌对照

| 令牌 | 用途 |
| --- | --- |
| `loading.size.{small,medium,large}` | 三档尺寸 |
| `loading.strokeWidth` | 圆环描边宽度 |
| `color.{primary,success,warning,danger,info}.default` | 五种色调 |
| `motion.duration.base` | 旋转一周的动画时长（iOS 端为秒） |

## 黄金用例对照

| case id | 断言 | 本地测试 |
| --- | --- | --- |
| `medium-size-uses-medium-token` | 中号取 medium 尺寸令牌 | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | 大号取 large 尺寸令牌 | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | 主色调取主色令牌 | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | 成功色调取成功色令牌 | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | 圆环描边消费 strokeWidth 令牌 | `testRingUsesStrokeWidthToken` |

另有暗色专项：`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`。

```bash
swift test --filter LhLoadingTests    # macOS 宿主即可跑，无需模拟器
```
