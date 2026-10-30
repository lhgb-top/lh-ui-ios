# Toast (короткое уведомление)

Декларативное короткое уведомление. Видимость управляется через `@Binding var visible`, по истечении времени оно исчезает автоматически, тёмный фон берётся из токена `color.ink`.

> Источник контракта: `lh-ui-core/specs/toast.json` ·
> Золотые сценарии: `lh-ui-core/cases/toast.json` (6 шт., переведены в XCTest, запускаются на хосте macOS)

## Типы

Тип по умолчанию без иконки; остальные типы показывают слева от текста точку семантического цвета. Тёмный фон + белый текст, контрастность обеспечивает `color.ink`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast: типы</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">По умолчанию</button></div>
  </div>
  <div class="sim-toast">Сохранено</div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast: семантика</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">Успех</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>Операция выполнена</div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "Сохранено", type: .success)
```

## Позиционирование

Три варианта позиционирования: `top` (сверху), `center` (по центру, по умолчанию), `bottom` (снизу).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast: позиционирование</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Позиция bottom</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>Нижнее уведомление</div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## Автоматическое скрытие

Когда `visible` становится `true`, запускается таймер `.task`, через `duration` миллисекунд значение автоматически возвращается в `false` и вызывается `onClose`
(золотой сценарий `auto-hides-after-duration`); до истечения таймера уведомление остаётся видимым и обратный вызов не вызывается
(`tick-before-duration-keeps-visible`); внешняя ручная установка `false` не вызывает обратный вызов (`hide-is-silent`).

::: tip Единицы измерения длительности
Токен `toast.duration` указан в миллисекундах (2000), а SwiftUI `Task.sleep` требует секунды, поэтому на стороне платформы выполняется
преобразование `Double(duration) / 1000` (см. `LhToastStyle`).
:::

```swift
LhToast(visible: $visible, text: "Операция выполнена", type: .success, duration: 2000) {
  // onClose (вызывается только при автоматическом скрытии)
}
```

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `visible` | Видимо ли уведомление (управляемая двусторонняя привязка, по истечении времени автоматически возвращается в false) | `Bool` | — |
| `text` | Текст уведомления | `String` | — |
| `type` | Тип уведомления, определяет, показывать ли точку и её цвет | `LhToastType` | `.default` |
| `lhPosition` | Позиция отображения | `LhToastPosition` | `.center` |
| `duration` | Длительность отображения (миллисекунды) | `Int` | `2000` (берётся из токена `toast.duration`) |
| `onClose` | Обратный вызов автоматического скрытия (не вызывается при внешнем ручном скрытии) | `(() -> Void)?` | `nil` |

### LhToastType

| Значение | Цвет точки |
| --- | --- |
| `.default` | Без точки |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| Значение | Позиционирование |
| --- | --- |
| `.top` | Сверху (отступ `spacing.xl`) |
| `.center` | По центру |
| `.bottom` | Снизу (отступ `spacing.xl`) |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | Внутренние отступы |
| `toast.fontSize` | Размер шрифта текста уведомления |
| `toast.borderRadius` | Скругление (следует `radius.small`) |
| `toast.gap` | Расстояние между точкой и текстом |
| `toast.duration` | Длительность отображения по умолчанию (миллисекунды) |
| `color.ink` | Тёмный фон (в тёмном режиме имеет отдельное переопределение, отделяющее его от фона страницы) |
| `color.onPrimary` | Белый текст |
| `color.{success,warning,danger,info}.default` | Семантические цвета точки |
| `zIndex.toast` | Уровень |
| `spacing.xl` | Отступы при позиционировании сверху/снизу |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `show-makes-visible` | При отображении сразу рендерится | `testShowMakesVisible` |
| `auto-hides-after-duration` | По истечении времени автоматически скрывается и вызывает onClose | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | До истечения таймера остаётся видимым | `testVisibleDuringDuration` |
| `hide-is-silent` | Внешнее ручное скрытие не вызывает обратный вызов | `testHideIsSilent` |
| `success-type-uses-success-token` | Тип success потребляет токены цвета успеха и ink | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | В скрытом состоянии команды отрисовки пусты | `testHiddenNotRendered` |

Дополнительно: `testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`.

```bash
swift test --filter LhToastTests    # достаточно хоста macOS, эмулятор не нужен
```
