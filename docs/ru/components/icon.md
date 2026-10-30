# Значок

Векторный значок. Логическое имя отображается на системный символ платформы (на iOS — SF Symbol), размер и тон полностью определяются токенами.

> Источник контракта: `lh-ui-core/specs/icon.json` ·
> Золотые сценарии: `lh-ui-core/cases/icon.json` (5 шт., переведены в XCTest, запускаются на хосте macOS)

## Тон

`tone` определяет цвет значка. `default` следует основному цвету текста, `regular` / `secondary` берут соответствующий уровень текста, остальные — семантические цвета.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Тон Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве; на устройстве рисуются векторные SF Symbol</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## Размеры

Три размера отображаются на токены `icon.size`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Размеры Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Маппинг имён значков

`name` — логическое имя, выровненное с направлением web; на стороне платформы оно отображается на SF Symbol через `LhIconMap.symbol(for:)`:

| Логическое имя | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

Незарегистрированные имена не отрисовываются (возвращается `nil`), падений не происходит.

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `name` | Логическое имя значка (маппится на SF Symbol через `LhIconMap`) | `String` | — |
| `lhSize` | Размер значка, отображается на токены размеров | `LhIconSize` | `.medium` |
| `tone` | Тон значка, отображается на токены цветов текста/семантических | `LhIconTone` | `.default` |
| `lhOnClick` | Обратный вызов при нажатии; если не передан, нажатия не обрабатываются | `(() -> Void)?` | `nil` |

### LhIconSize

| Значение | Размер |
| --- | --- |
| `.small` | `icon.size.small` (16pt) |
| `.medium` | `icon.size.medium` (20pt) |
| `.large` | `icon.size.large` (24pt) |

### LhIconTone

| Значение | Цвет |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `icon.size.{small,medium,large}` | Три размера |
| `color.text.{primary,regular,secondary}` | Тона текста |
| `color.{primary,success,warning,danger,info}.default` | Семантические тона |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `click-emits-onclick` | Нажатие вызывает `lhOnClick` один раз | уровень View: `onTapGesture` (утверждение жестов требует эмулятора, см. #Preview) |
| `default-tone-uses-text-primary` | Тон по умолчанию берёт основной цвет текста | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | Тон primary берёт токен основного цвета | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | Маленький размер берёт токен размера small | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | Ровно одна команда отрисовки значка | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

Дополнительно по тёмному режиму: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhIconTests    # достаточно хоста macOS, эмулятор не нужен
```
