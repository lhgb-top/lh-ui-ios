# Temas y modo oscuro

## Modelo de tokens

La fuente única de tokens del linaje nativo está en `lh-ui-core/tokens/*.json`; el codegen genera los artefactos iOS:

| Artefacto | Contenido | Forma oscura |
| --- | --- | --- |
| `LhTokens` | Paleta clara completa: dimensiones de Button, paleta Color, Motion, Radius, Shadow, Spacing, Typography, ZIndex | — |
| `LhDarkTokens` | Únicamente el subobjeto `Color` (modelo de **objetos paralelos**) | El oscuro solo cubre los colores; las dimensiones, animaciones y radios son iguales en modo oscuro |
| `LhShadow` | Estructura portadora de sombra de SwiftUI (color/opacity/radius/x/y) | — |

> Esto es coherente con android / harmony / windows (objetos paralelos) y difiere del lado de la documentación (fusión JSON superficial).
> La capa de temas está diseñada en consecuencia: `LhColors` solo transporta los colores; las dimensiones se toman directamente de `LhTokens` en los componentes.

## LhColors

`LightLhColors` / `DarkLhColors` aplanan los dos enums generados en un tipo de valor `Equatable`:

```swift
public struct LhColors: Equatable {
  public let primary: Color
  public let onPrimary: Color
  // ... todos los colores semánticos
}

public let LightLhColors = LhColors(primary: LhTokens.Color.Primary.`default`, /* ... */)
public let DarkLhColors = LhColors(primary: LhDarkTokens.Color.Primary.`default`, /* ... */)
```

El inicializador es público: las pruebas unitarias pueden construir una paleta directamente para sus aserciones; del lado de la aplicación, el consumo debe hacerse a través de `LhTheme`.

## LhTheme

```swift
LhTheme(isDark: true) {
  // Environment(\.lhColors) inyecta DarkLhColors; los componentes envueltos lo consumen automáticamente
}
```

Sin envoltura de `LhTheme`, el defaultValue de la clave Environment recurre a `LightLhColors` (claro por defecto).

## Precálculo del oscuro (importante)

El modo oscuro del linaje web se evalúa dinámicamente con la función CSS `color-mix()`; al no existir una cascada CSS en nativo, core ya ha **precalculado las expresiones oscuras como literales** (p. ej., `rgba(61,100,158,0.25)`, `#B1C1D8`). Consecuencia (plan maestro R-n6):

> **Al cambiar el color principal del preset, los valores oscuros precalculados no lo siguen automáticamente**: hay que recalcularlos a mano y actualizar
> `lh-ui-core/tokens/color-dark.json`, y luego refrescar la *Línea base del lenguaje de diseño*.

## Convenciones específicas de iOS

- **La unidad de duración es el segundo**: `LhTokens.Motion.Duration.base = 0.300` (android/harmony usan milisegundos, y C también),
  las API de animación de SwiftUI lo consumen directamente, sin conversión.
- **Expresión de los colores**: los artefactos generados usan RGB normalizado (`SwiftUI.Color(red:green:blue:)` + `.opacity()`),
  sin cadenas hexadecimales.
- **Redondeo**: `Radius.circle` es una fracción de 0,5; del lado del dispositivo se calcula `min(ancho, alto)/2`, no se puede usar tal cual como pt.
- **Sombra**: SwiftUI no admite la extensión (spread); el `LhShadow` generado ignora el spread, con un comentario.
- **Fuente**: `Typography.fontFamily` es una cadena con la pila de fuentes; del lado del dispositivo se toma la primera familia disponible; la serifa estilo chino es el tono predeterminado.

## Consulta rápida de tokens

La tabla completa de tokens (claro/oscuro/descripción) está en `dist/docs/tokens.md` del repositorio core (generado tras `pnpm codegen`).
El mapeo de tokens a nivel de componente está en [Referencia de tokens de Button](/es/components/button#referencia-de-tokens).
