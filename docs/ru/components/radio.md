# Радиокнопка

Управляемый переключатель (радио). `@Binding var checked` указывает, «выбран ли данный элемент», обычно используется в составе группы; в одной группе может быть выбран только один элемент (`true`).

> Источник контракта: `lh-ui-core/specs/radio.json` ·
> Золотые сценарии: `lh-ui-core/cases/radio.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Состояния

В выбранном состоянии это кольцо с обводкой основным цветом + сплошная точка основного цвета; в невыбранном — пустое кольцо с обводкой. Диаметр точки равен размеру, умноженному на `radio.dotScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Радио: состояния</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>Не выбран</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Выбран</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Выбран, отключён</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>Не выбран, отключён</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷 (сине-белый фарфор)") { _ in
  picked = "blue"
}
```

## Размеры

Три размера отображаются на токены `radio.size`; толщина обводки кольца берётся из `radio.ringWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Радио: размеры</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>Малый</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Средний</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>Большой</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Гейт нажатия

Повторное нажатие на выбранный элемент сохраняет выбор и не вызывает `onChange` (золотой сценарий `tap-checked-keeps-checked`);
в отключённом состоянии вызова не происходит (`disabled-blocks-change`). Контейнер-группа оставлен для будущих версий.

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `checked` | Выбран ли данный элемент (управляемая двусторонняя привязка) | `Bool` | — |
| `value` | Значение, которое представляет данный элемент (вместе с `checked` образует радио-группу) | `String` | `""` |
| `disabled` | Отключено ли поле (не вызывает onChange) | `Bool` | `false` |
| `lhSize` | Размер переключателя, отображается на токены размеров | `LhRadioSize` | `.medium` |
| `label` | Текстовая метка | `String` | `""` |
| `onChange` | Обратный вызов изменения выбора, payload — новое значение | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| Значение | Размер кольца | Диаметр точки |
| --- | --- | --- |
| `.small` | `radio.size.small` (16pt) | размер × `radio.dotScale` (8pt) |
| `.medium` | `radio.size.medium` (20pt) | размер × `radio.dotScale` (10pt) |
| `.large` | `radio.size.large` (24pt) | размер × `radio.dotScale` (12pt) |

### Цвета

| Состояние | Обводка кольца | Точка |
| --- | --- | --- |
| Не выбран | `color.border.base` (`radio.ringWidth`) | — |
| Выбран | `color.primary.default` | `color.primary.default` |
| Отключено | `color.disabled.border` | `color.disabled.text` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `radio.size.{small,medium,large}` | Три размера кольца |
| `radio.dotScale` | Отношение диаметра точки к размеру кольца (50%) |
| `radio.ringWidth` | Толщина обводки кольца |
| `radio.gap` | Расстояние между кольцом и текстом (следует `spacing.sm`) |
| `color.primary.default` | Цвет обводки и точки в выбранном состоянии |
| `color.border.base` | Цвет обводки в невыбранном состоянии |
| `color.disabled.{border,text}` | Цвета обводки и точки в отключённом состоянии |
| `color.text.{primary,disabled}` | Цвет текста метки |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | Нажатие на невыбранный элемент вызывает `onChange(true)` | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | Нажатие на выбранный элемент сохраняет выбор без обратного вызова | `testCheckedShowsDot` |
| `disabled-blocks-change` | Отключённое состояние не вызывает onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | Выбранное состояние потребляет токены основного цвета | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | Невыбранное состояние потребляет токен обводки | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | Малый размер потребляет токен размера small | `testSmallSizeUsesSmallToken` |

Дополнительно: `testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`.

```bash
swift test --filter LhRadioTests    # достаточно хоста macOS, эмулятор не нужен
```
