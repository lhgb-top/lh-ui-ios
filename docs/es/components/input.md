# Campo de entrada

Campo de entrada controlado de una sola línea. `@Binding var value` ofrece un enlace bidireccional; admite texto plano / enmascarado, botón de borrado, límite de caracteres y anillo de focus.

> Fuente del contrato: `lh-ui-core/specs/input.json` ·
> Casos dorados: `lh-ui-core/cases/input.json` (8 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Uso básico

La altura se alinea con la de Button (tres tokens `input.height`); al recibir el focus, el borde pasa a `color.focus` y se ensancha como anillo de focus.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input básico</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="Introduce el contenido" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷 (porcelana azul y blanco)" /></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "Introduce el contenido") { newValue in
  // onValueChange
}
```

## Tamaños

Tres tamaños se mapean a los tokens `input.height` / `paddingHorizontal` / `fontSize`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Input</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="Pequeño" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="Mediano" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="Grande" /></span></div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Contraseña y borrado

`type: .password` se materializa como `SecureField` (prueba `testPasswordTypeIsSecure`);
`clearable` muestra el botón de borrado cuando hay un valor y, al pulsarlo, dispara `onValueChange("")` (caso dorado `clearable-emits-empty-value`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input extendido</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="Deshabilitado" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `value` | Contenido de entrada (enlace bidireccional controlado) | `String` | — |
| `placeholder` | Texto del marcador de posición | `String` | `""` |
| `type` | Tipo de entrada (texto plano / enmascarado) | `LhInputType` | `.text` |
| `lhSize` | Tamaño del campo, mapeado a los tokens de tamaño | `LhInputSize` | `.medium` |
| `disabled` | Si está deshabilitado (no dispara ninguna devolución de llamada) | `Bool` | `false` |
| `readonly` | Si es de solo lectura (no dispara onValueChange; mantiene el estilo de focus) | `Bool` | `false` |
| `clearable` | Si se muestra el botón de borrado | `Bool` | `false` |
| `maxlength` | Número máximo de caracteres (trunca al superarlo, caso dorado `maxlength-truncates-input`) | `Int?` | `nil` |
| `onValueChange` | Devolución de llamada de cambio de contenido; el payload es el nuevo valor | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Devolución de llamada de focus | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Devolución de llamada de pérdida de focus | `(() -> Void)?` | `nil` |

### LhInputSize

| Valor | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small` (32pt) | `input.paddingHorizontal.small` (12pt) | `input.fontSize.small` (13pt) |
| `.medium` | `input.height.medium` (40pt) | `input.paddingHorizontal.medium` (16pt) | `input.fontSize.medium` (14pt) |
| `.large` | `input.height.large` (48pt) | `input.paddingHorizontal.large` (20pt) | `input.fontSize.large` (16pt) |

### LhInputType

| Valor | Materialización |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### Colores

| Estado | Borde | Texto / marcador de posición |
| --- | --- | --- |
| Predeterminado | `color.border.base` (`input.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Focus | `color.focus` (`input.focusRingWidth`) | Ídem |
| Deshabilitado | `color.disabled.border` | `color.disabled.text` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `input.height.{small,medium,large}` | Tres alturas |
| `input.paddingHorizontal.{small,medium,large}` | Tres rellenos horizontales |
| `input.fontSize.{small,medium,large}` | Tres tamaños de fuente |
| `input.borderRadius` / `input.borderWidth` | Radio de esquina (sigue `radius.small`) y ancho del borde |
| `input.focusRingWidth` | Ancho del anillo de focus |
| `input.clearIconSize` | Tamaño del icono del botón de borrado |
| `color.focus` | Color del borde en focus |
| `color.text.{primary,placeholder,disabled}` | Color del texto y del marcador de posición |
| `color.border.base` / `color.disabled.border` | Color del borde |
| `color.background.default` / `color.disabled.bg` | Color de fondo |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `input-emits-onvaluechange` | Al escribir se dispara `onValueChange("青花瓷 (porcelana azul y blanco)")` | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | Al borrar se dispara `onValueChange("")` | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | El estado deshabilitado no dispara onValueChange | `testDisabledBlocksInput` |
| `readonly-blocks-input` | El estado de solo lectura no dispara onValueChange | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | El texto del marcador de posición toma el token de color del marcador | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | El focus consume el token focus y dispara lhOnFocus | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | El tamaño pequeño consume los tokens de tamaño small | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | Al superar el límite de caracteres se trunca | `testMaxlengthTruncatesInput` |

Además, pruebas específicas: `testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`.

```bash
swift test --filter LhInputTests    # basta con el host macOS, no hace falta simulador
```
