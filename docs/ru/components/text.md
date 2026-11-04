# Текст (Text)

Примитив отображения текста: потребляет глобальные типографические токены, поддерживает уровни размера, начертание, тон и выравнивание.

> Контракт: `lh-ui-core/specs/text.json` · Золотые случаи: `lh-ui-core/cases/text.json` (5, переведены в XCTest, запускаются на хосте macOS)

## Уровни размера

`level` мапится на токен `typography.fontSize.<level>`; по умолчанию `base`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--extraLarge">extraLarge</p>
    <p class="sim-text sim-text--large">large</p>
    <p class="sim-text sim-text--medium">medium</p>
    <p class="sim-text">base</p>
    <p class="sim-text sim-text--small">small</p>
    <p class="sim-text sim-text--extraSmall">extraSmall</p>
  </div>
</div>
<p class="sim-note">Предпросмотр HTML-симулятора (внешний вид iOS / SwiftUI), не рендеринг на реальном устройстве</p>

```swift
LhText("Title text", level: .large)
```

## Начертание

`weight` мапится на токен `typography.fontWeight.<weight>` (primary 400 / bold 600).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--bold">bold</p>
  </div>
</div>
<p class="sim-note">Предпросмотр HTML-симулятора (внешний вид iOS / SwiftUI), не рендеринг на реальном устройстве</p>

## Тон

`tone` мапится на токен `color.text.<tone>`; `selected` принимает `color.selected`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--regular">regular</p>
    <p class="sim-text sim-text--secondary">secondary</p>
    <p class="sim-text sim-text--placeholder">placeholder</p>
    <p class="sim-text sim-text--disabled">disabled</p>
    <p class="sim-text sim-text--selected">selected</p>
  </div>
</div>
<p class="sim-note">Предпросмотр HTML-симулятора (внешний вид iOS / SwiftUI), не рендеринг на реальном устройстве</p>

## Выравнивание и высота строки

`lhAlign` выравнивает внутри строкового бокса; высота строки всегда `typography.lineHeight.primary` (размер × 1,8).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">center</p>
    <p class="sim-text sim-text--align-end">end</p>
  </div>
</div>
<p class="sim-note">Предпросмотр HTML-симулятора (внешний вид iOS / SwiftUI), не рендеринг на реальном устройстве</p>

```swift
LhText("Centered", lhAlign: .center)
```

## API

| Свойство | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `content` | содержимое текста (первый аргумент инициализатора, слот default в spec) | `String` | `""` |
| `level` | Уровни размера | `LhTextLevel` | `.base` |
| `weight` | Начертание | `LhTextWeight` | `.primary` |
| `tone` | Тон | `LhTextTone` | `.primary` |
| `lhAlign` | Выравнивание и высота строки | `LhTextAlign` | `.start` |

### LhTextLevel

| Свойство | fontSize token |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge` (20pt) |
| `.large` | `typography.fontSize.large` (18pt) |
| `.medium` | `typography.fontSize.medium` (16pt) |
| `.base` | `typography.fontSize.base` (14pt, default) |
| `.small` | `typography.fontSize.small` (13pt) |
| `.extraSmall` | `typography.fontSize.extraSmall` (12pt) |

### LhTextTone

| Свойство | text color token |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## Справочник токенов

| Token | Usage |
| --- | --- |
| `typography.fontSize.<level>` | six size levels |
| `typography.fontWeight.{primary,bold}` | two weights |
| `typography.lineHeight.primary` | line height (font size × 1.8) |
| `color.text.<tone>` / `color.selected` | text tones |

## Справочник золотых случаев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `default-level-uses-base-tokens` | default level consumes the base typography tokens | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | large level consumes the large size token | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | bold consumes the bold weight token | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | secondary tone takes the secondary text color token | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | render emits a single TEXT command | `LhTextTests.testAllLevelsUseTheirTokens` |

```bash
swift test --filter LhTextTests
```
