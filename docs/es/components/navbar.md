# Barra de navegación

Barra de navegación superior de la página. Título centrado + contenido a ambos lados, línea separadora inferior y nivel de apilamiento `zIndex.sticky`.

> Fuente del contrato: `lh-ui-core/specs/navbar.json` ·
> Casos dorados: `lh-ui-core/cases/navbar.json` (6 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Uso básico

`title` se muestra centrado (con posicionamiento absoluto, sin superponerse al contenido de los lados); `leftText` / `rightText` se alinean a la izquierda y a la derecha respectivamente.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar básica</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">Atrás</span>
    <span class="sim-navbar__title">青花瓷 (porcelana azul y blanco)</span>
    <span class="sim-navbar__side">Más</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">Contenido de la página</span></div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
LhNavbar(
  title: "青花瓷 (porcelana azul y blanco)",
  leftText: "Atrás",
  rightText: "Más",
  onLeftClick: { /* Atrás */ },
  onRightClick: { /* Más */ }
)
```

## Iconos y borde

`leftIcon` / `rightIcon` pasan por el mapeo `LhIconMap` y se muestran junto al texto; `bordered = false` elimina la línea separadora inferior.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Iconos de Navbar</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>Atrás</span>
    </span>
    <span class="sim-navbar__title">Título</span>
    <span class="sim-navbar__side">
      <span>Ajustes</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">Barra de navegación sin borde</span></div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## Barrera de pulsación

Si no se proporcionan `leftText` / `leftIcon`, el lado izquierdo no responde a la pulsación (caso dorado `no-left-content-no-onleftclick`);
el lado derecho funciona igual. El montaje flotante lo realiza quien llama con `.overlay` (convención de SwiftUI); el componente por sí mismo aporta el nivel de apilamiento `zIndex.sticky`.

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷 (porcelana azul y blanco)", leftText: "Atrás", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `title` | Título centrado | `String` | `""` |
| `leftText` | Texto del lado izquierdo (si está vacío y no hay leftIcon, no responde a la pulsación) | `String` | `""` |
| `leftIcon` | Nombre lógico del icono izquierdo (mapeo `LhIconMap`) | `String?` | `nil` |
| `rightText` | Texto del lado derecho (si está vacío y no hay rightIcon, no responde a la pulsación) | `String` | `""` |
| `rightIcon` | Nombre lógico del icono derecho | `String?` | `nil` |
| `bordered` | Si se muestra la línea separadora inferior | `Bool` | `true` |
| `onLeftClick` | Devolución de llamada de la pulsación izquierda | `(() -> Void)?` | `nil` |
| `onRightClick` | Devolución de llamada de la pulsación derecha | `(() -> Void)?` | `nil` |

### Colores

| Zona | Color |
| --- | --- |
| Fondo | `color.background.default` |
| Título / texto e iconos de los lados | `color.text.primary` |
| Línea separadora | `color.border.lighter` (el ancho toma `navbar.borderWidth`) |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `navbar.height` | Altura de la barra de navegación (44pt) |
| `navbar.paddingHorizontal` | Relleno horizontal de los lados (12pt) |
| `navbar.titleFontSize` | Tamaño de fuente del título y de los textos de los lados (16pt) |
| `navbar.iconSize` | Tamaño de los iconos de los lados (20pt) |
| `navbar.borderWidth` | Ancho de la línea separadora inferior |
| `color.border.lighter` | Color de la línea separadora |
| `color.text.primary` | Color del título y del contenido de los lados |
| `color.background.default` | Fondo |
| `zIndex.sticky` | Nivel de apilamiento flotante |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `title-renders-text` | El título se renderiza correctamente | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | La pulsación izquierda dispara onLeftClick | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | La pulsación derecha dispara onRightClick | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | Sin contenido izquierdo, no se dispara | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | La línea separadora consume el token border.lighter | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | La altura consume el token navbar.height | `testHeightUsesNavbarHeightToken` |

Además, pruebas específicas: `testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`.

```bash
swift test --filter LhNavbarTests    # basta con el host macOS, no hace falta simulador
```
