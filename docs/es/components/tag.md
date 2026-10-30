# Etiqueta

Etiqueta compacta para marcar y seleccionar. Más pequeña que un botón; admite tipos semánticos, borde, esquinas en cápsula y botón de cierre.

> Fuente del contrato: `lh-ui-core/specs/tag.json` ·
> Casos dorados: `lh-ui-core/cases/tag.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Tipos

Seis tipos determinan el color de fondo y el color del texto. `plain` es la forma de fondo claro con borde (fondo semántico claro + borde semántico).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tipos de Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">Predeterminada</span>
      <span class="sim-tag sim-tag--primary">Principal</span>
      <span class="sim-tag sim-tag--success">Éxito</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">Advertencia</span>
      <span class="sim-tag sim-tag--danger">Peligro</span>
      <span class="sim-tag sim-tag--info">Información</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">Principal con borde</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">Éxito con borde</span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhTag(text: "Principal", type: .primary)
LhTag(text: "Éxito con borde", type: .success, plain: true)
```

## Tamaño y esquinas

Tres tamaños se mapean a los tokens `tag.height` / `paddingHorizontal` / `fontSize`; `round` cambia el radio de esquina a la mitad de la altura (cápsula).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">Pequeña</span>
      <span class="sim-tag sim-tag--primary">Mediana</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">Grande</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Esquinas rectas</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">Esquinas redondeadas</span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Cerrable

`closable` muestra un botón de cierre a la derecha; al pulsarlo se dispara `onClose` (caso dorado `closable-tap-emits-onclose`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cierre de Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Cerrable<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">Cerrable<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhTag(text: "Cerrable", type: .primary, closable: true) {
  // onClose
}
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `text` | Texto de la etiqueta | `String` | — |
| `type` | Tipo de etiqueta, determina el color de fondo y del texto | `LhTagType` | `.default` |
| `lhSize` | Tamaño de la etiqueta, mapeado a los tokens de tamaño | `LhTagSize` | `.medium` |
| `plain` | Si tiene forma de fondo claro con borde | `Bool` | `false` |
| `round` | Si tiene esquinas en cápsula (radio = altura / 2) | `Bool` | `false` |
| `closable` | Si se muestra el botón de cierre | `Bool` | `false` |
| `onClose` | Devolución de llamada al pulsar el botón de cierre | `(() -> Void)?` | `nil` |

### LhTagType

| Valor | Fondo | Color del texto |
| --- | --- | --- |
| `.default` | `color.background.default` + borde `color.border.base` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

Con `plain = true`: el fondo toma `color.<type>.bg`, y el borde y el texto toman `color.<type>.default` (el tipo `.default` ignora `plain`, caso dorado `default-type-renders-text`).

### LhTagSize

| Valor | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small` (20pt) | `tag.paddingHorizontal.small` (8pt) | `tag.fontSize.small` (12pt) |
| `.medium` | `tag.height.medium` (24pt) | `tag.paddingHorizontal.medium` (12pt) | `tag.fontSize.medium` (13pt) |
| `.large` | `tag.height.large` (28pt) | `tag.paddingHorizontal.large` (16pt) | `tag.fontSize.large` (14pt) |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `tag.height.{small,medium,large}` | Tres alturas |
| `tag.paddingHorizontal.{small,medium,large}` | Tres rellenos horizontales |
| `tag.fontSize.{small,medium,large}` | Tres tamaños de fuente |
| `tag.borderRadius` / `tag.borderWidth` | Radio de esquina predeterminado (sigue `radius.small`) y ancho del borde |
| `tag.gap` | Espacio entre el texto y el botón de cierre (sigue `spacing.xs`) |
| `color.{primary,success,warning,danger,info}.{default,bg}` | Fondos de los tipos semánticos y fondos claros con borde |
| `color.onPrimary` | Color de texto de los tipos semánticos |
| `color.background.default` / `color.text.primary` / `color.border.base` | Tres colores del tipo predeterminado |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `default-type-renders-text` | El tipo predeterminado usa fondo / texto neutros e ignora plain | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | El tipo primary consume primary y onPrimary | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain consume el bg semántico y el borde semántico | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | El tamaño pequeño consume los tokens de tamaño small | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | El radio de round == altura / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | El botón de cierre dispara onClose | `testClosableTagInitAndRender` (las aserciones de gestos requieren simulador) |

Además, pruebas específicas de modo oscuro: `testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhTagTests    # basta con el host macOS, no hace falta simulador
```
