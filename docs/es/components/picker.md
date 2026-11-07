# Selector

Selector de rueda inferior declarativo. `@Binding var visible` controla la visibilidad y `@Binding var value` es el índice del elemento seleccionado;
la rueda está dibujada a mano (`DragGesture` + ajuste al soltar), sin dependencias de controles del sistema.

> Fuente del contrato: `lh-ui-core/specs/picker.json` ·
> Casos dorados: `lh-ui-core/cases/picker.json` (8 entradas, traducidas a XCTest, ejecutables en el host macOS)

## Uso básico

Aparece desde la parte inferior: una barra de herramientas superior (cancelar / título / confirmar) y, en el centro, la rueda con dos líneas indicadoras.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker básico</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Selector</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">Cancelar</span>
      <span class="sim-picker__title">Seleccionar</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">Confirmar</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">Opción uno</div>
      <div class="sim-picker__item sim-picker__item--selected">Opción dos</div>
      <div class="sim-picker__item">Opción tres</div>
    </div>
  </div>
</div>
<p class="sim-note">Simulación HTML (apariencia de iOS / SwiftUI), no es un renderizado en dispositivo</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["Opción uno", "Opción dos", "Opción tres"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Seleccionar"
)
```

## Interacción de la rueda

- Arrastrar cambia el desplazamiento global; al soltar, se ajusta al candidato más cercano (duración de la animación `motion.duration.base`),
  y cuando cambia el índice seleccionado se dispara `onValueChange` (caso dorado `scroll-emits-onvaluechange`).
- La distancia entre líneas indicadoras = `picker.itemHeight`; el elemento seleccionado siempre cae exactamente en el centro de ambas.

## Devoluciones de llamada y límites

- «Confirmar» dispara `onConfirm` (el payload es el índice actual) y `onClose` (`confirm-also-emits-onclose`).
- «Cancelar» dispara `onCancel`.
- Si `value` está fuera de rango, el extremo lo limita (clamp): los negativos se llevan a cero (`clamp-negative-value-to-zero`) y los que exceden el rango, al último elemento
  (`clamp-overflow-value-to-last`); con una lista de opciones vacía, el índice es siempre 0.
- Con `visible = false` no se emite ningún comando de dibujo (`hidden-not-rendered`).

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Seleccionar",
  confirmText: "Confirmar",
  cancelText: "Cancelar",
  onValueChange: { newIndex in
    // Devolución de llamada del ajuste de la rueda
  },
  onConfirm: { newIndex in
    // Devolución de llamada de confirmación (el payload es el índice actual)
  },
  onCancel: {
    // Devolución de llamada de cancelación
  }
)
```

## API

### Props

| Prop | Descripción | Tipo | Predeterminado |
| --- | --- | --- | --- |
| `visible` | Si se muestra (enlace bidireccional controlado) | `Bool` | — |
| `options` | Array de textos de los candidatos (una columna) | `[String]` | — |
| `value` | Índice del elemento seleccionado (enlace bidireccional controlado; fuera de rango se limita con clamp) | `Int` | — |
| `title` | Título de la barra de herramientas | `String` | `""` |
| `confirmText` | Texto del botón de confirmación; `nil` (predeterminado) usa el paquete de idioma | `String?` | Paquete de idioma (chino simplificado `"确认"`) |
| `cancelText` | Texto del botón de cancelación; `nil` (predeterminado) usa el paquete de idioma | `String?` | Paquete de idioma (chino simplificado `"取消"`) |
| `onValueChange` | Devolución de llamada del ajuste de la rueda; el payload es el nuevo índice | `((Int) -> Void)?` | `nil` |
| `onConfirm` | Devolución de llamada de confirmación; el payload es el índice actual | `((Int) -> Void)?` | `nil` |
| `onCancel` | Devolución de llamada de cancelación | `(() -> Void)?` | `nil` |
| `onClose` | Devolución de llamada de cierre (la disparan tanto confirmar como cancelar) | `(() -> Void)?` | `nil` |

### Colores

| Zona | Color |
| --- | --- |
| Fondo del panel | `color.background.default` |
| Fondo oscuro | `color.background.overlay` |
| Botón de cancelación / texto de los candidatos | `color.text.primary` |
| Título / botón de confirmación | `color.primary.default` |
| Líneas indicadoras | `color.border.lighter` (el ancho toma `cell.borderWidth`) |

## Referencia de tokens

| Token | Uso |
| --- | --- |
| `picker.height` | Altura del panel (260pt) |
| `picker.toolbarHeight` | Altura de la barra de herramientas (44pt) |
| `picker.itemHeight` | Altura de cada elemento (determina la rueda y la distancia entre líneas indicadoras) |
| `picker.itemFontSize` | Tamaño de fuente de los candidatos y de la barra de herramientas |
| `picker.borderRadius` | Radio de esquina superior |
| `color.background.overlay` / `color.background.default` | Fondo oscuro y fondo del panel |
| `color.border.lighter` / `cell.borderWidth` | Color y ancho de las líneas indicadoras |
| `color.primary.default` | Color del botón de confirmación y del texto del elemento seleccionado |
| `zIndex.{modalBackdrop,modal}` | Orden de apilamiento del fondo y del panel |
| `motion.duration.base` | Duración de la animación de ajuste (en segundos en el extremo iOS) |

## Referencia de casos dorados

| case id | Aserción | Test local |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | Confirmar dispara `onConfirm(1)` | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | Confirmar también dispara onClose | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | Cancelar dispara onCancel | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | El ajuste de la rueda dispara `onValueChange(2)` | Capa View `DragGesture.onEnded` (las aserciones de gestos requieren simulador) |
| `clamp-negative-value-to-zero` | Un índice negativo se limita a 0 | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | Un índice que excede el rango se limita al último elemento | `testClampOverflowValueToLast` |
| `title-renders-text` | El título se renderiza correctamente | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | Cuando está oculto, no se renderiza | `testHiddenNotRendered` |

Además, pruebas específicas: `testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`.

```bash
swift test --filter LhPickerTests    # basta con el host macOS, no hace falta simulador
```
