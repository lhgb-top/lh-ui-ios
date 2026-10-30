# 로컬 연결

## 패밀리 레이아웃 규칙

```
lh-ui/                        # 패밀리 부모 디렉터리(저장소가 아님)
├── lh-ui-core/               # 토큰 원본 + codegen
├── lh-ui-android/            # 형제 저장소
├── lh-ui-ios/                # 이 저장소
├── lh-ui-harmony/
└── lh-ui-windows/
```

각 저장소가 같은 부모 디렉터리에 있으면 토큰을 **로컬로 직접 연결**하고, 형제 저장소가 없을 때(CI 단일 저장소 clone)는 **자동으로 npm 패키지로 폴백**합니다.
이 동작은 web 혈통의 vite alias 가드 메커니즘과 같은 구조입니다(마스터 플랜 D18).

## 3단계 가드

`scripts/link-tokens.mjs`가 우선순위에 따라 토큰 산출물을 찾습니다.

| 우선순위 | 출처 | 설명 |
| --- | --- | --- |
| 1 | `../lh-ui-core/dist/ios` | 로컬 직결: 토큰을 바꾸면 즉시 반영 |
| 2 | `node_modules/@lh-ui/core/dist/ios` | npm 폴백: `@lh-ui/core`의 `files:["dist"]`에 4단 산출물 포함 |
| 3 | — | 에러로 종료, 토큰이 없으면 빌드 불가 |

## 일상 흐름

```bash
# 1. 토큰 수정(core 저장소에서)
cd ../lh-ui-core
vim tokens/color.json           # 또는 spacing / typography / ...

# 2. 재생성 + 검증
pnpm codegen                    # dist/에 4단 산출물 생성
pnpm verify                     # schema + 참조 + WCAG 대비 + 계약 일치성

# 3. 이 저장소로 돌아와 동기화
cd ../lh-ui-ios
pnpm link:tokens                # Sources/LhUITokens/ 덮어쓰기

# 4. 회귀
swift test
```

## CI 게이트

```bash
pnpm link:tokens:check          # 토큰이 동기화되었는지 검사(파일 수 비교, 미동기화 시 종료 코드 1)
```

## 금지 사항

- ❌ `Sources/LhUITokens/` 수동 수정(생성물, gitignore)
- ❌ 생성된 토큰 파일을 저장소에 커밋
- ❌ 컴포넌트에 색상/간격 리터럴 작성(예: `Color(red: 0.169, ...)`, `CGFloat(40)`, `14`호 폰트)
- ❌ `link:tokens`를 우회해 산출물을 수동으로 복사

## 문제 해결

| 증상 | 원인 | 해결 |
| --- | --- | --- |
| 컴파일 에러 `cannot find 'LhTokens' in scope` | 토큰이 동기화되지 않음 | `pnpm link:tokens` |
| 토큰 값이 예상과 다름 | core 저장소를 codegen하지 않음 | core 저장소에서 `pnpm codegen` 후 다시 link |
| `link:tokens`가 "토큰 산출물을 찾을 수 없음" 보고 | 형제 저장소가 없고 npm 패키지도 설치 안 됨 | 패밀리 레이아웃 확인 또는 `pnpm i -D @lh-ui/core` |
| 다크 색상이 올바르지 않음 | 라이트 주색을 바꾸고 다크 미리 계산은 업데이트 안 함 | `color-dark.json` 업데이트 후 재실행(R-n6) |
| `default` 관련 컴파일 에러 | 생성 산출물의 멤버 이름 키워드 이스케이프 누락 | core 업그레이드(수정됨: 멤버 이름에 백틱 `` `default` `` 포함) |
