# Bouton

Bouton d'action de base. Déclenche une action immédiate ; gère le type, la dimension, le chargement, la désactivation, l'icône et le motif décoratif style chinois.

> Source du contrat : `lh-ui-core/specs/button.json` ·
> Cas dorés : `lh-ui-core/cases/button.json` (8 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Types

Six types déterminent la couleur de fond et la couleur du texte.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Types de Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn">Bouton par défaut</button>
      <button class="sim-btn sim-btn--primary">Bouton principal</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--success">Bouton succès</button>
      <button class="sim-btn sim-btn--warning">Bouton avertissement</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--danger">Bouton danger</button>
      <button class="sim-btn sim-btn--info">Bouton info</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhButton(lhOnClick: {}, type: .primary, text: "Bouton principal")
```

## Dimensions

Trois dimensions mappées sur les jetons `button.height` / `paddingHorizontal` / `fontSize` / `iconSize`.
La forme iOS est un arrondi en capsule (jeton `radius.round`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--small">Bouton petit</button>
      <button class="sim-btn">Bouton moyen</button>
      <button class="sim-btn sim-btn--large">Bouton grand</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## États

Désactivé et chargement ne déclenchent pas `lhOnClick` ; lorsque les deux se cumulent, le **désactivé prime** (cas doré `disabled-precedes-loading`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>États de Button</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Normal</button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Désactivé</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--loading">
        <span class="sim-btn__spinner"></span>Chargement...
      </button>
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Désactivé prioritaire</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Icône et motif décoratif

Le nom de l'icône est résolu par le système d'icônes local (`LhButtonStyle.icon(for:)` mappe vers SF Symbol : search → magnifyingglass,
refresh → arrow.clockwise, check → checkmark, close → xmark ; les noms non enregistrés ne sont pas dessinés).
Le motif décoratif consomme le jeton `color.decoration` : Canvas dessine des hachures à 45°, superposées sous la couleur de fond et au-dessus du texte, sans affecter le contraste.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Icône et motif</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary"><span class="sim-btn__icon"></span>Rechercher</button>
      <button class="sim-btn"><span class="sim-btn__icon"></span>Par défaut</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--pattern">Motif principal</button>
      <button class="sim-btn sim-btn--pattern">Motif par défaut</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Thèmes clair et sombre

Basculez le thème du site en haut à droite : les couleurs des boutons dans le cadre du simulateur changent ; sur appareil réel, via `LhTheme(isDark: true)`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Bouton en sombre</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary">Bouton principal</button>
      <button class="sim-btn">Bouton par défaut</button>
    </div>
    <div class="sim-row">
      <button class="sim-btn sim-btn--primary sim-btn--disabled">Désactivé</button>
      <button class="sim-btn sim-btn--success">Succès</button>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel ; les valeurs clair/sombre proviennent toutes de l'instantané des jetons core</p>

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `lhOnClick` | Callback de clic ; non déclenché si `disabled` ou `loading` vaut true | `() -> Void` | — |
| `type` | Type de bouton, détermine la couleur de fond et du texte | `LhButtonType` | `.default` |
| `lhSize` | Dimension du bouton, mappée sur les jetons de dimension | `LhButtonSize` | `.medium` |
| `disabled` | Désactivé ou non | `Bool` | `false` |
| `loading` | En chargement ou non (affiche un indicateur, ne déclenche pas lhOnClick) | `Bool` | `false` |
| `icon` | Nom de l'icône (résolu via le mapping SF Symbol) | `String?` | `nil` |
| `bgPattern` | Dessiner ou non le motif décoratif style chinois | `Bool` | `false` |
| `label` / `text` | Contenu textuel du bouton (slot default du spec) | `Text` / chaîne | — |

### LhButtonType

| Valeur | Fond | Couleur du texte |
| --- | --- | --- |
| `.default` | `color.background.default` | `color.text.primary` |
| `.primary` | `color.primary.default` | `color.onPrimary` |
| `.success` | `color.success.default` | `color.onPrimary` |
| `.warning` | `color.warning.default` | `color.onPrimary` |
| `.danger` | `color.danger.default` | `color.onPrimary` |
| `.info` | `color.info.default` | `color.onPrimary` |

### LhButtonSize

| Valeur | height | paddingHorizontal | fontSize | iconSize |
| --- | --- | --- | --- | --- |
| `.small` | `button.height.small` (32pt) | `button.paddingHorizontal.small` (16pt) | `button.fontSize.small` (13pt) | `button.iconSize.small` (16pt) |
| `.medium` | `button.height.medium` (40pt) | `button.paddingHorizontal.medium` (20pt) | `button.fontSize.medium` (14pt) | `button.iconSize.medium` (18pt) |
| `.large` | `button.height.large` (48pt) | `button.paddingHorizontal.large` (24pt) | `button.fontSize.large` (16pt) | `button.iconSize.large` (20pt) |

Surcharges de l'état désactivé : fond `color.disabled.bg`, texte `color.disabled.text`, bordure `color.disabled.border`.

## Référence des jetons

Jetons consommés par le bouton (alignés un à un avec les `tokenRefs` de `specs/button.json`) :

| Jeton | Utilisation |
| --- | --- |
| `button.height.{small,medium,large}` | Trois hauteurs |
| `button.paddingHorizontal.{small,medium,large}` | Trois marges internes horizontales |
| `button.fontSize.{small,medium,large}` | Trois tailles de police |
| `button.iconSize.{small,medium,large}` | Trois tailles d'icône |
| `button.borderRadius` / `button.borderWidth` | Arrondi (suit `radius.base`) et épaisseur de bordure |
| `button.fontWeight` | Graisse (suit `typography.fontWeight.primary`, mappée côté plateforme vers Font.Weight) |
| `color.primary.default` / `color.onPrimary` | Fond/texte du type principal |
| `color.{success,warning,danger,info}.default` | Fonds des types sémantiques |
| `color.background.default` / `color.text.primary` / `color.border.base` | Fond/texte/bordure du type par défaut |
| `color.disabled.{bg,text,border}` | Les trois couleurs de l'état désactivé |
| `color.decoration` | Couleur du motif décoratif |
| `shadow.lighter` | Élévation par défaut (porteuse LhShadow) |
| `spacing.xs` | Espacement entre l'icône et le texte |

## Correspondance des cas dorés

Correspondance entre les 8 assertions de `cases/button.json` et les XCTest :

| case id | Assertion | Test local |
| --- | --- | --- |
| `click-emits-onclick` | Garde ouverte (interactif) | `LhButtonTests.testEnabledButtonIsInteractive` |
| `disabled-blocks-click` | État désactivé non interactif | `testDisabledIsNotInteractive` |
| `loading-blocks-click` | État de chargement non interactif | `testLoadingIsNotInteractive` |
| `disabled-precedes-loading` | Désactivé prioritaire + apparence désactivée | `testDisabledPrecedesLoading` |
| `default-type-renders-text` | Type par défaut : fond/texte neutres | `testDefaultTypeUsesNeutralTokens` |
| `primary-type-uses-primary-tokens` | Type principal consomme les jetons de la couleur principale | `testPrimaryTypeUsesPrimaryTokens` |
| `small-size-uses-small-tokens` | Petite taille consomme les jetons de dimension small | `testSmallSizeUsesSmallTokens` |
| `bgpattern-uses-decoration-token` | Motif décoratif consomme la couleur de décoration | `testBgPatternUsesDecorationToken` |

Tests supplémentaires dédiés au sombre : `testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode`.

```bash
swift test    # exécutable sur l'hôte macOS, sans simulateur
```
