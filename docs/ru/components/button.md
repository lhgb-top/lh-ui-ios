# Кнопка

Базовая кнопка действия. Запускает немедленное действие; поддерживает типы, размеры, загрузку, отключение, иконки и узорный фон в китайском стиле.

> Источник контракта: `lh-ui-core/specs/button.json` ·
> Золотые сценарии: `lh-ui-core/cases/button.json` (8 шт., переведены в XCTest, запускаются на хосте macOS)

## Типы

Шесть типов определяют цвет фона и цвет текста.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Типы Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">По умолчанию</button>
      <button class="sim-btn sim-btn--primary">Основная</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">Успешная</button>
      <button class="sim-btn sim-btn--warning">Предупреждающая</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">Опасная</button>
      <button class="sim-btn sim-btn--info">Информационная</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "Основная кнопка")
```

## Размеры

Три размера отображаются на токены `button.height` / `paddingHorizontal` / `fontSize` / `iconSize`.
На iOS используется форма с капсульным скруглением (токен `radius.round`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Размеры Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Маленькая кнопка</button>
      <button class="sim-btn">Средняя кнопка</button>
      <button class="sim-btn sim-btn--large">Большая кнопка</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Состояния

Отключение и загрузка не вызывают `lhOnClick`; при одновременном действии обоих состояний **отключение обрабатывается в приоритете** (золотой сценарий `disabled-precedes-loading`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Состояния Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Нормальная</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Отключена</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Загрузка
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Отключена приоритетно</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Иконки и узорный фон

Имя иконки разрешается через локальную систему иконок (`LhButtonStyle.icon(for:)` маппит SF Symbol: search → magnifyingglass,
refresh → arrow.clockwise, check → checkmark, close → xmark; незарегистрированные имена не отрисовываются).
Узорный фон потребляет токен `color.decoration`: Canvas рисует диагональные линии под 45°,
которые накладываются под фон и над текстом, не ухудшая контрастность.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Иконки и узор</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Поиск</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>По умолчанию</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Основной узорный фон</button>
      <button class="sim-btn sim-btn--pattern">Обычный узорный фон</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Светлая и тёмная темы

Переключите тему сайта в правом верхнем углу — цвета кнопок в рамке симулятора изменятся; на устройстве переключение выполняется через `LhTheme(isDark: true)`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Тёмные кнопки</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Основная кнопка</button>
      <button class="sim-btn">По умолчанию</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Отключена</button>
      <button class="sim-btn sim-btn--success">Успех</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве; светлые/тёмные значения взяты из снимка токенов core</p>

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `lhOnClick` | Обратный вызов при нажатии; не вызывается, если `disabled` или `loading` равно true | `() -> Void` | — |
| `type` | Тип кнопки, определяет цвет фона и текста | `LhButtonType` | `.default` |
| `lhSize` | Размер кнопки, отображается на токены размеров | `LhButtonSize` | `.medium` |
| `disabled` | Отключена ли кнопка | `Bool` | `false` |
| `loading` | Идёт ли загрузка (показывает индикатор, lhOnClick не вызывается) | `Bool` | `false` |
| `icon` | Имя иконки (разрешается через маппинг SF Symbol) | `String?` | `nil` |
| `bgPattern` | Рисовать ли узорный фон в китайском стиле | `Bool` | `false` |
| `label` / `text` | Текст кнопки (слот default из спецификации) | `Text` / строка | — |

### LhButtonType

| Значение | Фон | Текст |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| Значение | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small` (32pt) | `button.paddingHorizontal.small` (16pt) | `button.fontSize.small` (13pt) | `button.iconSize.small` (16pt) |
| `.medium` | `button.height.medium` (40pt) | `button.paddingHorizontal.medium` (20pt) | `button.fontSize.medium` (14pt) | `button.iconSize.medium` (18pt) |
| `.large` | `button.height.large` (48pt) | `button.paddingHorizontal.large` (24pt) | `button.fontSize.large` (16pt) | `button.iconSize.large` (20pt) |

Переопределение отключённого состояния: фон `color.disabled.bg`, текст `color.disabled.text`, обводка `color.disabled.border`.

## Соответствие токенов

Токены, потребляемые кнопкой (построчно выровнены с `tokenRefs` из `specs/button.json`):

| Токен | Назначение |
| --- | --- |
| `button.height.{small,medium,large}` | Высота трёх размеров |
| `button.paddingHorizontal.{small,medium,large}` | Горизонтальные внутренние отступы трёх размеров |
| `button.fontSize.{small,medium,large}` | Размер шрифта трёх размеров |
| `button.iconSize.{small,medium,large}` | Размер иконки трёх размеров |
| `button.borderRadius` / `button.borderWidth` | Скругление (следует `radius.base`) и толщина обводки |
| `button.fontWeight` | Жирность шрифта (следует `typography.fontWeight.primary`, на стороне платформы маппится в Font.Weight) |
| `color.primary.default` / `color.onPrimary` | Фон/текст типа primary |
| `color.{success,warning,danger,info}.default` | Фон семантических типов |
| `color.background.default` / `color.text.primary` / `color.border.base` | Фон/текст/обводка типа по умолчанию |
| `color.disabled.{bg,text,border}` | Три цвета отключённого состояния |
| `color.decoration` | Цвет узорного фона |
| `shadow.lighter` | elevation по умолчанию (носитель LhShadow) |
| `spacing.xs` | Расстояние между иконкой и текстом |

## Соответствие золотых сценариев

Соответствие 8 утверждений из `cases/button.json` и XCTest:

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `click-emits-onclick` | Гейт пропускает (интерактивно) | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | Отключённое состояние не интерактивно | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | Состояние загрузки не интерактивно | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | Отключение в приоритете + отключённый стиль | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | Тип по умолчанию — нейтральный фон/текст | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | Тип primary потребляет токены основного цвета | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | Маленький размер потребляет токены размера small | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | Узорный фон потребляет декоративный цвет | `testBgPatternUsesDecorationToken` |

Дополнительно по тёмному режиму: `testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test    # достаточно хоста macOS, эмулятор не нужен
```
