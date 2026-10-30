# Панель навигации

Панель навигации в верхней части страницы. Заголовок по центру + содержимое по обеим сторонам, разделительная линия снизу, уровень берётся из `zIndex.sticky`.

> Источник контракта: `lh-ui-core/specs/navbar.json` ·
> Золотые сценарии: `lh-ui-core/cases/navbar.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Основная форма

`title` отображается по центру (абсолютное позиционирование, не перекрывается содержимым по краям); `leftText` / `rightText` прижимаются к левому и правому краям.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar: основы</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">Назад</span>
    <span class="sim-navbar__title">青花瓷 (сине-белый фарфор)</span>
    <span class="sim-navbar__side">Ещё</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">Содержимое страницы</span></div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhNavbar(
  title: "青花瓷 (сине-белый фарфор)",
  leftText: "Назад",
  rightText: "Ещё",
  onLeftClick: { /* назад */ },
  onRightClick: { /* ещё */ }
)
```

## Иконки и обводка

`leftIcon` / `rightIcon` проходят через маппинг `LhIconMap` и отображаются рядом с текстом; `bordered = false` убирает разделительную линию снизу.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar: иконки</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>Назад</span>
    </span>
    <span class="sim-navbar__title">Заголовок</span>
    <span class="sim-navbar__side">
      <span>Настройки</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">Панель без обводки</span></div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Гейт нажатия

Если `leftText` / `leftIcon` не заданы, левая сторона не реагирует на нажатия (золотой сценарий `no-left-content-no-onleftclick`),
для правой стороны действует то же правило. Плавающее позиционирование выполняется вызывающей стороной через `.overlay`
(соглашение SwiftUI), сам компонент предоставляет уровень `zIndex.sticky`.

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷 (сине-белый фарфор)", leftText: "Назад", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `title` | Заголовок по центру | `String` | `""` |
| `leftText` | Текст слева (не реагирует на нажатия, если пусто и нет leftIcon) | `String` | `""` |
| `leftIcon` | Логическое имя иконки слева (маппинг `LhIconMap`) | `String?` | `nil` |
| `rightText` | Текст справа (не реагирует на нажатия, если пусто и нет rightIcon) | `String` | `""` |
| `rightIcon` | Логическое имя иконки справа | `String?` | `nil` |
| `bordered` | Показывать ли разделительную линию снизу | `Bool` | `true` |
| `onLeftClick` | Обратный вызов нажатия на левую сторону | `(() -> Void)?` | `nil` |
| `onRightClick` | Обратный вызов нажатия на правую сторону | `(() -> Void)?` | `nil` |

### Цвета

| Область | Цвет |
| --- | --- |
| Фон | `color.background.default` |
| Заголовок / текст по краям / иконки | `color.text.primary` |
| Разделительная линия | `color.border.lighter` (ширина берётся из `navbar.borderWidth`) |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `navbar.height` | Высота панели навигации (44pt) |
| `navbar.paddingHorizontal` | Горизонтальные отступы по краям (12pt) |
| `navbar.titleFontSize` | Размер шрифта заголовка и текста по краям (16pt) |
| `navbar.iconSize` | Размер иконок по краям (20pt) |
| `navbar.borderWidth` | Толщина разделительной линии снизу |
| `color.border.lighter` | Цвет разделительной линии |
| `color.text.primary` | Цвет заголовка и содержимого по краям |
| `color.background.default` | Цвет фона |
| `zIndex.sticky` | Уровень при плавающем размещении |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `title-renders-text` | Заголовок корректно отрисовывается | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | Нажатие слева вызывает onLeftClick | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | Нажатие справа вызывает onRightClick | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | Без содержимого слева вызова не происходит | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | Разделительная линия потребляет токен border.lighter | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | Высота потребляет токен navbar.height | `testHeightUsesNavbarHeightToken` |

Дополнительно: `testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`.

```bash
swift test --filter LhNavbarTests    # достаточно хоста macOS, эмулятор не нужен
```
