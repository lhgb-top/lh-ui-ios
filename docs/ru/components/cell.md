# Ячейка

Ячейка списка. Слева иконка + заголовок (с красной звездой обязательности и подзаголовком), справа значение и стрелка, снизу разделитель.

> Источник контракта: `lh-ui-core/specs/cell.json` ·
> Золотые сценарии: `lh-ui-core/cases/cell.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Базовая форма

`title` обязательный, `value` / `label` / `icon` опциональны. `bordered` управляет нижним разделителем (по умолчанию включён).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell: база</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">Текст заголовка</div></div>
      <div class="sim-cell__value">Значение справа</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">С подзаголовком</div>
        <div class="sim-cell__label">Это поясняющий текст подзаголовка</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">Без разделителя</div></div>
      <div class="sim-cell__value">Значение</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhCell(title: "Текст заголовка", value: "Значение справа", clickable: true) {
  // lhOnClick
}
```

## Иконка / обязательность / некликабельность

`icon` проходит через маппинг `LhIconMap`; `required` показывает красную звёздочку перед заголовком;
при `clickable = false` (по умолчанию) нажатия не обрабатываются (золотой сценарий `not-clickable-no-onclick`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell: расширения</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">Иконка слева</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>Обязательное поле</div></div>
      <div class="sim-cell__value">Выберите</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `title` | Заголовок (обязательный) | `String` | — |
| `value` | Значение справа | `String` | `""` |
| `label` | Подзаголовок под заголовком | `String` | `""` |
| `icon` | Логическое имя левой иконки (маппинг `LhIconMap`) | `String?` | `nil` |
| `bordered` | Показывать ли нижний разделитель | `Bool` | `true` |
| `clickable` | Кликабельна ли ячейка (управляет стрелкой и гейтом нажатий) | `Bool` | `false` |
| `required` | Показывать ли красную звезду обязательности перед заголовком | `Bool` | `false` |
| `lhOnClick` | Обратный вызов при нажатии; не вызывается при `clickable = false` | `(() -> Void)?` | `nil` |

### Иерархия текста

| Область | Размер шрифта | Цвет |
| --- | --- | --- |
| Заголовок | `cell.fontSizeTitle` (14pt) | `color.text.primary` |
| Подзаголовок | `cell.fontSizeLabel` (13pt) | `color.text.secondary` |
| Значение справа | `cell.fontSizeValue` (14pt) | `color.text.secondary` |
| Звезда обязательности | `cell.fontSizeTitle` | `color.danger.default` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | Внутренние отступы (следуют `spacing.base` / `spacing.sm`) |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | Размеры шрифта трёх уровней |
| `cell.iconSize` | Размер левой иконки |
| `cell.gap` | Расстояния между блоками (следует `spacing.sm`) |
| `cell.borderWidth` | Толщина нижнего разделителя |
| `color.border.lighter` | Цвет нижнего разделителя |
| `color.text.{primary,secondary}` | Цвета заголовка и значения/подзаголовка |
| `color.danger.default` | Цвет звезды обязательности |
| `color.background.default` | Цвет фона ячейки |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `title-and-value-render` | Заголовок и значение рисуются одновременно | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | Подзаголовок берёт вторичный цвет текста | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | Звезда обязательности берёт токен цвета danger | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | Разделитель потребляет токен border.lighter | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | При кликабельности вызывается lhOnClick | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | При некликабельности lhOnClick не вызывается | `testNotClickableIsNotInteractive` |

Дополнительно: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`.

```bash
swift test --filter LhCellTests    # достаточно хоста macOS, эмулятор не нужен
```
