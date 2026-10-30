# Быстрый старт

## Минимальный пример

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* обработка нажатия */ },
        type: .primary,
        text: "Основная кнопка"
      )
    }
  }
}
```

`LhTheme` — контейнер темы: все компоненты Lh внутри автоматически потребляют токены через Environment; без обёртки используется светлая палитра.

## Типы и размеры

```swift
// Шесть типов
LhButton(lhOnClick: {}, text: "По умолчанию")                      // .default
LhButton(lhOnClick: {}, type: .primary, text: "Основная")
LhButton(lhOnClick: {}, type: .success, text: "Успех")
LhButton(lhOnClick: {}, type: .warning, text: "Предупреждение")
LhButton(lhOnClick: {}, type: .danger, text: "Опасность")
LhButton(lhOnClick: {}, type: .info, text: "Информация")

// Три размера
LhButton(lhOnClick: {}, lhSize: .small, text: "Маленькая")
LhButton(lhOnClick: {}, lhSize: .medium, text: "Средняя")
LhButton(lhOnClick: {}, lhSize: .large, text: "Большая")
```

## Состояния

```swift
// Отключено: не реагирует на нажатия, показывает отключённый стиль
LhButton(lhOnClick: {}, disabled: true, text: "Отключена")

// Загрузка: показывает индикатор, lhOnClick не вызывается
LhButton(lhOnClick: {}, loading: true, text: "Загрузка")

// Оба состояния: отключение обрабатывается в приоритете (золотой сценарий disabled-precedes-loading)
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "Отключена приоритетно")
```

## Иконки и узорный фон

```swift
// Имя иконки разрешается через локальную систему иконок (маппинг SF Symbol см. в LhButtonStyle.icon(for:), незарегистрированные имена не отрисовываются)
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "Поиск")

// Узорный фон в китайском стиле (потребляет токен color.decoration)
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "Узорный фон")
```

## Светлая и тёмная темы

```swift
LhTheme(isDark: isDark) {
  // Все компоненты внутри автоматически переключаются на тёмные токены (значения предвычислены в core, вычислений цвета в рантайме нет)
}
```

## Предпросмотр компонентов

Нативный UI нельзя отрендерить в браузере в реальном времени, поэтому этот сайт показывает внешний вид через **встроенный статичный HTML-симулятор в рамке телефона**:

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">По умолчанию</button>
      <button class="sim-btn sim-btn--primary">Основная кнопка</button>
      <button class="sim-btn sim-btn--success">Успех</button>
      <button class="sim-btn sim-btn--warning">Предупреждение</button>
      <button class="sim-btn sim-btn--danger">Опасность</button>
      <button class="sim-btn sim-btn--info">Информация</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Маленькая</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">Большая</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Отключена</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Загрузка
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Поиск</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Узорный фон</button>
    </div>
  </div>
</div>
<p class="sim-note">HTML-симулятор внешнего вида iOS (SwiftUI), а не рендеринг на реальном устройстве; все значения стилей взяты из снимка токенов core и совпадают с устройством. За эталон внешнего вида принимаются <code>#Preview</code> и снимки с устройства.</p>

> Тёмный режим симулятора синхронизирован с сайтом: переключите тему в правом верхнем углу, и цвета в рамке телефона изменятся (тёмные токены предвычислены в core).
