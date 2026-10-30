# Средство выбора

Декларативное средство выбора с колесом прокрутки в нижней части экрана. `@Binding var visible` управляет видимостью, `@Binding var value` — индекс выбранного элемента; колесо прокрутки отрисовывается самостоятельно (`DragGesture` + притяжение при отпускании), без зависимости от системных элементов управления.

> Источник контракта: `lh-ui-core/specs/picker.json` ·
> Золотые сценарии: `lh-ui-core/cases/picker.json` (8 шт., переведены в XCTest, запускаются на хосте macOS)

## Основная форма

Появляется снизу: сверху панель инструментов (отмена / заголовок / подтверждение), в центре — колесо прокрутки и две индикаторные линии.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker: основы</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Средство выбора</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">Отмена</span>
      <span class="sim-picker__title">Выбрать</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">Подтвердить</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">Вариант 1</div>
      <div class="sim-picker__item sim-picker__item--selected">Вариант 2</div>
      <div class="sim-picker__item">Вариант 3</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["Вариант 1", "Вариант 2", "Вариант 3"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Выбрать"
)
```

## Взаимодействие с колесом прокрутки

- Перетаскивание изменяет общее смещение; после отпускания происходит притяжение к ближайшему кандидату (длительность анимации `motion.duration.base`),
  при изменении выбранного индекса вызывается `onValueChange` (золотой сценарий `scroll-emits-onvaluechange`).
- Расстояние между индикаторными линиями = `picker.itemHeight`, выбранный элемент всегда попадает точно в центр между ними.

## Обратные вызовы и граничные случаи

- «Подтвердить» вызывает `onConfirm` (payload — текущий индекс) и `onClose` (`confirm-also-emits-onclose`).
- «Отмена» вызывает `onCancel`.
- При выходе `value` за границы выполняется clamp на стороне платформы: отрицательные значения прижимаются к нулю
  (`clamp-negative-value-to-zero`), превышающие диапазон — к последнему элементу
  (`clamp-overflow-value-to-last`); для пустого списка вариантов индекс всегда равен 0.
- При `visible = false` не отправляется ни одной команды отрисовки (`hidden-not-rendered`).

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Выбрать",
  confirmText: "Подтвердить",
  cancelText: "Отмена",
  onValueChange: { newIndex in
    // обратный вызов притяжения при прокрутке
  },
  onConfirm: { newIndex in
    // обратный вызов подтверждения (payload — текущий индекс)
  },
  onCancel: {
    // обратный вызов отмены
  }
)
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `visible` | Видимо ли средство выбора (управляемая двусторонняя привязка) | `Bool` | — |
| `options` | Массив текстов кандидатов (один столбец) | `[String]` | — |
| `value` | Индекс выбранного элемента (управляемая двусторонняя привязка, при выходе за границы выполняется clamp) | `Int` | — |
| `title` | Заголовок панели инструментов | `String` | `""` |
| `confirmText` | Текст кнопки подтверждения | `String` | `"确认"` |
| `cancelText` | Текст кнопки отмены | `String` | `"取消"` |
| `onValueChange` | Обратный вызов притяжения при прокрутке, payload — новый индекс | `((Int) -> Void)?` | `nil` |
| `onConfirm` | Обратный вызов подтверждения, payload — текущий индекс | `((Int) -> Void)?` | `nil` |
| `onCancel` | Обратный вызов отмены | `(() -> Void)?` | `nil` |
| `onClose` | Обратный вызов закрытия (срабатывает и при подтверждении, и при отмене) | `(() -> Void)?` | `nil` |

### Цвета

| Область | Цвет |
| --- | --- |
| Фон панели | `color.background.default` |
| Маска | `color.background.overlay` |
| Кнопка отмены / текст кандидатов | `color.text.primary` |
| Заголовок / кнопка подтверждения | `color.primary.default` |
| Индикаторные линии | `color.border.lighter` (ширина берётся из `cell.borderWidth`) |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `picker.height` | Высота панели (260pt) |
| `picker.toolbarHeight` | Высота панели инструментов (44pt) |
| `picker.itemHeight` | Высота одного элемента (определяет расстояние между индикаторными линиями колеса) |
| `picker.itemFontSize` | Размер шрифта кандидатов и панели инструментов |
| `picker.borderRadius` | Скругление верхних углов |
| `color.background.overlay` / `color.background.default` | Цвета маски и фона панели |
| `color.border.lighter` / `cell.borderWidth` | Цвет и ширина индикаторных линий |
| `color.primary.default` | Цвет кнопки подтверждения и текста выбранного элемента |
| `zIndex.{modalBackdrop,modal}` | Уровни маски и панели |
| `motion.duration.base` | Длительность анимации притяжения (на iOS — в секундах) |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | Подтверждение вызывает `onConfirm(1)` | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | Подтверждение также вызывает onClose | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | Отмена вызывает onCancel | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | Притяжение при прокрутке вызывает `onValueChange(2)` | слой View, `DragGesture.onEnded` (утверждения жестов требуют эмулятора) |
| `clamp-negative-value-to-zero` | Отрицательный индекс прижимается к 0 | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | Индекс выше диапазона прижимается к последнему элементу | `testClampOverflowValueToLast` |
| `title-renders-text` | Заголовок корректно отрисовывается | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | В скрытом состоянии ничего не рендерится | `testHiddenNotRendered` |

Дополнительно: `testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`.

```bash
swift test --filter LhPickerTests    # достаточно хоста macOS, эмулятор не нужен
```
