# Étiquette

Étiquette compacte pour le marquage et la sélection. Plus petite qu'un bouton ; gère les types sémantiques, la bordure, l'arrondi en capsule et le bouton de fermeture.

> Source du contrat : `lh-ui-core/specs/tag.json` ·
> Cas dorés : `lh-ui-core/cases/tag.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Types

Six types déterminent la couleur de fond et la couleur du texte. `plain` est la forme bordée à fond clair (fond sémantique clair + bordure sémantique).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Types de Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag">Par défaut</span>
      <span class="sim-tag sim-tag--primary">Principal</span>
      <span class="sim-tag sim-tag--success">Succès</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--warning">Avertissement</span>
      <span class="sim-tag sim-tag--danger">Danger</span>
      <span class="sim-tag sim-tag--info">Info</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--plain sim-tag--primary">Principal bordé</span>
      <span class="sim-tag sim-tag--plain sim-tag--success">Succès bordé</span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhTag(text: "Principal", type: .primary)
LhTag(text: "Succès bordé", type: .success, plain: true)
```

## Dimensions et arrondi

Trois dimensions mappées sur les jetons `tag.height` / `paddingHorizontal` / `fontSize` ; `round` remplace l'arrondi par la moitié de la hauteur (capsule).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--small sim-tag--primary">Petit</span>
      <span class="sim-tag sim-tag--primary">Moyen</span>
      <span class="sim-tag sim-tag--large sim-tag--primary">Grand</span>
    </div>
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Angle droit</span>
      <span class="sim-tag sim-tag--primary sim-tag--round">Angle arrondi</span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Fermable

`closable` affiche un bouton de fermeture à droite ; un clic déclenche `onClose` (cas doré `closable-tap-emits-onclose`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Fermeture de Tag</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-tag sim-tag--primary">Fermable<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
      <span class="sim-tag">Fermable<svg class="sim-tag__close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.4"><path d="M6 6l12 12M18 6L6 18"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhTag(text: "Fermable", type: .primary, closable: true) {
  // onClose
}
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `text` | Texte de l'étiquette | `String` | — |
| `type` | Type de l'étiquette, détermine la couleur de fond et du texte | `LhTagType` | `.default` |
| `lhSize` | Dimension de l'étiquette, mappée sur les jetons de dimension | `LhTagSize` | `.medium` |
| `plain` | Forme bordée à fond clair ou non | `Bool` | `false` |
| `round` | Arrondi en capsule ou non (rayon = hauteur / 2) | `Bool` | `false` |
| `closable` | Afficher ou non le bouton de fermeture | `Bool` | `false` |
| `onClose` | Callback de clic sur le bouton de fermeture | `(() -> Void)?` | `nil` |

### LhTagType

| Valeur | Fond | Couleur du texte |
| --- | --- | --- |
| `.default` | `color.background.default` + bordure `color.border.base` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

Lorsque `plain = true` : le fond prend `color.<type>.bg`, la bordure et le texte prennent `color.<type>.default` (le type `.default` ignore `plain`, cas doré `default-type-renders-text`).

### LhTagSize

| Valeur | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `tag.height.small` (20pt) | `tag.paddingHorizontal.small` (8pt) | `tag.fontSize.small` (12pt) |
| `.medium` | `tag.height.medium` (24pt) | `tag.paddingHorizontal.medium` (12pt) | `tag.fontSize.medium` (13pt) |
| `.large` | `tag.height.large` (28pt) | `tag.paddingHorizontal.large` (16pt) | `tag.fontSize.large` (14pt) |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `tag.height.{small,medium,large}` | Trois hauteurs |
| `tag.paddingHorizontal.{small,medium,large}` | Trois marges internes horizontales |
| `tag.fontSize.{small,medium,large}` | Trois tailles de police |
| `tag.borderRadius` / `tag.borderWidth` | Arrondi par défaut (suit `radius.small`) et épaisseur de bordure |
| `tag.gap` | Espacement entre le texte et le bouton de fermeture (suit `spacing.xs`) |
| `color.{primary,success,warning,danger,info}.{default,bg}` | Fonds des types sémantiques et fond clair bordé |
| `color.onPrimary` | Couleur de texte des types sémantiques |
| `color.background.default` / `color.text.primary` / `color.border.base` | Les trois couleurs du type par défaut |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `default-type-renders-text` | Type par défaut : fond/texte neutres, ignore plain | `testDefaultTypeUsesNeutralTokens` / `testDefaultTypeIgnoresPlain` |
| `primary-type-uses-primary-tokens` | Type principal consomme la couleur principale et onPrimary | `testPrimaryTypeUsesPrimaryTokens` |
| `plain-uses-bg-tokens` | plain consomme le bg sémantique et la bordure sémantique | `testPlainUsesBgTokens` |
| `small-size-uses-small-tokens` | Petite taille consomme les jetons de dimension small | `testSmallSizeUsesSmallTokens` |
| `round-makes-radius-half-height` | L'arrondi round == hauteur / 2 | `testRoundMakesRadiusHalfHeight` |
| `closable-tap-emits-onclose` | Le bouton de fermeture déclenche onClose | `testClosableTagInitAndRender` (les assertions de geste nécessitent le simulateur) |

Tests supplémentaires dédiés au sombre : `testDarkColorsComeFromDarkTokens` / `testPlainInDarkUsesDarkBgTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhTagTests    # exécutable sur l'hôte macOS, sans simulateur
```
