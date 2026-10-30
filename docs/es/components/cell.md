# Celda

Celda de lista. Icono a la izquierda + título (con asterisco rojo de obligatorio y subtítulo), valor y flecha a la derecha, línea separadora en la parte inferior.

> Fuente del contrato: `lh-ui-core/specs/cell.json` ·
> Casos dorados: `lh-ui-core/cases/cell.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Uso básico

`title` es obligatorio; `value` / `label` / `icon` son opcionales. `bordered` controla la línea separadora inferior (activada por defecto).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell básica</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">Texto del título</div></div>
      <div class="sim-cell__value">Valor derecho</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">Con subtítulo</div>
        <div class="sim-cell__label">Este es el texto del subtítulo</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">Sin separadora</div></div>
      <div class="sim-cell__value">Valor</div>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhCell(title: "Texto del título", value: "Valor derecho", clickable: true) {
  // lhOnClick
}
```

## Icono / obligatorio / no clicable

`icon` pasa por el mapeo `LhIconMap`; `required` muestra un asterisco rojo antes del título;
con `clickable = false` (predeterminado) no responde a la pulsación (caso dorado `not-clickable-no-onclick`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell extendida</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">Icono a la izquierda</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>Campo obligatorio</div></div>
      <div class="sim-cell__value">Seleccione</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `title` | Título (obligatorio) | `String` | — |
| `value` | Valor derecho | `String` | `""` |
| `label` | Subtítulo bajo el título | `String` | `""` |
| `icon` | Nombre lógico del icono izquierdo (mapeo `LhIconMap`) | `String?` | `nil` |
| `bordered` | Si se muestra la línea separadora inferior | `Bool` | `true` |
| `clickable` | Si es clicable (controla la flecha y la barrera de pulsación) | `Bool` | `false` |
| `required` | Si se muestra el asterisco rojo de obligatorio antes del título | `Bool` | `false` |
| `lhOnClick` | Devolución de llamada al pulsar; no se dispara con `clickable = false` | `(() -> Void)?` | `nil` |

### Jerarquía de texto

| Zona | Tamaño de fuente | Color |
| --- | --- | --- |
| Título | `cell.fontSizeTitle` (14pt) | `color.text.primary` |
| Subtítulo | `cell.fontSizeLabel` (13pt) | `color.text.secondary` |
| Valor derecho | `cell.fontSizeValue` (14pt) | `color.text.secondary` |
| Asterisco de obligatorio | `cell.fontSizeTitle` | `color.danger.default` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | Relleno (sigue `spacing.base` / `spacing.sm`) |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | Tres niveles de tamaño de fuente |
| `cell.iconSize` | Tamaño del icono izquierdo |
| `cell.gap` | Espacio entre bloques (sigue `spacing.sm`) |
| `cell.borderWidth` | Ancho de la línea separadora inferior |
| `color.border.lighter` | Color de la línea separadora inferior |
| `color.text.{primary,secondary}` | Colores del título y del valor / subtítulo |
| `color.danger.default` | Color del asterisco de obligatorio |
| `color.background.default` | Color de fondo de la celda |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `title-and-value-render` | Se dibujan el título y el valor a la vez | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | El subtítulo toma el color de texto secundario | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | El asterisco de obligatorio toma el token de color de peligro | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | La línea separadora consume el token border.lighter | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | Al ser clicable se dispara lhOnClick | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | Al no ser clicable no se dispara lhOnClick | `testNotClickableIsNotInteractive` |

Además, pruebas específicas de modo oscuro: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`.

```bash
swift test --filter LhCellTests    # basta con el host macOS, no hace falta simulador
```
