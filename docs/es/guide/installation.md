# Instalación

## Requisitos

- Xcode 15+, Swift 5.9+
- iOS 15.0+ (macOS 12+ únicamente para ejecutar XCTest en el host)
- Cadena de construcción: Node.js >= 20 + pnpm (únicamente para el enlace de tokens y el sitio de documentación, **no entra en el runtime**)

## Integración SPM

En Xcode: File → Add Package Dependencies…, introduce la dirección de este repositorio; o edita directamente `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/lhgb-top/lh-ui-ios", from: "0.0.1")
],
targets: [
  .target(name: "MyApp", dependencies: [.product(name: "LhUI", from: "lh-ui-ios")])
]
```

La target de tokens `LhUITokens` se incluye automáticamente con la dependencia `LhUI` (target interna del paquete SPM, no hace falta declararla por separado).

## Sincronizar tokens (al desarrollar este repositorio desde las fuentes)

Los tokens son artefactos generados: deben sincronizarse desde `lh-ui-core` (fuente única, prohibido modificarlos a mano):

```bash
cd ../lh-ui-core && pnpm codegen   # genera los artefactos de tokens dist/ios
cd ../lh-ui-ios
pnpm install                        # instala la cadena de construcción
pnpm link:tokens                    # sincroniza los tokens a Sources/LhUITokens/
```

`pnpm link:tokens` lleva una guarda de existencia de tres niveles: `../lh-ui-core/dist/ios` local → artefacto npm `@lh-ui/core` → error.

## Verificar la instalación

```bash
swift build        # compilar
swift test         # casos dorados (se ejecutan en el host macOS, sin simulador)
```
