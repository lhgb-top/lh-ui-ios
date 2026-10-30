# Interruptor

Interruptor controlado. `@Binding var checked` ofrece un enlace bidireccional; la pista tiene proporción 2:1 y el diámetro del pulgar = altura − 2 × `switch.gap`.

> Fuente del contrato: `lh-ui-core/specs/switch.json` ·
> Casos dorados: `lh-ui-core/cases/switch.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Estados

Activado: la pista toma el color principal y el pulgar se desplaza a la derecha; desactivado: la pista toma el color del borde. El estado `loading` muestra un indicador pequeño dentro de la pista y no responde al cambio.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Estados de Switch</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row">
      <span class="sim-switch sim-switch--on sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## Tamaños

Tres tamaños se mapean a los tokens `switch.width` / `switch.height`; el radio de esquina pasa automáticamente a ser el radio de la pista según la altura.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Switch</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Estado de carga

Con `loading = true`, la pista integra un `LhLoading(lhSize: .small, tone: .primary)` y la pulsación es interceptada por la barrera
(caso dorado `loading-blocks-change`).

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `checked` | Estado del interruptor (enlace bidireccional controlado) | `Bool` | — |
| `disabled` | Si está deshabilitado (no dispara onChange) | `Bool` | `false` |
| `loading` | Si está cargando (indicador integrado; no dispara onChange) | `Bool` | `false` |
| `lhSize` | Tamaño del interruptor, mapeado a los tokens de tamaño | `LhSwitchSize` | `.medium` |
| `onChange` | Devolución de llamada de cambio de estado; el payload es el nuevo valor | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| Valor | width | height | Diámetro del pulgar |
| --- | --- | --- | --- |
| `.small` | `switch.width.small` (36pt) | `switch.height.small` (20pt) | height − 2 × `switch.gap` (16pt) |
| `.medium` | `switch.width.medium` (44pt) | `switch.height.medium` (24pt) | height − 2 × `switch.gap` (20pt) |
| `.large` | `switch.width.large` (52pt) | `switch.height.large` (28pt) | height − 2 × `switch.gap` (24pt) |

### Colores

| Estado | Pista | Pulgar |
| --- | --- | --- |
| Desactivado | `color.border.base` | `color.onPrimary` |
| Activado | `color.primary.default` | `color.onPrimary` |
| Deshabilitado | `color.disabled.bg` | `color.disabled.text` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `switch.width.{small,medium,large}` | Tres anchos de pista |
| `switch.height.{small,medium,large}` | Tres alturas de pista |
| `switch.gap` | Espacio interior entre el pulgar y la pista (determina el diámetro del pulgar) |
| `color.primary.default` | Color de la pista activada |
| `color.border.base` | Color de la pista desactivada |
| `color.onPrimary` | Color del pulgar |
| `color.disabled.{bg,text}` | Dos colores del estado deshabilitado |
| `motion.duration.base` | Duración de la animación de deslizamiento del pulgar (en segundos en el extremo iOS) |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | La pulsación activa y dispara `onChange(true)` | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | Una pulsación estando activado lo desactiva | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | El estado deshabilitado no dispara onChange | `testDisabledBlocksChange` |
| `loading-blocks-change` | El estado de carga no dispara onChange | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | El estado activado consume el token del color principal, no el token de borde | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | El estado desactivado consume el token de borde | `testUncheckedUsesBorderToken` |

Además, pruebas específicas: `testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`.

```bash
swift test --filter LhSwitchTests    # basta con el host macOS, no hace falta simulador
```
