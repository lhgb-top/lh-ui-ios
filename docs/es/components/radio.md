# Botón de radio

Botón de radio controlado. `@Binding var checked` indica «si este elemento está seleccionado»; normalmente se usa junto con un grupo, y dentro de un mismo grupo solo un elemento puede ser `true`.

> Fuente del contrato: `lh-ui-core/specs/radio.json` ·
> Casos dorados: `lh-ui-core/cases/radio.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Estados

El estado seleccionado es un anillo con borde del color principal + punto relleno del color principal; el estado no seleccionado es un anillo vacío con borde. El diámetro del punto es el tamaño multiplicado por `radio.dotScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Estados de Radio</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>No seleccionado</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Seleccionado</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Seleccionado deshabilitado</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>No seleccionado deshabilitado</span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷 (porcelana azul y blanco)") { _ in
  picked = "blue"
}
```

## Tamaños

Tres tamaños se mapean al token `radio.size`; el borde del anillo toma `radio.ringWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Radio</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>Pequeño</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Mediano</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>Grande</span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Barrera de pulsación

Si ya está seleccionado, una pulsación mantiene la selección y no dispara `onChange` (caso dorado `tap-checked-keeps-checked`);
el estado deshabilitado tampoco lo dispara (`disabled-blocks-change`). El contenedor de grupo queda para una versión posterior.

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `checked` | Si este elemento está seleccionado (enlace bidireccional controlado) | `Bool` | — |
| `value` | Valor que representa este elemento (junto con `checked` implementa un grupo de selección única) | `String` | `""` |
| `disabled` | Si está deshabilitado (no dispara onChange) | `Bool` | `false` |
| `lhSize` | Tamaño del botón de radio, mapeado a los tokens de tamaño | `LhRadioSize` | `.medium` |
| `label` | Etiqueta de texto | `String` | `""` |
| `onChange` | Devolución de llamada de cambio de selección; el payload es el nuevo valor | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| Valor | Tamaño del anillo | Diámetro del punto |
| --- | --- | --- |
| `.small` | `radio.size.small` (16pt) | tamaño × `radio.dotScale` (8pt) |
| `.medium` | `radio.size.medium` (20pt) | tamaño × `radio.dotScale` (10pt) |
| `.large` | `radio.size.large` (24pt) | tamaño × `radio.dotScale` (12pt) |

### Colores

| Estado | Borde del anillo | Punto |
| --- | --- | --- |
| No seleccionado | `color.border.base` (`radio.ringWidth`) | — |
| Seleccionado | `color.primary.default` | `color.primary.default` |
| Deshabilitado | `color.disabled.border` | `color.disabled.text` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `radio.size.{small,medium,large}` | Tres tamaños de anillo |
| `radio.dotScale` | Proporción del punto respecto al tamaño del anillo (50%) |
| `radio.ringWidth` | Ancho del borde del anillo |
| `radio.gap` | Espacio entre el anillo y el texto (sigue `spacing.sm`) |
| `color.primary.default` | Color del borde y del punto del estado seleccionado |
| `color.border.base` | Color del borde del estado no seleccionado |
| `color.disabled.{border,text}` | Color del borde y del punto del estado deshabilitado |
| `color.text.{primary,disabled}` | Color del texto de la etiqueta |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | Una pulsación en un elemento no seleccionado dispara `onChange(true)` | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | Una pulsación en un elemento seleccionado lo mantiene y no dispara la devolución de llamada | `testCheckedShowsDot` |
| `disabled-blocks-change` | El estado deshabilitado no dispara onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | El estado seleccionado consume los tokens del color principal | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | El estado no seleccionado consume el token de borde | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | El tamaño pequeño consume el token de tamaño small | `testSmallSizeUsesSmallToken` |

Además, pruebas específicas: `testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`.

```bash
swift test --filter LhRadioTests    # basta con el host macOS, no hace falta simulador
```
