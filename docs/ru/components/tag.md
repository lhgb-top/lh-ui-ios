# Тег

Компактные теги для маркировки и выбора. Меньше кнопки, поддерживает семантические типы, обводку, скруглённую капсулу и кнопку закрытия.

> Источник контракта: `lh-ui-core/specs/tag.json` ·
> Золотые сценарии: `lh-ui-core/cases/tag.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Типы

Шесть типов определяют цвет фона и цвет текста. `plain` — форма с обводкой на светлом фоне (семантический светлый фон + семантическая обводка).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag: типы</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">По умолчанию</span>
      <span class="sim-tag sim-tag--primary">Основной</span>
      <span class="sim-tag sim-tag--success">Успех</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">Предупреждение</span>
      <span class="sim-tag sim-tag--danger">Опасный</span>
      <span class="sim-tag sim-tag--info">Информация</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">Контурный основной</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">Контурный успех</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhTag(text: "Основной", type: .primary)
LhTag(text: "Контурный успех", type: .success, plain: true)
```

## Размеры и скругление

Три размера отображаются на токены `tag.height` / `paddingHorizontal` / `fontSize`; `round` меняет скругление на половину высоты (капсула).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag: размеры</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">Малый</span>
      <span class="sim-tag sim-tag--primary">Средний</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">Большой</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Прямой угол</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">Скруглённый</span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Закрываемые

`closable` показывает кнопку закрытия справа, нажатие вызывает `onClose` (золотой сценарий `closable-tap-emits-onclose`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tag: закрытие</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Закрываемый<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">Закрываемый<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhTag(text: "Закрываемый", type: .primary, closable: true) {
  // onClose
}
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `text` | Текст тега | `String` | — |
| `type` | Тип тега, определяет цвет фона и цвет текста | `LhTagType` | `.default` |
| `lhSize` | Размер тега, отображается на токены размеров | `LhTagSize` | `.medium` |
| `plain` | Является ли форма обводкой на светлом фоне | `Bool` | `false` |
| `round` | Является ли скругление капсулой (радиус = высота / 2) | `Bool` | `false` |
| `closable` | Показывать ли кнопку закрытия | `Bool` | `false` |
| `onClose` | Обратный вызов нажатия на кнопку закрытия | `(() -> Void)?` | `nil` |

### LhTagType

| Значение | Фон | Цвет текста |
| --- | --- | --- |
| `.default` | `color.background.default` + обводка `color.border.base` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

При `plain = true`: фон берётся из `color.<type>.bg`, обводка и текст — из `color.<type>.default` (для типа `.default` `plain` игнорируется, золотой сценарий `default-type-renders-text`).

### LhTagSize

| Значение | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small` (20pt) | `tag.paddingHorizontal.small` (8pt) | `tag.fontSize.small` (12pt) |
| `.medium` | `tag.height.medium` (24pt) | `tag.paddingHorizontal.medium` (12pt) | `tag.fontSize.medium` (13pt) |
| `.large` | `tag.height.large` (28pt) | `tag.paddingHorizontal.large` (16pt) | `tag.fontSize.large` (14pt) |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `tag.height.{small,medium,large}` | Три значения высоты |
| `tag.paddingHorizontal.{small,medium,large}` | Три значения горизонтальных внутренних отступов |
| `tag.fontSize.{small,medium,large}` | Три значения размера шрифта |
| `tag.borderRadius` / `tag.borderWidth` | Скругление по умолчанию (следует `radius.small`) и толщина обводки |
| `tag.gap` | Расстояние между текстом и кнопкой закрытия (следует `spacing.xs`) |
| `color.{primary,success,warning,danger,info}.{default,bg}` | Фоны семантических типов и обводка на светлом фоне |
| `color.onPrimary` | Цвет текста семантических типов |
| `color.background.default` / `color.text.primary` / `color.border.base` | Три цвета типа по умолчанию |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `default-type-renders-text` | Тип по умолчанию — нейтральные фон/текст, plain игнорируется | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | Тип primary потребляет токены основного цвета и onPrimary | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain потребляет семантический bg и семантическую обводку | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | Малый размер потребляет токены размера small | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | При round скругление == высота / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | Кнопка закрытия вызывает onClose | `testClosableTagInitAndRender` (утверждения жестов требуют эмулятора) |

Дополнительно по тёмному режиму: `testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhTagTests    # достаточно хоста macOS, эмулятор не нужен
```
