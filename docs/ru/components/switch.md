# Переключатель

Управляемый переключатель. Двусторонняя привязка `@Binding var checked`, дорожка в пропорции 2:1, диаметр точки = высота − 2 × `switch.gap`.

> Источник контракта: `lh-ui-core/specs/switch.json` ·
> Золотые сценарии: `lh-ui-core/cases/switch.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Состояния

Во включённом состоянии дорожка принимает основной цвет, точка смещается вправо; в выключенном дорожка принимает цвет обводки. Состояние `loading` показывает внутри дорожки небольшой индикатор и не реагирует на переключение.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch: состояния</span></div>
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
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## Размеры

Три размера отображаются на токены `switch.width` / `switch.height`, скругление автоматически равно радиусу дорожки.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Switch: размеры</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Состояние загрузки

При `loading = true` внутрь дорожки встраивается `LhLoading(lhSize: .small, tone: .primary)`, а нажатие перехватывается гейтом
(золотой сценарий `loading-blocks-change`).

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `checked` | Состояние переключателя (управляемая двусторонняя привязка) | `Bool` | — |
| `disabled` | Отключён ли переключатель (не вызывает onChange) | `Bool` | `false` |
| `loading` | Идёт ли загрузка (встроенный индикатор, не вызывает onChange) | `Bool` | `false` |
| `lhSize` | Размер переключателя, отображается на токены размеров | `LhSwitchSize` | `.medium` |
| `onChange` | Обратный вызов изменения состояния, payload — новое значение | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| Значение | width | height | Диаметр точки |
| --- | --- | --- | --- |
| `.small` | `switch.width.small` (36pt) | `switch.height.small` (20pt) | height − 2 × `switch.gap` (16pt) |
| `.medium` | `switch.width.medium` (44pt) | `switch.height.medium` (24pt) | height − 2 × `switch.gap` (20pt) |
| `.large` | `switch.width.large` (52pt) | `switch.height.large` (28pt) | height − 2 × `switch.gap` (24pt) |

### Цвета

| Состояние | Дорожка | Точка |
| --- | --- | --- |
| Выключено | `color.border.base` | `color.onPrimary` |
| Включено | `color.primary.default` | `color.onPrimary` |
| Отключено | `color.disabled.bg` | `color.disabled.text` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `switch.width.{small,medium,large}` | Три значения ширины дорожки |
| `switch.height.{small,medium,large}` | Три значения высоты дорожки |
| `switch.gap` | Внутренний отступ между точкой и дорожкой (определяет диаметр точки) |
| `color.primary.default` | Цвет дорожки во включённом состоянии |
| `color.border.base` | Цвет дорожки в выключенном состоянии |
| `color.onPrimary` | Цвет точки |
| `color.disabled.{bg,text}` | Два цвета отключённого состояния |
| `motion.duration.base` | Длительность анимации скольжения точки (на iOS — в секундах) |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | Нажатие включает и вызывает `onChange(true)` | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | Нажатие во включённом состоянии выключает | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | Отключённое состояние не вызывает onChange | `testDisabledBlocksChange` |
| `loading-blocks-change` | Состояние загрузки не вызывает onChange | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | Включённое состояние потребляет токен основного цвета, а не токен обводки | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | Выключенное состояние потребляет токен обводки | `testUncheckedUsesBorderToken` |

Дополнительно: `testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`.

```bash
swift test --filter LhSwitchTests    # достаточно хоста macOS, эмулятор не нужен
```
