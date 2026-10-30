# Casilla de verificación

Casilla de verificación controlada. `@Binding var checked` ofrece un enlace bidireccional y admite tres estados (marcada / desmarcada / indeterminada).

> Fuente del contrato: `lh-ui-core/specs/checkbox.json` ·
> Casos dorados: `lh-ui-core/cases/checkbox.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Estados

El estado marcado es un cuadrado relleno del color principal + marca de verificación blanca; el estado indeterminado es un cuadrado relleno del color principal + barra blanca; el estado desmarcado es un recuadro vacío con borde.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Estados de Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>Desmarcada</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Marcada</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>Indeterminada</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Deshabilitada</span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Marcada") { newValue in
  // onChange
}
```

## Tamaños

Tres tamaños se mapean al token `checkbox.size`; el ancho del trazo de la marca toma `checkbox.checkWidth`,
y la barra del estado indeterminado tiene un ancho igual al tamaño del cuadro multiplicado por `checkbox.dashScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Pequeña</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Mediana</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Grande</span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Estado indeterminado

Con `indeterminate = true` no se muestra la marca de verificación, sino una barra; al pulsar siempre pasa a **marcada** (caso dorado
`indeterminate-becomes-checked`), en lugar de alternar.

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Seleccionar todo", indeterminate: somePartial) { _ in }
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `checked` | Estado de marcado (enlace bidireccional controlado) | `Bool` | — |
| `indeterminate` | Si está en estado indeterminado (muestra una barra; al pulsar pasa a marcada) | `Bool` | `false` |
| `disabled` | Si está deshabilitada (no dispara onChange) | `Bool` | `false` |
| `lhSize` | Tamaño de la casilla, mapeado a los tokens de tamaño | `LhCheckboxSize` | `.medium` |
| `label` | Etiqueta de texto | `String` | `""` |
| `onChange` | Devolución de llamada de cambio de estado; el payload es el nuevo valor | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| Valor | Tamaño |
| --- | --- |
| `.small` | `checkbox.size.small` (16pt) |
| `.medium` | `checkbox.size.medium` (20pt) |
| `.large` | `checkbox.size.large` (24pt) |

### Colores

| Estado | Fondo del cuadro | Color de la marca |
| --- | --- | --- |
| Desmarcada | Transparente + borde `color.border.base` (`checkbox.borderWidth`) | — |
| Marcada / indeterminada | `color.primary.default` | `color.onPrimary` |
| Deshabilitada | `color.disabled.bg` + borde `color.disabled.border` | `color.disabled.text` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `checkbox.size.{small,medium,large}` | Tres tamaños |
| `checkbox.borderRadius` / `checkbox.borderWidth` | Radio de esquina (sigue `radius.small`) y ancho del borde |
| `checkbox.checkWidth` | Ancho del trazo de la marca de verificación |
| `checkbox.dashScale` | Proporción de la barra indeterminada respecto al cuadro (50%) |
| `checkbox.gap` | Espacio entre el cuadro y el texto (sigue `spacing.sm`) |
| `color.primary.default` / `color.onPrimary` | Colores de fondo / marca del estado marcado |
| `color.border.base` | Color del borde del estado desmarcado |
| `color.disabled.{bg,border,text}` | Tres colores del estado deshabilitado |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | La pulsación alterna y dispara `onChange(true)` | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | Una casilla marcada pasa a desmarcada al pulsar | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | El estado deshabilitado no dispara onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | El estado marcado consume primary y onPrimary | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | El estado desmarcado consume el token de borde | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | Tras una pulsación en estado indeterminado siempre queda marcada | `testIndeterminateBecomesChecked` |

Además, pruebas específicas: `testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`.

```bash
swift test --filter LhCheckboxTests    # basta con el host macOS, no hace falta simulador
```
