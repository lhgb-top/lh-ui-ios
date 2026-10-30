# 테마 및 다크 모드

## 토큰 모델

네이티브 혈통의 토큰 원본은 `lh-ui-core/tokens/*.json`이며, codegen이 iOS 산출물을 생성합니다.

| 산출물 | 내용 | 다크 형태 |
| --- | --- | --- |
| `LhTokens` | 라이트 전체: Button 크기, Color 팔레트, Motion, Radius, Shadow, Spacing, Typography, ZIndex | — |
| `LhDarkTokens` | `Color` 서브 객체만(**병렬 객체** 모델) | 다크는 색상만 덮고, 크기/애니메이션/모서리 둥글기는 다크에서 변하지 않음 |
| `LhShadow` | SwiftUI 섀도 운반용 구조체(color/opacity/radius/x/y) | — |

> 이 점은 android / harmony / windows와 동일(병렬 객체)하며, docs 단(얕은 병합 JSON)과는 형태가 다릅니다.
> 테마 계층은 이에 따라 설계되었습니다: `LhColors`는 색상만 담고, 크기는 컴포넌트가 `LhTokens`에서 직접 가져옵니다.

## LhColors

`LightLhColors` / `DarkLhColors`는 생성된 두 enum을 평평하게 펼쳐 하나의 `Equatable` 값 타입으로 만듭니다.

```swift
public struct LhColors: Equatable {
  public let primary: Color
  public let onPrimary: Color
  // ... 모든 시맨틱 색상
}

public let LightLhColors = LhColors(primary: LhTokens.Color.Primary.`default`, /* ... */)
public let DarkLhColors = LhColors(primary: LhDarkTokens.Color.Primary.`default`, /* ... */)
```

이니셜라이저는 공개되어 있습니다: 단위 테스트에서 팔레트를 직접 생성해 단언할 수 있고, 앱 측에서는 `LhTheme`로 소비해야 합니다.

## LhTheme

```swift
LhTheme(isDark: true) {
  // Environment(\.lhColors)에 DarkLhColors를 주입하고, 내부 컴포넌트가 자동으로 소비
}
```

`LhTheme`로 감싸지 않았을 때 Environment 키의 defaultValue는 `LightLhColors`로 폴백합니다(기본이 라이트).

## 다크 미리 계산(중요)

web 혈통의 다크는 CSS `color-mix()`로 동적으로 평가하지만, 네이티브에는 CSS 캐스케이드가 없어 core가 다크 표현식을
**리터럴로 미리 계산**해 둡니다(예: `rgba(61,100,158,0.25)`, `#B1C1D8`). 결과(마스터 플랜 R-n6):

> **프리셋 주색을 바꿔도 다크 미리 계산값이 자동으로 따라가지 않습니다.** 반드시 다시 수동으로 계산해서
> `lh-ui-core/tokens/color-dark.json`을 업데이트하고, *디자인 언어 베이스라인*을 함께 새로고침해야 합니다.

## iOS 단 특유의 규칙

- **시간 단위는 초**: `LhTokens.Motion.Duration.base = 0.300`(android/harmony은 밀리초, C는 밀리초).
  SwiftUI 애니메이션 API가 그대로 소비하므로 변환이 필요 없습니다.
- **색상 값 표현**: 생성 산출물은 정규화된 RGB(`SwiftUI.Color(red:green:blue:)` + `.opacity()`)를 사용하며,
  hex 문자열은 사용하지 않습니다.
- **모서리 둥글기**: `Radius.circle`은 0.5 분수이므로 단 측에서 `min(너비, 높이)/2`로 변환해야 하며, pt처럼 쓸 수 없습니다.
- **섀도**: SwiftUI는 확장량(spread)을 지원하지 않아, 생성된 `LhShadow`는 spread를 무시하고 주석을 달아둡니다.
- **폰트**: `Typography.fontFamily`는 폰트 스택 문자열이며, 단 측에서 사용 가능한 첫 번째 패밀리를 사용합니다. 중국풍 세리프가 기본 분위기입니다.

## 토큰 빠른 참조

전체 토큰 표(라이트/다크/설명)는 core 저장소의 `dist/docs/tokens.md`를 참조하세요(`pnpm codegen` 후 생성됩니다).
컴포넌트 수준의 토큰 매핑은 [Button 토큰 매핑](/ko/components/button#토큰-매핑)을 참조하세요.
