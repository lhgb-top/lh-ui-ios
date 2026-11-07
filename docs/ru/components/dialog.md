# Диалог

Декларативное модальное окно. Видимость управляется через `@Binding var visible`: маска + центрированная панель, кнопки переиспользуют `LhButton`.

> Источник контракта: `lh-ui-core/specs/dialog.json` ·
> Золотые сценарии: `lh-ui-core/cases/dialog.json` (8 шт., переведены в XCTest, запускаются на хосте macOS)

## Типы

Шесть типов определяют семантический цвет кнопки подтверждения (маппинг `buttonType(for:)` в `LhButtonType`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Типы Dialog</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Диалог по умолчанию</button>
      <button class="sim-btn sim-btn--danger">Опасный диалог</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Подтвердите удаление</div>
    <div class="sim-dialog__content">Этот элемент будет удалён без возможности восстановления. Продолжить?</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Отмена</button>
      <button class="sim-btn sim-btn--danger">Подтвердить</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "Подтвердите удаление",
  content: "Этот элемент будет удалён без возможности восстановления. Продолжить?",
  type: .danger,
  confirmText: "Подтвердить",
  cancelText: "Отмена"
)
```

## Видимость и обратные вызовы

- `visible = true` отрисовывает маску и панель; `visible = false` не отправляет ни одной команды отрисовки (золотой сценарий `hidden-not-rendered`).
- Нажатие «Подтвердить» последовательно вызывает `onConfirm` и `onClose` (`confirm-also-emits-onclose`).
- Нажатие «Отмена» вызывает `onCancel`; возврат `visible` в `false` выполняется внутри компонента в `onClose` (внутри `withAnimation`).
- При `closable = true` нажатие на маску также вызывает `onClose` (`closable-overlay-emits-onclose`); по умолчанию окно не закрывается (`not-closable-blocks-overlay-close`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dialog: закрытие по маске</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Подсказка</div>
    <div class="sim-dialog__content">Нажмите на маску, чтобы закрыть</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Отмена</button>
      <button class="sim-btn sim-btn--primary">Подтвердить</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве</p>

## API

### Пропы

| Проп | Описание | Тип | По умолчанию |
| --- | --- | --- | --- |
| `visible` | Видимо ли окно (управляемая двусторонняя привязка) | `Bool` | — |
| `title` | Заголовок | `String` | `""` |
| `content` | Основной текст | `String` | `""` |
| `type` | Тип диалога, определяет семантический цвет кнопки подтверждения | `LhDialogType` | `.default` |
| `confirmText` | Текст кнопки подтверждения; `nil` (по умолчанию) берётся из языкового пакета, `""` скрывает кнопку | `String?` | Языковой пакет (упрощённый китайский `"确认"`) |
| `cancelText` | Текст кнопки отмены; `nil` (по умолчанию) берётся из языкового пакета, `""` скрывает кнопку | `String?` | Языковой пакет (упрощённый китайский `"取消"`) |
| `closable` | Можно ли закрыть окно нажатием на маску | `Bool` | `false` |
| `onConfirm` | Обратный вызов подтверждения | `(() -> Void)?` | `nil` |
| `onCancel` | Обратный вызов отмены | `(() -> Void)?` | `nil` |
| `onClose` | Обратный вызов закрытия (срабатывает при нажатии на маску, кнопке «Отмена» и кнопке «Подтвердить») | `(() -> Void)?` | `nil` |

### LhDialogType

| Значение | Тип кнопки подтверждения | Фон |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + обводка |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## Соответствие токенов

| Токен | Назначение |
| --- | --- |
| `dialog.width` | Ширина панели (320pt) |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | Внутренние отступы панели |
| `dialog.borderRadius` | Скругление панели |
| `dialog.titleFontSize` / `dialog.contentFontSize` | Размеры шрифта заголовка и основного текста |
| `dialog.gap` | Вертикальные расстояния между блоками |
| `color.background.overlay` | Цвет маски |
| `color.background.default` | Цвет фона панели |
| `color.text.{primary,regular}` | Цвета заголовка и основного текста |
| `shadow.base` | Тень панели (носитель LhShadow) |
| `zIndex.{modalBackdrop,modal}` | Уровни маски и панели |

## Соответствие золотых сценариев

| case id | Утверждение | Локальный тест |
| --- | --- | --- |
| `confirm-emits-onconfirm` | Подтверждение вызывает onConfirm | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | Отмена вызывает onCancel | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | Подтверждение также вызывает onClose | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | Нажатие на маску вызывает onClose | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | По умолчанию маска не закрывает окно | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | В скрытом состоянии ничего не рендерится | `testHiddenNotRendered` |
| `title-renders-text` | Заголовок корректно отрисовывается | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | Тип danger потребляет токен цвета danger | `testDangerTypeUsesDangerToken` |

Дополнительно: `testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`.

```bash
swift test --filter LhDialogTests    # достаточно хоста macOS, эмулятор не нужен
```
