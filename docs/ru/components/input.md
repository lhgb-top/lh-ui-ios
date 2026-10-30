# Поле ввода

Управляемое однострочное поле ввода. Двусторонняя привязка `@Binding var value`, поддерживает открытый/скрытый ввод, кнопку очистки, ограничение количества символов и кольцо фокуса.

> Источник контракта: `lh-ui-core/specs/input.json` ·
> Золотые сценарии: `lh-ui-core/cases/input.json` (8 шт., переведены в XCTest, запускаются на хосте macOS)

## Основная форма

Высота выровнена с Button (три значения токена `input.height`), при фокусе обводка меняется на `color.focus` и расширяется в кольцо фокуса.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Поле ввода: основы</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="Введите текст" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷 (сине-белый фарфор)" /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "Введите текст") { newValue in
  // onValueChange
}
```

## Размеры

Три размера отображаются на токены `input.height` / `paddingHorizontal` / `fontSize`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Поле ввода: размеры</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="Малый" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="Средний" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="Большой" /></span></div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Пароль и очистка

`type: .password` превращается в `SecureField` (тест `testPasswordTypeIsSecure`);
`clearable` показывает кнопку очистки при наличии значения, нажатие вызывает `onValueChange("")` (золотой сценарий `clearable-emits-empty-value`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Поле ввода: расширения</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="Отключено" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `value` | Содержимое ввода (управляемая двусторонняя привязка) | `String` | — |
| `placeholder` | Текст плейсхолдера | `String` | `""` |
| `type` | Тип ввода (открытый текст / пароль) | `LhInputType` | `.text` |
| `lhSize` | Размер поля ввода, отображается на токены размеров | `LhInputSize` | `.medium` |
| `disabled` | Отключено ли поле (не вызывает обратных вызовов) | `Bool` | `false` |
| `readonly` | Только ли для чтения (не вызывает onValueChange, сохраняет стиль фокуса) | `Bool` | `false` |
| `clearable` | Показывать ли кнопку очистки | `Bool` | `false` |
| `maxlength` | Максимальное количество символов (при превышении обрезается, золотой сценарий `maxlength-truncates-input`) | `Int?` | `nil` |
| `onValueChange` | Обратный вызов изменения содержимого, payload — новое значение | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Обратный вызов получения фокуса | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Обратный вызов потери фокуса | `(() -> Void)?` | `nil` |

### LhInputSize

| Значение | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small` (32pt) | `input.paddingHorizontal.small` (12pt) | `input.fontSize.small` (13pt) |
| `.medium` | `input.height.medium` (40pt) | `input.paddingHorizontal.medium` (16pt) | `input.fontSize.medium` (14pt) |
| `.large` | `input.height.large` (48pt) | `input.paddingHorizontal.large` (20pt) | `input.fontSize.large` (16pt) |

### LhInputType

| Значение | Реализация |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### Цвета

| Состояние | Обводка | Текст / плейсхолдер |
| --- | --- | --- |
| По умолчанию | `color.border.base` (`input.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Фокус | `color.focus` (`input.focusRingWidth`) | То же |
| Отключено | `color.disabled.border` | `color.disabled.text` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `input.height.{small,medium,large}` | Три значения высоты |
| `input.paddingHorizontal.{small,medium,large}` | Три значения горизонтальных внутренних отступов |
| `input.fontSize.{small,medium,large}` | Три значения размера шрифта |
| `input.borderRadius` / `input.borderWidth` | Скругление (следует `radius.small`) и толщина обводки |
| `input.focusRingWidth` | Ширина кольца фокуса |
| `input.clearIconSize` | Размер иконки кнопки очистки |
| `color.focus` | Цвет обводки фокуса |
| `color.text.{primary,placeholder,disabled}` | Цвета текста и плейсхолдера |
| `color.border.base` / `color.disabled.border` | Цвета обводки |
| `color.background.default` / `color.disabled.bg` | Цвета фона |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `input-emits-onvaluechange` | Ввод вызывает `onValueChange("青花瓷 (сине-белый фарфор)")` | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | Очистка вызывает `onValueChange("")` | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | Отключённое состояние не вызывает onValueChange | `testDisabledBlocksInput` |
| `readonly-blocks-input` | Состояние «только для чтения» не вызывает onValueChange | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | Текст плейсхолдера берёт цвет из токена плейсхолдера | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | Фокус потребляет токен focus и вызывает lhOnFocus | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | Малый размер потребляет токены размера small | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | Превышение лимита символов обрезается | `testMaxlengthTruncatesInput` |

Дополнительно: `testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`.

```bash
swift test --filter LhInputTests    # достаточно хоста macOS, эмулятор не нужен
```
