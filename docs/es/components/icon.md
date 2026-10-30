# Icono

Icono vectorial. Se mapea mediante un nombre lógico a los símbolos del sistema de la plataforma (en iOS, SF Symbol); el tamaño y el tono pasan íntegramente por tokens.

> Fuente del contrato: `lh-ui-core/specs/icon.json` ·
> Casos dorados: `lh-ui-core/cases/icon.json` (5 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Tonos

`tone` determina el color del icono. `default` sigue el color de texto principal, `regular` / `secondary` toman el color de texto del nivel correspondiente y el resto toma colores semánticos.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tonos de Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo; en el dispositivo se dibuja el vector SF Symbol</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## Tamaños

Tres tamaños se mapean al token `icon.size`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tamaños de Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Asignación de nombres de icono

`name` es un nombre lógico alineado con el linaje web, que en el extremo se mapea a un SF Symbol mediante `LhIconMap.symbol(for:)`:

| Nombre lógico | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

Los nombres no registrados no se dibujan (devuelven `nil`), sin provocar fallos.

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `name` | Nombre lógico del icono (mapeado a SF Symbol mediante `LhIconMap`) | `String` | — |
| `lhSize` | Tamaño del icono, mapeado a los tokens de tamaño | `LhIconSize` | `.medium` |
| `tone` | Tono del icono, mapeado a los tokens de color de texto / semánticos | `LhIconTone` | `.default` |
| `lhOnClick` | Devolución de llamada al pulsar; si no se pasa, no responde a la pulsación | `(() -> Void)?` | `nil` |

### LhIconSize

| Valor | Tamaño |
| --- | --- |
| `.small` | `icon.size.small` (16pt) |
| `.medium` | `icon.size.medium` (20pt) |
| `.large` | `icon.size.large` (24pt) |

### LhIconTone

| Valor | Color |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `icon.size.{small,medium,large}` | Tres tamaños |
| `color.text.{primary,regular,secondary}` | Tonos de texto |
| `color.{primary,success,warning,danger,info}.default` | Tonos semánticos |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `click-emits-onclick` | La pulsación dispara `lhOnClick` una vez | Capa View `onTapGesture` (las aserciones de gestos requieren simulador, ver #Preview) |
| `default-tone-uses-text-primary` | El tono predeterminado toma el color de texto principal | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | El tono primary toma el token del color principal | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | El tamaño pequeño toma el token de tamaño small | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | Se emite un único comando de dibujo de icono | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

Además, pruebas específicas de modo oscuro: `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhIconTests    # basta con el host macOS, no hace falta simulador
```
