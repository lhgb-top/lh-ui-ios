# Área de texto

Área de texto controlada de varias líneas. `@Binding var value` ofrece un enlace bidireccional, con marcador de posición y contador de caracteres superpuestos.

> Fuente del contrato: `lh-ui-core/specs/textarea.json` ·
> Casos dorados: `lh-ui-core/cases/textarea.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Uso básico

La altura mínima toma `textarea.minHeight`, el relleno toma `textarea.paddingHorizontal` / `paddingVertical`,
y al recibir el focus el borde pasa a `color.focus`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea básica</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="Introduce el contenido"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷 (porcelana azul y blanco)</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "Introduce el contenido") { newValue in
  // onValueChange
}
```

## Contador de caracteres

Con `showCount = true` se muestra un contador en la esquina inferior derecha: si se ha definido `maxlength`, se muestra `actual/límite` (caso dorado
`showcount-renders-count`); si no, solo se muestra la longitud actual (`showcount-without-maxlength-renders-length-only`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Contador de Textarea</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷 (porcelana azul y blanco)</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>Deshabilitada</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `value` | Contenido de entrada (enlace bidireccional controlado) | `String` | — |
| `placeholder` | Texto del marcador de posición | `String` | `""` |
| `rows` | Número deseado de filas (afecta a la altura mínima) | `Int` | `3` |
| `disabled` | Si está deshabilitada (no dispara ninguna devolución de llamada) | `Bool` | `false` |
| `readonly` | Si es de solo lectura (no dispara onValueChange; mantiene el estilo de focus) | `Bool` | `false` |
| `showCount` | Si se muestra el contador de caracteres | `Bool` | `false` |
| `maxlength` | Número máximo de caracteres (trunca al superarlo) | `Int?` | `nil` |
| `onValueChange` | Devolución de llamada de cambio de contenido; el payload es el nuevo valor | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Devolución de llamada de focus | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Devolución de llamada de pérdida de focus | `(() -> Void)?` | `nil` |

### Colores

| Estado | Borde | Texto / marcador de posición |
| --- | --- | --- |
| Predeterminado | `color.border.base` (`textarea.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Focus | `color.focus` (`textarea.focusRingWidth`) | Ídem |
| Deshabilitado | `color.disabled.border` | `color.disabled.text` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `textarea.minHeight` | Altura mínima |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | Relleno |
| `textarea.fontSize` | Tamaño de fuente |
| `textarea.countFontSize` | Tamaño de fuente del contador |
| `textarea.borderRadius` / `textarea.borderWidth` | Radio de esquina y ancho del borde |
| `textarea.focusRingWidth` | Ancho del anillo de focus |
| `color.focus` | Color del borde en focus |
| `color.text.{primary,placeholder,disabled}` | Color del texto y del marcador de posición |
| `color.border.base` / `color.disabled.border` | Color del borde |
| `color.background.default` / `color.disabled.bg` | Color de fondo |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `input-emits-onvaluechange` | Al escribir se dispara `onValueChange("青花瓷 (porcelana azul y blanco)")` | `testDefaultIsEditable` |
| `disabled-blocks-input` | El estado deshabilitado no dispara onValueChange | `testDisabledBlocksInput` |
| `showcount-renders-count` | El contador muestra `3/10` y consume el token de tamaño de fuente del contador | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | Sin límite, solo se muestra `3` | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | El focus consume el token focus y dispara lhOnFocus | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | Al superar el límite de caracteres se trunca | `testMaxlengthTruncatesInput` |

Además, pruebas específicas: `testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`.

```bash
swift test --filter LhTextareaTests    # basta con el host macOS, no hace falta simulador
```
