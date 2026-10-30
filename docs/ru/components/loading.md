# Загрузка

Индикатор загрузки. На стороне SwiftUI это самостоятельно отрисовываемое кольцо (`Circle().trim` + анимация вращения), длительность берётся из `motion.duration.base` (в секундах).

> Источник контракта: `lh-ui-core/specs/loading.json` ·
> Золотые сценарии: `lh-ui-core/cases/loading.json` (5 шт., переведены в XCTest, запускаются на хосте macOS)

## Оттенки

Пять оттенков берут семантические цветовые токены, по умолчанию `.primary`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Загрузка: оттенки</span></div>
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
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhLoading(tone: .success)
```

## Размеры

Три размера отображаются на токены `loading.size`, толщина обводки берётся из `loading.strokeWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Загрузка: размеры</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Статический кадр

`animating: false` замораживает вращение (золотой сценарий `render-emits-ring-command` утверждает параметры отрисовки неподвижного кольца),
используется для тестов со снимками экрана и статических кадров в документации.

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `lhSize` | Размер кольца, отображается на токены размеров | `LhLoadingSize` | `.medium` |
| `tone` | Оттенок кольца, отображается на семантические цветовые токены | `LhLoadingTone` | `.primary` |
| `animating` | Вращается ли индикатор (`false` — зафиксированный статический кадр) | `Bool` | `true` |

### LhLoadingSize

| Значение | Размер |
| --- | --- |
| `.small` | `loading.size.small` (16pt) |
| `.medium` | `loading.size.medium` (20pt) |
| `.large` | `loading.size.large` (24pt) |

### LhLoadingTone

| Значение | Цвет |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `loading.size.{small,medium,large}` | Три размера |
| `loading.strokeWidth` | Толщина обводки кольца |
| `color.{primary,success,warning,danger,info}.default` | Пять оттенков |
| `motion.duration.base` | Длительность анимации одного оборота (на iOS — в секундах) |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `medium-size-uses-medium-token` | Средний размер берёт токен размера medium | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | Большой размер берёт токен размера large | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | Основной оттенок берёт токен основного цвета | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | Оттенок успеха берёт токен цвета успеха | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | Обводка кольца потребляет токен strokeWidth | `testRingUsesStrokeWidthToken` |

Дополнительно по тёмному режиму: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`.

```bash
swift test --filter LhLoadingTests    # достаточно хоста macOS, эмулятор не нужен
```
