# Sélecteur

Sélecteur rotatif en bas d'écran, déclaratif. `@Binding var visible` contrôle l'affichage ; `@Binding var value` est l'index de l'option sélectionnée.
La roue est autodessinée (`DragGesture` + aimantation au relâchement), sans dépendance à un contrôle système.

> Source du contrat : `lh-ui-core/specs/picker.json` ·
> Cas dorés : `lh-ui-core/cases/picker.json` (8 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Forme de base

Apparition en bas de l'écran : barre d'outils en haut (Annuler / Titre / Confirmer), au centre la roue et ses deux lignes indicatrices.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Picker de base</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Sélecteur</button></div>
  </div>
  <div class="sim-picker-mask"></div>
  <div class="sim-picker">
    <div class="sim-picker__toolbar">
      <span class="sim-picker__btn">Annuler</span>
      <span class="sim-picker__title">Sélectionner</span>
      <span class="sim-picker__btn sim-picker__btn--confirm">Confirmer</span>
    </div>
    <div class="sim-picker__wheel">
      <div class="sim-picker__indicator"></div>
      <div class="sim-picker__item">Option 1</div>
      <div class="sim-picker__item sim-picker__item--selected">Option 2</div>
      <div class="sim-picker__item">Option 3</div>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var visible = false
@State private var index = 1
let options = ["Option 1", "Option 2", "Option 3"]

LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Sélectionner"
)
```

## Interaction de la roue

- Le déplacement modifie le décalage d'ensemble ; au relâchement, la roue s'aimante sur le candidat le plus proche
  (durée d'animation `motion.duration.base`) ; lorsque l'index sélectionné change, `onValueChange` est déclenché
  (cas doré `scroll-emits-onvaluechange`).
- L'espacement entre les lignes indicatrices vaut `picker.itemHeight` ; l'option sélectionnée se positionne toujours exactement au centre des deux lignes.

## Rappels et bornes

- « Confirmer » déclenche `onConfirm` (payload = index actuel) et `onClose` (`confirm-also-emits-onclose`).
- « Annuler » déclenche `onCancel`.
- Lorsque `value` est hors limites, un clamp est appliqué côté appareil : les valeurs négatives sont ramenées à zéro
  (`clamp-negative-value-to-zero`), les valeurs au-delà de la limite sont ramenées au dernier élément
  (`clamp-overflow-value-to-last`) ; avec une liste d'options vide, l'index reste à 0.
- `visible = false` n'émet aucune instruction de dessin (`hidden-not-rendered`).

```swift
LhPicker(
  visible: $visible,
  options: options,
  value: $index,
  title: "Sélectionner",
  confirmText: "Confirmer",
  cancelText: "Annuler",
  onValueChange: { newIndex in
    // Rappel d'aimantation de la roue
  },
  onConfirm: { newIndex in
    // Rappel de confirmation (payload = index actuel)
  },
  onCancel: {
    // Rappel d'annulation
  }
)
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `visible` | Affiché ou non (liaison bidirectionnelle contrôlée) | `Bool` | — |
| `options` | Tableau des textes des options (une colonne) | `[String]` | — |
| `value` | Index de l'option sélectionnée (liaison bidirectionnelle contrôlée, clamp automatique hors limites) | `Int` | — |
| `title` | Titre de la barre d'outils | `String` | `""` |
| `confirmText` | Texte du bouton de confirmation ; `nil` (par défaut) utilise le pack de langue | `String?` | Pack de langue (chinois simplifié `"确认"`) |
| `cancelText` | Texte du bouton d'annulation ; `nil` (par défaut) utilise le pack de langue | `String?` | Pack de langue (chinois simplifié `"取消"`) |
| `onValueChange` | Rappel d'aimantation de la roue, le payload est le nouvel index | `((Int) -> Void)?` | `nil` |
| `onConfirm` | Rappel de confirmation, le payload est l'index actuel | `((Int) -> Void)?` | `nil` |
| `onCancel` | Rappel d'annulation | `(() -> Void)?` | `nil` |
| `onClose` | Rappel de fermeture (déclenché aussi bien par Confirmer que par Annuler) | `(() -> Void)?` | `nil` |

### Couleurs

| Zone | Couleur |
| --- | --- |
| Fond du panneau | `color.background.default` |
| Masque | `color.background.overlay` |
| Bouton Annuler / textes des options | `color.text.primary` |
| Titre / bouton Confirmer | `color.primary.default` |
| Lignes indicatrices | `color.border.lighter` (largeur `cell.borderWidth`) |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `picker.height` | Hauteur du panneau (260pt) |
| `picker.toolbarHeight` | Hauteur de la barre d'outils (44pt) |
| `picker.itemHeight` | Hauteur d'un élément (détermine l'espacement de la roue et des lignes indicatrices) |
| `picker.itemFontSize` | Taille de police des options et de la barre d'outils |
| `picker.borderRadius` | Arrondi supérieur |
| `color.background.overlay` / `color.background.default` | Couleurs du masque et du fond du panneau |
| `color.border.lighter` / `cell.borderWidth` | Couleur et largeur des lignes indicatrices |
| `color.primary.default` | Couleur du bouton Confirmer et du texte de l'option sélectionnée |
| `zIndex.{modalBackdrop,modal}` | Niveaux d'empilement du masque et du panneau |
| `motion.duration.base` | Durée de l'animation d'aimantation (en secondes côté iOS) |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `confirm-emits-onconfirm-with-value` | La confirmation déclenche `onConfirm(1)` | `testConfirmUsesPrimaryToken` |
| `confirm-also-emits-onclose` | La confirmation déclenche également onClose | `testConfirmUsesPrimaryToken` |
| `cancel-emits-oncancel` | L'annulation déclenche onCancel | `testCancelUsesNeutralColor` |
| `scroll-emits-onvaluechange` | L'aimantation de la roue déclenche `onValueChange(2)` | Couche View `DragGesture.onEnded` (les assertions de geste nécessitent le simulateur) |
| `clamp-negative-value-to-zero` | Un index négatif est ramené à 0 | `testClampNegativeValueToZero` |
| `clamp-overflow-value-to-last` | Un index au-delà de la limite est ramené au dernier élément | `testClampOverflowValueToLast` |
| `title-renders-text` | Le titre est correctement rendu | `testTitleAndTextsAreExposed` |
| `hidden-not-rendered` | Masqué, non rendu | `testHiddenNotRendered` |

Tests supplémentaires : `testVisibleRendersAppearance` / `testClampedValueIsExposed` /
`testLayoutUsesPickerTokens` / `testEmptyOptionsClampsToZero` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testPickerViewInitAcceptsConstant`.

```bash
swift test --filter LhPickerTests    # exécutable sur l'hôte macOS, sans simulateur
```
