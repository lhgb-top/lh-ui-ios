# Enlace local

## Convención de disposición de la familia

```
lh-ui/                        # directorio padre de la familia (no es un repositorio)
├── lh-ui-core/               # fuente única de tokens + codegen
├── lh-ui-android/            # repositorio hermano
├── lh-ui-ios/                # este repositorio
├── lh-ui-harmony/
└── lh-ui-windows/
```

Cuando todos los repositorios comparten el mismo directorio padre, los tokens se **conectan localmente en directo**; cuando un repositorio hermano no existe (clone monorepositorio en CI), **se recurre automáticamente al paquete npm**.
Mecanismo isomorfo a la guarda de vite alias del linaje web (plan maestro D18).

## Guarda de tres niveles

`scripts/link-tokens.mjs` busca los artefactos de tokens por orden de prioridad:

| Prioridad | Origen | Descripción |
| --- | --- | --- |
| 1 | `../lh-ui-core/dist/ios` | Conexión local: al cambiar un token surte efecto al instante |
| 2 | `node_modules/@lh-ui/core/dist/ios` | Respuesta npm: el campo `files:["dist"]` de `@lh-ui/core` contiene los artefactos de las cuatro plataformas |
| 3 | — | Error y salida: sin tokens no se puede construir |

## Flujo diario

```bash
# 1. Modificar los tokens (en el repositorio core)
cd ../lh-ui-core
vim tokens/color.json           # o spacing / typography / ...

# 2. Regenerar + validar
pnpm codegen                    # genera los artefactos dist/ de las cuatro plataformas
pnpm verify                     # schema + referencias + contraste WCAG + coherencia de los contratos

# 3. Sincronizar de vuelta a este repositorio
cd ../lh-ui-ios
pnpm link:tokens                # sobrescribe Sources/LhUITokens/

# 4. Regresión
swift test
```

## Guarda CI

```bash
pnpm link:tokens:check          # comprueba si los tokens están sincronizados (comparación del número de archivos; código de salida 1 si no lo están)
```

## Prohibiciones

- ❌ Modificar a mano `Sources/LhUITokens/` (artefacto generado, gitignore)
- ❌ Hacer commit de los archivos de tokens generados al repositorio
- ❌ Escribir literales de color/espaciado en los componentes (como `Color(red: 0.169, ...)`, `CGFloat(40)`, fuente `14`)
- ❌ Saltarse `link:tokens` copiando los artefactos a mano

## Solución de problemas

| Síntoma | Causa | Solución |
| --- | --- | --- |
| Error de compilación `cannot find 'LhTokens' in scope` | Tokens no sincronizados | `pnpm link:tokens` |
| El valor de un token no coincide con lo esperado | El repositorio core no ha vuelto a ejecutar codegen | Tras `pnpm codegen` en core, volver a enlazar |
| `link:tokens` informa «no se encontró el artefacto de tokens» | Repositorio hermano ausente y paquete npm no instalado | Comprobar la disposición de la familia o `pnpm i -D @lh-ui/core` |
| Los colores oscuros son incorrectos | Se modificó el color principal claro sin actualizar el precálculo del oscuro | Actualizar `color-dark.json` y volver a ejecutar (R-n6) |
| Errores de compilación relacionados con `default` | Nombre de miembro del artefacto generado sin escapar (palabra clave) | Actualizar core (corregido: los nombres de miembro llevan acentos graves `` `default` ``) |
