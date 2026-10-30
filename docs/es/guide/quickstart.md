# Inicio rápido

## Ejemplo mínimo

```swift
import SwiftUI
import LhUI

struct Demo: View {
  var body: some View {
    LhTheme {
      LhButton(
        lhOnClick: { /* manejar el clic */ },
        type: .primary,
        text: "Botón principal"
      )
    }
  }
}
```

`LhTheme` es el contenedor de temas: todos los componentes Lh que envuelve consumen los tokens automáticamente vía Environment; sin envoltorio, se recurre a la paleta clara.

## Tipos y tamaños

```swift
// Seis tipos
LhButton(lhOnClick: {}, text: "Predeterminado")       // .default
LhButton(lhOnClick: {}, type: .primary, text: "Principal")
LhButton(lhOnClick: {}, type: .success, text: "Éxito")
LhButton(lhOnClick: {}, type: .warning, text: "Advertencia")
LhButton(lhOnClick: {}, type: .danger, text: "Peligro")
LhButton(lhOnClick: {}, type: .info, text: "Información")

// Tres tamaños
LhButton(lhOnClick: {}, lhSize: .small, text: "Pequeño")
LhButton(lhOnClick: {}, lhSize: .medium, text: "Mediano")
LhButton(lhOnClick: {}, lhSize: .large, text: "Grande")
```

## Estados

```swift
// Deshabilitado: no responde al clic, muestra el aspecto deshabilitado
LhButton(lhOnClick: {}, disabled: true, text: "Deshabilitado")

// Cargando: muestra un indicador, no dispara lhOnClick
LhButton(lhOnClick: {}, loading: true, text: "Cargando...")

// Ambos presentes: la deshabilitación tiene prioridad (caso dorado disabled-precedes-loading)
LhButton(lhOnClick: {}, disabled: true, loading: true, text: "Deshabilitado prioritario")
```

## Icono y fondo de patrón

```swift
// El nombre del icono se resuelve contra el sistema de iconos local (mapeo a SF Symbols en LhButtonStyle.icon(for:); los nombres no registrados no se dibujan)
LhButton(lhOnClick: {}, type: .primary, icon: "search", text: "Buscar")

// Fondo de patrón chino (consume el token color.decoration)
LhButton(lhOnClick: {}, type: .primary, bgPattern: true, text: "Fondo de patrón")
```

## Temas claro y oscuro

```swift
LhTheme(isDark: isDark) {
  // Todos los componentes envueltos cambian automáticamente a los tokens oscuros (valores precalculados por core, sin mezcla en tiempo de ejecución)
}
```

## Vista previa de los ejemplos de componentes

La UI nativa no se puede renderizar en tiempo real en el navegador; este sitio muestra el aspecto con un **simulador de marco de teléfono en HTML estático en línea**:

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>lh-ui-ios</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">Botón predeterminado</button>
      <button class="sim-btn sim-btn--primary">Botón principal</button>
      <button class="sim-btn sim-btn--success">Éxito</button>
      <button class="sim-btn sim-btn--warning">Advertencia</button>
      <button class="sim-btn sim-btn--danger">Peligro</button>
      <button class="sim-btn sim-btn--info">Información</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Pequeño</button>
      <button class="sim-btn sim-btn--primary sim-btn--large">Grande</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Deshabilitado</button>
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Cargando
      </button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Buscar</button>
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Fondo de patrón</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo; todos los valores de estilo provienen de la instantánea de tokens de core, con los mismos valores que en el dispositivo real. El aspecto en dispositivo real se rige por <code>#Preview</code> y las capturas de pantalla del dispositivo.</p>

> El modo oscuro del simulador está vinculado con el sitio: cambia el tema en la esquina superior derecha y los colores del marco del teléfono cambian (los tokens oscuros están precalculados por core).
