# Introducción

**lh-ui-ios** es la implementación iOS del **linaje nativo** de la familia lh-ui: una biblioteca de componentes UI basada en **Swift + SwiftUI**.

## Posición en la familia

```
                     ┌── linaje web: share (core TS + SCSS) → plus / vue2 / react / uniapp
familia lh-ui ───────┤ (misma marca)
                     └── linaje nativo: core (tokens JSON + contratos + codegen) → android / ios / harmony / windows
                                                                                ↑ este repositorio
```

- **Centro de construcción**: `lh-ui-core` es la fuente única de tokens del linaje nativo (`tokens/*.json`), los contratos de los componentes (`specs/`), los casos dorados (`cases/`) y las herramientas de codegen. Genera el esqueleto de tokens Swift (`LhTokens` / `LhDarkTokens` / `LhShadow`), **sin generar ninguna implementación de UI**.
- **Responsabilidades de este repositorio**: escribir a mano las vistas SwiftUI, la integración de los temas (inyección vía Environment), las enums de props y el enlace de los valores predeterminados, y traducir los casos dorados a XCTest.
- **Independiente del linaje web**: ninguna dependencia de `@lh-ui/share`; las releases no se condicionan mutuamente. La coherencia visual se alinea manualmente vía la *Línea base del lenguaje de diseño*.

## Lenguaje de diseño

Temática estilo chino: color principal azul 青花瓷 (porcelana azul y blanco) (`#2B4C7C`), fondo blanco 宣纸 (papel de arroz) (`#FAF6F0`), éxito en verde 松花绿 (verde pino), advertencia 藤黄 (amarillo herbáceo), peligro 朱砂 (cinabre), pila de fuentes con serifa (Noto Serif SC → STSong → SimSun). Todos los valores visuales son tokens: no aparece ningún literal en los componentes.

## Por qué SwiftUI

- UI declarativa, ciudadana de primera clase de la plataforma, mentalmente isomorfa a Compose / ArkUI: los contratos multiplataforma son fáciles de alinear
- Integración SPM en un clic, sin runtime JS, sin capa de puenteo
- `#Preview` sirve de documentación, `View` es el componente: simétrico con la experiencia de desarrollo SFC del linaje web

## Estado actual

- **La cadena completa de button ya está entregada como prototipo** (consumo de tokens + resolución del aspecto vía resolveAppearance + vista SwiftUI + XCTest + `#Preview` + sitio de documentación)
- Los otros 13 componentes P0 (icon / input / textarea / cell / checkbox / radio / switch / tag / dialog / toast / loading / picker / navbar) se completarán después siguiendo el mismo paradigma
