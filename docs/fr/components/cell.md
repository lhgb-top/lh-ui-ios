# Cellule

Cellule de liste. Icône à gauche + titre (avec étoile rouge obligatoire et sous-titre), valeur et flèche à droite, ligne de séparation inférieure.

> Source du contrat : `lh-ui-core/specs/cell.json` ·
> Cas dorés : `lh-ui-core/cases/cell.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Forme de base

`title` est obligatoire ; `value` / `label` / `icon` sont optionnels. `bordered` contrôle la ligne de séparation inférieure (activée par défaut).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell de base</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">Texte du titre</div></div>
      <div class="sim-cell__value">Valeur de droite</div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main">
        <div class="sim-cell__title">Avec sous-titre</div>
        <div class="sim-cell__label">Texte explicatif du sous-titre</div>
      </div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title">Sans séparateur</div></div>
      <div class="sim-cell__value">Valeur</div>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhCell(title: "Texte du titre", value: "Valeur de droite", clickable: true) {
  // lhOnClick
}
```

## Icône / obligatoire / non cliquable

`icon` est mappé via `LhIconMap` ; `required` affiche une étoile rouge avant le titre ;
lorsque `clickable = false` (par défaut), la cellule ne répond pas aux appuis (cas doré `not-clickable-no-onclick`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Cell étendu</span></div>
  <div class="sim-screen" style="padding: 0;">
    <div class="sim-cell">
      <span class="sim-cell__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:100%;height:100%"><circle cx="11" cy="11" r="7"/><path d="M21 21l-4.3-4.3"/></svg></span>
      <div class="sim-cell__main"><div class="sim-cell__title">Icône à gauche</div></div>
      <div class="sim-cell__arrow">›</div>
    </div>
    <div class="sim-cell">
      <div class="sim-cell__main"><div class="sim-cell__title"><span class="sim-cell__required">*</span>Champ obligatoire</div></div>
      <div class="sim-cell__value">Veuillez choisir</div>
      <div class="sim-cell__arrow">›</div>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `title` | Titre (obligatoire) | `String` | — |
| `value` | Valeur de droite | `String` | `""` |
| `label` | Sous-titre sous le titre | `String` | `""` |
| `icon` | Nom logique de l'icône de gauche (mappé via `LhIconMap`) | `String?` | `nil` |
| `bordered` | Affiche la ligne de séparation inférieure ou non | `Bool` | `true` |
| `clickable` | Cliquable ou non (contrôle la flèche et la porte de clic) | `Bool` | `false` |
| `required` | Affiche l'étoile obligatoire rouge avant le titre ou non | `Bool` | `false` |
| `lhOnClick` | Rappel de clic ; non déclenché lorsque `clickable = false` | `(() -> Void)?` | `nil` |

### Hiérarchie de texte

| Zone | Taille de police | Couleur |
| --- | --- | --- |
| Titre | `cell.fontSizeTitle` (14pt) | `color.text.primary` |
| Sous-titre | `cell.fontSizeLabel` (13pt) | `color.text.secondary` |
| Valeur de droite | `cell.fontSizeValue` (14pt) | `color.text.secondary` |
| Étoile obligatoire | `cell.fontSizeTitle` | `color.danger.default` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `cell.paddingHorizontal` / `cell.paddingVertical` | Marges internes (suivent `spacing.base` / `spacing.sm`) |
| `cell.fontSizeTitle` / `cell.fontSizeLabel` / `cell.fontSizeValue` | Tailles de police des trois niveaux de texte |
| `cell.iconSize` | Taille de l'icône de gauche |
| `cell.gap` | Espacement entre les blocs (suit `spacing.sm`) |
| `cell.borderWidth` | Largeur de la ligne de séparation inférieure |
| `color.border.lighter` | Couleur de la ligne de séparation inférieure |
| `color.text.{primary,secondary}` | Couleurs du titre et de la valeur / du sous-titre |
| `color.danger.default` | Couleur de l'étoile obligatoire |
| `color.background.default` | Couleur de fond de la cellule |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `title-and-value-render` | Dessine à la fois le titre et la valeur | `testTitleAndValueUseFontTokens` |
| `label-renders-secondary-tone` | Le sous-titre prend la couleur de texte secondaire | `testLabelRendersSecondaryTone` |
| `required-uses-danger-token` | L'étoile obligatoire prend le jeton de couleur danger | `testRequiredUsesDangerToken` |
| `bordered-emits-line-command` | La ligne de séparation consomme le jeton border.lighter | `testBorderedUsesBorderTokens` |
| `clickable-emits-onclick` | Cliquable déclenche lhOnClick | `testClickableIsInteractive` |
| `not-clickable-no-onclick` | Non cliquable ne déclenche pas lhOnClick | `testNotClickableIsNotInteractive` |

Tests supplémentaires dédiés au sombre : `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testCellInitAndRender` / `testLayoutUsesCellTokens`.

```bash
swift test --filter LhCellTests    # exécutable sur l'hôte macOS, sans simulateur
```
