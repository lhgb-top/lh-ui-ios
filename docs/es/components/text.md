# Texto (Text)

Primitiva de texto de visualización: consume los tokens tipográficos globales, con niveles de tamaño, peso, tono y alineación.

> Contrato: `lh-ui-core/specs/text.json` · Casos de oro: `lh-ui-core/cases/text.json` (5, traducidos a XCTest, ejecutables en host macOS)

## Niveles de tamaño

`level` se mapea al token `typography.fontSize.<level>`; el valor predeterminado es `base`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--extraLarge">extraLarge</p>
    <p class="sim-text sim-text--large">large</p>
    <p class="sim-text sim-text--medium">medium</p>
    <p class="sim-text">base</p>
    <p class="sim-text sim-text--small">small</p>
    <p class="sim-text sim-text--extraSmall">extraSmall</p>
  </div>
</div>
<p class="sim-note">Vista previa del simulador HTML (apariencia iOS / SwiftUI), no es renderizado de dispositivo real</p>

```swift
LhText("Title text", level: .large)
```

## Peso

`weight` se mapea al token `typography.fontWeight.<weight>` (primary 400 / bold 600).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--bold">bold</p>
  </div>
</div>
<p class="sim-note">Vista previa del simulador HTML (apariencia iOS / SwiftUI), no es renderizado de dispositivo real</p>

## Tono

`tone` se mapea al token `color.text.<tone>`; `selected` toma `color.selected`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--regular">regular</p>
    <p class="sim-text sim-text--secondary">secondary</p>
    <p class="sim-text sim-text--placeholder">placeholder</p>
    <p class="sim-text sim-text--disabled">disabled</p>
    <p class="sim-text sim-text--selected">selected</p>
  </div>
</div>
<p class="sim-note">Vista previa del simulador HTML (apariencia iOS / SwiftUI), no es renderizado de dispositivo real</p>

## Alineación y altura de línea

`lhAlign` alinea dentro de la caja de línea; la altura de línea siempre toma `typography.lineHeight.primary` (tamaño × 1.8).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">center</p>
    <p class="sim-text sim-text--align-end">end</p>
  </div>
</div>
<p class="sim-note">Vista previa del simulador HTML (apariencia iOS / SwiftUI), no es renderizado de dispositivo real</p>

```swift
LhText("Centered", lhAlign: .center)
```

## API

| Propiedad | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `content` | contenido de texto (primer argumento del inicializador; el slot por defecto del spec) | `String` | `""` |
| `level` | Niveles de tamaño | `LhTextLevel` | `.base` |
| `weight` | Peso | `LhTextWeight` | `.primary` |
| `tone` | Tono | `LhTextTone` | `.primary` |
| `lhAlign` | Alineación y altura de línea | `LhTextAlign` | `.start` |

### LhTextLevel

| Propiedad | fontSize token |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge` (20pt) |
| `.large` | `typography.fontSize.large` (18pt) |
| `.medium` | `typography.fontSize.medium` (16pt) |
| `.base` | `typography.fontSize.base` (14pt, default) |
| `.small` | `typography.fontSize.small` (13pt) |
| `.extraSmall` | `typography.fontSize.extraSmall` (12pt) |

### LhTextTone

| Propiedad | text color token |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## Referencia de tokens

| Token | Usage |
| --- | --- |
| `typography.fontSize.<level>` | six size levels |
| `typography.fontWeight.{primary,bold}` | two weights |
| `typography.lineHeight.primary` | line height (font size × 1.8) |
| `color.text.<tone>` / `color.selected` | text tones |

## Referencia de casos de oro

| case id | Aserción | Prueba local |
| --- | --- | --- |
| `default-level-uses-base-tokens` | default level consumes the base typography tokens | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | large level consumes the large size token | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | bold consumes the bold weight token | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | secondary tone takes the secondary text color token | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | render emits a single TEXT command | `LhTextTests.testAllLevelsUseTheirTokens` |

```bash
swift test --filter LhTextTests
```
