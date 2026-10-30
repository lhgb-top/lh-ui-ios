# Toast (notificación breve)

Notificación breve declarativa. `@Binding var visible` controla la visibilidad y desaparece automáticamente al cabo de un tiempo; el fondo oscuro toma el token `color.ink`.

> Fuente del contrato: `lh-ui-core/specs/toast.json` ·
> Casos dorados: `lh-ui-core/cases/toast.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Tipos

El tipo predeterminado no tiene icono; los demás muestran un punto semántico a la izquierda del texto. Fondo oscuro + texto blanco; el contraste lo garantiza `color.ink`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tipos de Toast</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Predeterminado</button></div>
  </div>
  <div class="sim-toast">Guardado</div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast semántico</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">Éxito</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>Operación exitosa</div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "Guardado", type: .success)
```

## Posición

Tres posiciones: `top` (arriba), `center` (centro, predeterminada) y `bottom` (abajo).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Posición de Toast</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Posición bottom</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>Notificación inferior</div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Ocultamiento automático

Cuando `visible` pasa a `true` se inicia un temporizador `.task`; transcurridos `duration` milisegundos, `visible` vuelve automáticamente a `false` y se dispara `onClose`
(caso dorado `auto-hides-after-duration`); si el temporizador no ha finalizado, se mantiene visible sin disparar la devolución de llamada
(`tick-before-duration-keeps-visible`); si el exterior lo pone manualmente a `false`, no se dispara ninguna devolución de llamada (`hide-is-silent`).

::: tip Unidad de duración
El token `toast.duration` está en milisegundos (2000), mientras que `Task.sleep` de SwiftUI necesita segundos, de modo que el extremo hace la conversión
`Double(duration) / 1000` (ver `LhToastStyle`).
:::

```swift
LhToast(visible: $visible, text: "Operación exitosa", type: .success, duration: 2000) {
  // onClose (solo se dispara al ocultarse automáticamente)
}
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `visible` | Si se muestra (enlace bidireccional controlado; vuelve automáticamente a false al cabo del tiempo) | `Bool` | — |
| `text` | Texto de la notificación | `String` | — |
| `type` | Tipo de notificación, determina si se muestra el punto y su color | `LhToastType` | `.default` |
| `lhPosition` | Posición de visualización | `LhToastPosition` | `.center` |
| `duration` | Duración de visualización (milisegundos) | `Int` | `2000` (token `toast.duration`) |
| `onClose` | Devolución de llamada de ocultamiento automático (no se dispara al ocultar manualmente desde el exterior) | `(() -> Void)?` | `nil` |

### LhToastType

| Valor | Color del punto |
| --- | --- |
| `.default` | Sin punto |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| Valor | Posición |
| --- | --- |
| `.top` | Arriba (margen `spacing.xl`) |
| `.center` | Centrado |
| `.bottom` | Abajo (margen `spacing.xl`) |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | Relleno |
| `toast.fontSize` | Tamaño de fuente del texto de la notificación |
| `toast.borderRadius` | Radio de esquina (sigue `radius.small`) |
| `toast.gap` | Espacio entre el punto y el texto |
| `toast.duration` | Duración de visualización predeterminada (milisegundos) |
| `color.ink` | Fondo oscuro (en modo oscuro tiene una sobreescritura específica, para diferenciarlo del fondo de la página) |
| `color.onPrimary` | Texto blanco |
| `color.{success,warning,danger,info}.default` | Colores semánticos del punto |
| `zIndex.toast` | Nivel de apilamiento |
| `spacing.xl` | Margen de las posiciones superior / inferior |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `show-makes-visible` | Al mostrar, se renderiza | `testShowMakesVisible` |
| `auto-hides-after-duration` | Al vencer el tiempo, se oculta y dispara onClose | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | Mientras no vence el temporizador, se mantiene visible | `testVisibleDuringDuration` |
| `hide-is-silent` | Al ocultar manualmente desde el exterior no se dispara la devolución de llamada | `testHideIsSilent` |
| `success-type-uses-success-token` | El tipo de éxito consume los tokens de éxito e ink | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | Cuando está oculto, los comandos de dibujo están vacíos | `testHiddenNotRendered` |

Además, pruebas específicas: `testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`.

```bash
swift test --filter LhToastTests    # basta con el host macOS, no hace falta simulador
```
