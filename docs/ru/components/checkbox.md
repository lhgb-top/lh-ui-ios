# Флажок

Управляемый флажок. Двусторонняя привязка через `@Binding var checked`, поддерживает три состояния (отмечен / не отмечен / не определён).

> Источник контракта: `lh-ui-core/specs/checkbox.json` ·
> Золотые сценарии: `lh-ui-core/cases/checkbox.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Состояния

Отмеченное состояние — сплошной квадрат основного цвета + белая галочка; неопределённое — сплошной квадрат основного цвета + белая поперечная черта; не отмечен — пустая рамка с обводкой.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Состояния Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>Не отмечен</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Отмечен</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>Не определено</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Отключён</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Отмечен") { newValue in
  // onChange
}
```

## Размеры

Три размера отображаются на токены `checkbox.size`; толщина обводки галочки берётся из `checkbox.checkWidth`,
а толщина черты неопределённого состояния равна размеру квадрата, умноженному на `checkbox.dashScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Размеры Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Маленький</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Средний</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Большой</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Неопределённое состояние

При `indeterminate = true` галочка не рисуется — вместо неё показывается черта; после нажатия состояние обязательно становится **отмеченным** (золотой сценарий
`indeterminate-becomes-checked`), а не переключается.

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Выбрать все", indeterminate: somePartial) { _ in }
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `checked` | Состояние отметки (управляемая двусторонняя привязка) | `Bool` | — |
| `indeterminate` | Неопределённое состояние (показывает черту, после нажатия становится отмеченным) | `Bool` | `false` |
| `disabled` | Отключён ли (onChange не вызывается) | `Bool` | `false` |
| `lhSize` | Размер флажка, отображается на токены размеров | `LhCheckboxSize` | `.medium` |
| `label` | Текстовая метка | `String` | `""` |
| `onChange` | Обратный вызов при изменении состояния, payload — новое значение | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| Значение | Размер |
| --- | --- |
| `.small` | `checkbox.size.small` (16pt) |
| `.medium` | `checkbox.size.medium` (20pt) |
| `.large` | `checkbox.size.large` (24pt) |

### Цвета

| Состояние | Цвет фона квадрата | Цвет метки |
| --- | --- | --- |
| Не отмечен | Прозрачный + обводка `color.border.base` (`checkbox.borderWidth`) | — |
| Отмечен / не определён | `color.primary.default` | `color.onPrimary` |
| Отключён | `color.disabled.bg` + обводка `color.disabled.border` | `color.disabled.text` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `checkbox.size.{small,medium,large}` | Три размера |
| `checkbox.borderRadius` / `checkbox.borderWidth` | Скругление (следует `radius.small`) и толщина обводки |
| `checkbox.checkWidth` | Толщина обводки галочки |
| `checkbox.dashScale` | Доля черты неопределённого состояния относительно квадрата (50%) |
| `checkbox.gap` | Расстояние между квадратом и текстом (следует `spacing.sm`) |
| `color.primary.default` / `color.onPrimary` | Цвета фона/метки отмеченного состояния |
| `color.border.base` | Цвет обводки неотмеченного состояния |
| `color.disabled.{bg,border,text}` | Три цвета отключённого состояния |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | Нажатие переключает и вызывает `onChange(true)` | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | Нажатие на отмеченный флажок снимает отметку | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | В отключённом состоянии onChange не вызывается | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | Отмеченное состояние потребляет основной цвет и onPrimary | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | Неотмеченное состояние потребляет токен обводки | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | После нажатия на неопределённое состояние всегда отмечен | `testIndeterminateBecomesChecked` |

Дополнительно: `testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`.

```bash
swift test --filter LhCheckboxTests    # достаточно хоста macOS, эмулятор не нужен
```
