# Loading 로딩

로딩 인디케이터입니다. SwiftUI 단에서는 직접 그린 원환(`Circle().trim` + 회전 애니메이션)이며, 시간은 `motion.duration.base`(초)를 따릅니다.

> 계약 원본: `lh-ui-core/specs/loading.json` ·
> 골든 케이스: `lh-ui-core/cases/loading.json`(5건, XCTest로 번역됨, macOS 호스트에서 실행 가능)

## 색조

5가지 색조는 시맨틱 색상 토큰을 사용하며, 기본은 `.primary`입니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading 색조</span></div>
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
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

```swift
LhLoading(tone: .success)
```

## 크기

3단 크기가 `loading.size` 토큰으로 매핑되며, 테두리 두께는 `loading.strokeWidth`를 사용합니다.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Loading 크기</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML 시뮬레이터 미리보기(iOS / SwiftUI 외관), 실기기 렌더링이 아님</p>

## 정지 프레임

`animating: false`는 회전을 멈춥니다(골든 케이스 `render-emits-ring-command`가 정지 원환의 그리기 매개변수를 단언).
스크린샷 테스트와 문서 정지 프레임에 사용합니다.

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### Props

| 속성 | 설명 | 타입 | 기본값 |
| --- | --- | --- | --- |
| `lhSize` | 원환 크기, 크기 토큰으로 매핑 | `LhLoadingSize` | `.medium` |
| `tone` | 원환 색조, 시맨틱 색상 토큰으로 매핑 | `LhLoadingTone` | `.primary` |
| `animating` | 회전 여부(`false`면 정지 프레임으로 고정) | `Bool` | `true` |

### LhLoadingSize

| 값 | 크기 |
| --- | --- |
| `.small` | `loading.size.small`(16pt) |
| `.medium` | `loading.size.medium`(20pt) |
| `.large` | `loading.size.large`(24pt) |

### LhLoadingTone

| 값 | 색상 |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## 토큰 매핑

| 토큰 | 용도 |
| --- | --- |
| `loading.size.{small,medium,large}` | 3단 크기 |
| `loading.strokeWidth` | 원환 테두리 두께 |
| `color.{primary,success,warning,danger,info}.default` | 5가지 색조 |
| `motion.duration.base` | 1회전 애니메이션 시간(iOS 단에서는 초) |

## 골든 케이스 매핑

| case id | 단언 | 로컬 테스트 |
| --- | --- | --- |
| `medium-size-uses-medium-token` | 중형은 medium 크기 토큰 사용 | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | 대형은 large 크기 토큰 사용 | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | 주요 색조는 주색 토큰 사용 | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | 성공 색조는 성공색 토큰 사용 | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | 원환 테두리는 strokeWidth 토큰 소비 | `testRingUsesStrokeWidthToken` |

추가로 다크 전용 항목: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`.

```bash
swift test --filter LhLoadingTests    # macOS 호스트에서 실행 가능, 시뮬레이터 불필요
```
