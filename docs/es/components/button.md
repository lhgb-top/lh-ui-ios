# Botón

Botón de acción básico. Dispara una acción inmediata y admite tipos, tamaños, carga, deshabilitación, iconos y fondo de patrón chino.

> Fuente del contrato: `lh-ui-core/specs/button.json` ·
> Casos dorados: `lh-ui-core/cases/button.json` (8 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Tipos

Seis tipos determinan el color de fondo y el color del texto.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tipos de Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">Predeterminado</button>
      <button class="sim-btn sim-btn--primary">Principal</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">Éxito</button>
      <button class="sim-btn sim-btn--warning">Advertencia</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">Peligro</button>
      <button class="sim-btn sim-btn--info">Información</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "Botón principal")
```

## Tamaños

Tres tamaños se mapean a los tokens `button.height` / `paddingHorizontal` / `fontSize` / `iconSize`.
La forma en iOS usa un radio de esquina en cápsula (el token `radius.round`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Botón pequeño</button>
      <button class="sim-btn">Botón mediano</button>
      <button class="sim-btn sim-btn--large">Botón grande</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Estados

Ni el estado deshabilitado ni el de carga disparan `lhOnClick`; cuando ambos están presentes, **la deshabilitación tiene prioridad** (caso dorado `disabled-precedes-loading`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Estados de Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Normal</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Deshabilitado</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Cargando
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Deshabilitado prioritario</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Icono y fondo de patrón

El nombre del icono se resuelve contra el sistema de iconos local (`LhButtonStyle.icon(for:)` mapea a SF Symbols: search → magnifyingglass,
refresh → arrow.clockwise, check → checkmark, close → xmark; los nombres no registrados no se dibujan).
El fondo de patrón consume el token `color.decoration` y dibuja con Canvas líneas diagonales a 45°,
dispuestas bajo el color de fondo y sobre el texto, sin afectar al contraste.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icono y patrón</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Buscar</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>Predeterminado</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Patrón principal</button>
      <button class="sim-btn sim-btn--pattern">Patrón predeterminado</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Temas claro y oscuro

Cambia el tema del sitio en la esquina superior derecha y los colores de los botones dentro del marco del simulador cambian; en el dispositivo, se alterna con `LhTheme(isDark: true)`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Botones oscuros</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Botón principal</button>
      <button class="sim-btn">Predeterminado</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Deshabilitado</button>
      <button class="sim-btn sim-btn--success">Éxito</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo; los valores claro/oscuro provienen de la instantánea de tokens de core</p>

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `lhOnClick` | Devolución de llamada al pulsar; no se dispara cuando `disabled` o `loading` es true | `() -> Void` | — |
| `type` | Tipo de botón, determina el color de fondo y del texto | `LhButtonType` | `.default` |
| `lhSize` | Tamaño del botón, mapeado a los tokens de tamaño | `LhButtonSize` | `.medium` |
| `disabled` | Si está deshabilitado | `Bool` | `false` |
| `loading` | Si está cargando (muestra un indicador, no dispara lhOnClick) | `Bool` | `false` |
| `icon` | Nombre del icono (resuelto mediante el mapeo de SF Symbol) | `String?` | `nil` |
| `bgPattern` | Si se dibuja el patrón decorativo chino | `Bool` | `false` |
| `label` / `text` | Contenido de texto del botón (el slot default del spec) | `Text` / string | — |

### LhButtonType

| Valor | Fondo | Color del texto |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| Valor | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small` (32pt) | `button.paddingHorizontal.small` (16pt) | `button.fontSize.small` (13pt) | `button.iconSize.small` (16pt) |
| `.medium` | `button.height.medium` (40pt) | `button.paddingHorizontal.medium` (20pt) | `button.fontSize.medium` (14pt) | `button.iconSize.medium` (18pt) |
| `.large` | `button.height.large` (48pt) | `button.paddingHorizontal.large` (24pt) | `button.fontSize.large` (16pt) | `button.iconSize.large` (20pt) |

Sobreescritura del estado deshabilitado: fondo `color.disabled.bg`, texto `color.disabled.text`, borde `color.disabled.border`.

## Referencia de tokens

Tokens consumidos por el botón (alineados entrada por entrada con `tokenRefs` en `specs/button.json`):

| Token | Uso |
| --- | --- |
| `button.height.{small,medium,large}` | Tres alturas |
| `button.paddingHorizontal.{small,medium,large}` | Tres rellenos horizontales |
| `button.fontSize.{small,medium,large}` | Tres tamaños de fuente |
| `button.iconSize.{small,medium,large}` | Tres tamaños de icono |
| `button.borderRadius` / `button.borderWidth` | Radio de esquina (sigue `radius.base`) y ancho del borde |
| `button.fontWeight` | Peso de la fuente (sigue `typography.fontWeight.primary`, en el extremo se mapea a Font.Weight) |
| `color.primary.default` / `color.onPrimary` | Fondo / texto del tipo primary |
| `color.{success,warning,danger,info}.default` | Fondos de los tipos semánticos |
| `color.background.default` / `color.text.primary` / `color.border.base` | Fondo / texto / borde del tipo predeterminado |
| `color.disabled.{bg,text,border}` | Tres colores del estado deshabilitado |
| `color.decoration` | Color del patrón |
| `shadow.lighter` | Elevación predeterminada (portador LhShadow) |
| `spacing.xs` | Espacio entre icono y texto |

## Referencia de casos dorados

Cómo se mapean las 8 aserciones de `cases/button.json` a XCTest:

| case id | Aserción | Test local |
| --- | --- | --- |
| `click-emits-onclick` | La barrera lo deja pasar (interactivo) | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | El estado deshabilitado no es interactivo | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | El estado de carga no es interactivo | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | La deshabilitación tiene prioridad + estilo deshabilitado | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | El tipo predeterminado usa fondo / texto neutros | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | El tipo primary consume los tokens del color principal | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | El tamaño pequeño consume los tokens de tamaño small | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | El fondo de patrón consume el color decorativo | `testBgPatternUsesDecorationToken` |

Además, pruebas específicas de modo oscuro: `testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test    # basta con el host macOS, no hace falta simulador
```
