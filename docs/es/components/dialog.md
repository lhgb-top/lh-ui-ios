# Diálogo

Diálogo modal declarativo. `@Binding var visible` controla la visibilidad; renderiza un fondo oscuro más un panel centrado, y sus botones reutilizan `LhButton`.

> Fuente del contrato: `lh-ui-core/specs/dialog.json` ·
> Casos dorados: `lh-ui-core/cases/dialog.json` (8 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Tipos

Seis tipos determinan el color semántico del botón de confirmación (`buttonType(for:)` se mapea a `LhButtonType`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tipos de Dialog</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Diálogo predeterminado</button>
      <button class="sim-btn sim-btn--danger">Diálogo de peligro</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Confirmar eliminación</div>
    <div class="sim-dialog__content">Esta acción eliminará el elemento de forma permanente. ¿Desea continuar?</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Cancelar</button>
      <button class="sim-btn sim-btn--danger">Confirmar</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "Confirmar eliminación",
  content: "Esta acción eliminará el elemento de forma permanente. ¿Desea continuar?",
  type: .danger,
  confirmText: "Confirmar",
  cancelText: "Cancelar"
)
```

## Visibilidad y devoluciones de llamada

- `visible = true` renderiza el fondo oscuro y el panel; `visible = false` no emite ningún comando de dibujo (caso dorado `hidden-not-rendered`).
- Al pulsar «Confirmar» se disparan `onConfirm` y luego `onClose`, en este orden (`confirm-also-emits-onclose`).
- Al pulsar «Cancelar» se dispara `onCancel`; `onClose` es el responsable de volver a poner `visible` a `false` dentro del componente (envuelto en `withAnimation`).
- Con `closable = true`, pulsar el fondo oscuro también dispara `onClose` (`closable-overlay-emits-onclose`); por defecto no se cierra (`not-closable-blocks-overlay-close`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Fondo de Dialog cerrable</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Aviso</div>
    <div class="sim-dialog__content">Pulse el fondo oscuro para cerrar</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Cancelar</button>
      <button class="sim-btn sim-btn--primary">Confirmar</button>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `visible` | Si es visible (enlace bidireccional controlado) | `Bool` | — |
| `title` | Título | `String` | `""` |
| `content` | Contenido del cuerpo | `String` | `""` |
| `type` | Tipo de diálogo, determina el color semántico del botón de confirmación | `LhDialogType` | `.default` |
| `confirmText` | Texto del botón de confirmación | `String` | `"确认"` |
| `cancelText` | Texto del botón de cancelación | `String` | `"取消"` |
| `closable` | Si una pulsación en el fondo puede cerrarlo | `Bool` | `false` |
| `onConfirm` | Devolución de llamada de confirmación | `(() -> Void)?` | `nil` |
| `onCancel` | Devolución de llamada de cancelación | `(() -> Void)?` | `nil` |
| `onClose` | Devolución de llamada de cierre (la disparan el fondo, el botón Cancelar y el botón Confirmar) | `(() -> Void)?` | `nil` |

### LhDialogType

| Valor | Tipo del botón de confirmación | Fondo |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + borde |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `dialog.width` | Ancho del panel (320pt) |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | Relleno del panel |
| `dialog.borderRadius` | Radio de esquina del panel |
| `dialog.titleFontSize` / `dialog.contentFontSize` | Tamaños de fuente del título y del cuerpo |
| `dialog.gap` | Espacio vertical entre bloques |
| `color.background.overlay` | Color del fondo oscuro |
| `color.background.default` | Color de fondo del panel |
| `color.text.{primary,regular}` | Colores del título y del cuerpo |
| `shadow.base` | Sombra del panel (portador LhShadow) |
| `zIndex.{modalBackdrop,modal}` | Orden de apilamiento del fondo y del panel |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `confirm-emits-onconfirm` | Confirmar dispara onConfirm | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | Cancelar dispara onCancel | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | Confirmar también dispara onClose | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | Una pulsación en el fondo dispara onClose | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | Por defecto el fondo no lo cierra | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | Cuando está oculto, no se renderiza nada | `testHiddenNotRendered` |
| `title-renders-text` | El título se renderiza correctamente | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | El tipo danger consume el token de color de peligro | `testDangerTypeUsesDangerToken` |

Además, pruebas específicas: `testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`.

```bash
swift test --filter LhDialogTests    # basta con el host macOS, no hace falta simulador
```
