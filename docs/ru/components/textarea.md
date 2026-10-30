# Текстовая область

Управляемое многострочное поле ввода. Двусторонняя привязка `@Binding var value`, поверх — плейсхолдер и счётчик символов.

> Источник контракта: `lh-ui-core/specs/textarea.json` ·
> Золотые сценарии: `lh-ui-core/cases/textarea.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Основная форма

Минимальная высота берётся из `textarea.minHeight`, внутренние отступы — из `textarea.paddingHorizontal` / `paddingVertical`,
при фокусе обводка меняется на `color.focus`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea: основы</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="Введите текст"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷 (сине-белый фарфор)</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "Введите текст") { newValue in
  // onValueChange
}
```

## Счётчик символов

При `showCount = true` в правом нижнем углу отображается счётчик: если задан `maxlength`, показывается `текущее/лимит` (золотой сценарий
`showcount-renders-count`), если не задан — только текущая длина (`showcount-without-maxlength-renders-length-only`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea: счётчик</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷 (сине-белый фарфор)</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>Отключено</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `value` | Содержимое ввода (управляемая двусторонняя привязка) | `String` | — |
| `placeholder` | Текст плейсхолдера | `String` | `""` |
| `rows` | Ожидаемое количество строк (влияет на минимальную высоту) | `Int` | `3` |
| `disabled` | Отключено ли поле (не вызывает обратных вызовов) | `Bool` | `false` |
| `readonly` | Только ли для чтения (не вызывает onValueChange, сохраняет стиль фокуса) | `Bool` | `false` |
| `showCount` | Показывать ли счётчик символов | `Bool` | `false` |
| `maxlength` | Максимальное количество символов (при превышении обрезается) | `Int?` | `nil` |
| `onValueChange` | Обратный вызов изменения содержимого, payload — новое значение | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Обратный вызов получения фокуса | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Обратный вызов потери фокуса | `(() -> Void)?` | `nil` |

### Цвета

| Состояние | Обводка | Текст / плейсхолдер |
| --- | --- | --- |
| По умолчанию | `color.border.base` (`textarea.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Фокус | `color.focus` (`textarea.focusRingWidth`) | То же |
| Отключено | `color.disabled.border` | `color.disabled.text` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `textarea.minHeight` | Минимальная высота |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | Внутренние отступы |
| `textarea.fontSize` | Размер шрифта |
| `textarea.countFontSize` | Размер шрифта текста счётчика |
| `textarea.borderRadius` / `textarea.borderWidth` | Скругление и толщина обводки |
| `textarea.focusRingWidth` | Ширина кольца фокуса |
| `color.focus` | Цвет обводки фокуса |
| `color.text.{primary,placeholder,disabled}` | Цвета текста и плейсхолдера |
| `color.border.base` / `color.disabled.border` | Цвета обводки |
| `color.background.default` / `color.disabled.bg` | Цвета фона |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `input-emits-onvaluechange` | Ввод вызывает `onValueChange("青花瓷 (сине-белый фарфор)")` | `testDefaultIsEditable` |
| `disabled-blocks-input` | Отключённое состояние не вызывает onValueChange | `testDisabledBlocksInput` |
| `showcount-renders-count` | Счётчик показывает `3/10` и потребляет токен размера шрифта счётчика | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | Без лимита показывается только `3` | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | Фокус потребляет токен focus и вызывает lhOnFocus | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | Превышение лимита символов обрезается | `testMaxlengthTruncatesInput` |

Дополнительно: `testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`.

```bash
swift test --filter LhTextareaTests    # достаточно хоста macOS, эмулятор не нужен
```
