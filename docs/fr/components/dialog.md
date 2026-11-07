# Boîte de dialogue

Boîte de dialogue modale déclarative. `@Binding var visible` contrôle l'affichage ; masque + panneau centré, les boutons réutilisent `LhButton`.

> Source du contrat : `lh-ui-core/specs/dialog.json` ·
> Cas dorés : `lh-ui-core/cases/dialog.json` (8 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Types

Six types déterminent la couleur sémantique du bouton de confirmation (le mapping `buttonType(for:)` renvoie vers `LhButtonType`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Types de Dialog</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Boîte de dialogue par défaut</button>
      <button class="sim-btn sim-btn--danger">Boîte de dialogue danger</button>
    </div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Confirmation de suppression</div>
    <div class="sim-dialog__content">Cette action supprimera définitivement cet élément. Voulez-vous continuer ?</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Annuler</button>
      <button class="sim-btn sim-btn--danger">Confirmer</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var visible = false

LhDialog(
  visible: $visible,
  title: "Confirmation de suppression",
  content: "Cette action supprimera définitivement cet élément. Voulez-vous continuer ?",
  type: .danger,
  confirmText: "Confirmer",
  cancelText: "Annuler"
)
```

## Affichage et rappels

- `visible = true` affiche le masque et le panneau ; `visible = false` n'émet aucune instruction de dessin (cas doré `hidden-not-rendered`).
- Un appui sur « Confirmer » déclenche successivement `onConfirm` puis `onClose` (`confirm-also-emits-onclose`).
- Un appui sur « Annuler » déclenche `onCancel` ; `onClose` est pris en charge en interne par le composant, qui remet `visible` à `false` (enveloppé dans `withAnimation`).
- Lorsque `closable = true`, un appui sur le masque déclenche également `onClose` (`closable-overlay-emits-onclose`) ; par défaut, le masque ne ferme pas (`not-closable-blocks-overlay-close`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Fermeture par le masque de Dialog</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">closable = true</button></div>
  </div>
  <div class="sim-dialog-mask"></div>
  <div class="sim-dialog">
    <div class="sim-dialog__title">Information</div>
    <div class="sim-dialog__content">Appuyez sur le masque pour fermer</div>
    <div class="sim-dialog__actions">
      <button class="sim-btn">Annuler</button>
      <button class="sim-btn sim-btn--primary">Confirmer</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `visible` | Affichée ou non (liaison bidirectionnelle contrôlée) | `Bool` | — |
| `title` | Titre | `String` | `""` |
| `content` | Contenu du corps | `String` | `""` |
| `type` | Type de boîte de dialogue, détermine la couleur sémantique du bouton de confirmation | `LhDialogType` | `.default` |
| `confirmText` | Texte du bouton de confirmation ; `nil` (par défaut) utilise le pack de langue, `""` masque le bouton | `String?` | Pack de langue (chinois simplifié `"确认"`) |
| `cancelText` | Texte du bouton d'annulation ; `nil` (par défaut) utilise le pack de langue, `""` masque le bouton | `String?` | Pack de langue (chinois simplifié `"取消"`) |
| `closable` | Fermeture par appui sur le masque ou non | `Bool` | `false` |
| `onConfirm` | Rappel de confirmation | `(() -> Void)?` | `nil` |
| `onCancel` | Rappel d'annulation | `(() -> Void)?` | `nil` |
| `onClose` | Rappel de fermeture (appui sur le masque / bouton « Annuler » / bouton « Confirmer » le déclenchent tous) | `(() -> Void)?` | `nil` |

### LhDialogType

| Valeur | Type du bouton de confirmation | Fond |
| --- | --- | --- |
| `.default` | `.default` | `color.background.default` + bordure |
| `.primary` | `.primary` | `color.primary.default` |
| `.success` | `.success` | `color.success.default` |
| `.warning` | `.warning` | `color.warning.default` |
| `.danger` | `.danger` | `color.danger.default` |
| `.info` | `.info` | `color.info.default` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `dialog.width` | Largeur du panneau (320pt) |
| `dialog.paddingHorizontal` / `dialog.paddingVertical` | Marges internes du panneau |
| `dialog.borderRadius` | Arrondi du panneau |
| `dialog.titleFontSize` / `dialog.contentFontSize` | Tailles de police du titre et du corps |
| `dialog.gap` | Espacement vertical entre les blocs |
| `color.background.overlay` | Couleur du masque |
| `color.background.default` | Couleur de fond du panneau |
| `color.text.{primary,regular}` | Couleurs du titre et du corps |
| `shadow.base` | Ombre du panneau (support LhShadow) |
| `zIndex.{modalBackdrop,modal}` | Niveaux d'empilement du masque et du panneau |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `confirm-emits-onconfirm` | La confirmation déclenche onConfirm | `testConfirmUsesTypeColor` |
| `cancel-emits-oncancel` | L'annulation déclenche onCancel | `testCancelUsesNeutralColor` |
| `confirm-also-emits-onclose` | La confirmation déclenche également onClose | `testConfirmUsesTypeColor` |
| `closable-overlay-emits-onclose` | Un appui sur le masque déclenche onClose | `testClosableFlagIsExposed` |
| `not-closable-blocks-overlay-close` | Par défaut, le masque ne ferme pas | `testNotClosableBlocksOverlay` |
| `hidden-not-rendered` | Masqué, non rendu | `testHiddenNotRendered` |
| `title-renders-text` | Le titre est correctement rendu | `testTitleUsesTitleTokens` |
| `danger-type-uses-danger-token` | Le type danger consomme le jeton de couleur danger | `testDangerTypeUsesDangerToken` |

Tests supplémentaires : `testVisibleRendersAppearance` / `testLayoutUsesDialogTokens` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testDialogViewInitAcceptsConstant`.

```bash
swift test --filter LhDialogTests    # exécutable sur l'hôte macOS, sans simulateur
```
