# Cargando

Indicador de carga. En el extremo SwiftUI es un anillo dibujado a mano (`Circle().trim` + animación de rotación); la duración pasa por `motion.duration.base` (segundos).

> Fuente del contrato: `lh-ui-core/specs/loading.json` ·
> Casos dorados: `lh-ui-core/cases/loading.json` (5 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Tonos

Cinco tonos toman los tokens de color semánticos; el predeterminado es `.primary`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tonos de Loading</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--success"></span>
      <span class="sim-loading sim-loading--warning"></span>
    </div>
    <div class="sim-row">
      <span class="sim-loading sim-loading--danger"></span>
      <span class="sim-loading sim-loading--info"></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhLoading(tone: .success)
```

## Tamaños

Tres tamaños se mapean al token `loading.size`; el ancho del trazo toma `loading.strokeWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Loading</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Fotograma estático

`animating: false` congela la rotación (el caso dorado `render-emits-ring-command` afirma los parámetros de dibujo del anillo estático),
útil para pruebas de captura de pantalla y fotogramas estáticos de la documentación.

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `lhSize` | Tamaño del anillo, mapeado a los tokens de tamaño | `LhLoadingSize` | `.medium` |
| `tone` | Tono del anillo, mapeado a los tokens de color semánticos | `LhLoadingTone` | `.primary` |
| `animating` | Si rota (`false` lo congela como fotograma estático) | `Bool` | `true` |

### LhLoadingSize

| Valor | Tamaño |
| --- | --- |
| `.small` | `loading.size.small` (16pt) |
| `.medium` | `loading.size.medium` (20pt) |
| `.large` | `loading.size.large` (24pt) |

### LhLoadingTone

| Valor | Color |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `loading.size.{small,medium,large}` | Tres tamaños |
| `loading.strokeWidth` | Ancho del trazo del anillo |
| `color.{primary,success,warning,danger,info}.default` | Cinco tonos |
| `motion.duration.base` | Duración de una vuelta de rotación (en segundos en el extremo iOS) |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `medium-size-uses-medium-token` | El tamaño mediano toma el token de tamaño medium | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | El tamaño grande toma el token de tamaño large | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | El tono primary toma el token del color principal | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | El tono de éxito toma el token del color de éxito | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | El trazo del anillo consume el token strokeWidth | `testRingUsesStrokeWidthToken` |

Además, pruebas específicas de modo oscuro: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`.

```bash
swift test --filter LhLoadingTests    # basta con el host macOS, no hace falta simulador
```
