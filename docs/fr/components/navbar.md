# Barre de navigation

Barre de navigation en haut de page. Titre centré + contenu de chaque côté, ligne de séparation inférieure, niveau d'empilement `zIndex.sticky`.

> Source du contrat : `lh-ui-core/specs/navbar.json` ·
> Cas dorés : `lh-ui-core/cases/navbar.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Forme de base

`title` est affiché centré (positionnement absolu, sans chevauchement avec le contenu latéral) ; `leftText` / `rightText` sont alignés respectivement à gauche et à droite.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar de base</span></div>
  <div class="sim-navbar sim-navbar--bordered">
    <span class="sim-navbar__side">Retour</span>
    <span class="sim-navbar__title">青花瓷</span>
    <span class="sim-navbar__side">Plus</span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag sim-tag--primary">Contenu de la page</span></div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhNavbar(
  title: "青花瓷",
  leftText: "Retour",
  rightText: "Plus",
  onLeftClick: { /* Retour */ },
  onRightClick: { /* Plus */ }
)
```

## Icône et bordure

`leftIcon` / `rightIcon` sont mappés via `LhIconMap` et affichés côte à côte avec le texte ; `bordered = false` supprime la ligne de séparation inférieure.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Navbar : icônes</span></div>
  <div class="sim-navbar">
    <span class="sim-navbar__side">
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M15 5l-7 7 7 7"/></svg></span>
      <span>Retour</span>
    </span>
    <span class="sim-navbar__title">Titre</span>
    <span class="sim-navbar__side">
      <span>Réglages</span>
      <span class="sim-navbar__icon"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </span>
  </div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-tag">Barre de navigation sans bordure</span></div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Porte de clic

Lorsque `leftText` / `leftIcon` ne sont pas fournis, le côté gauche ne répond pas aux appuis
(cas doré `no-left-content-no-onleftclick`) ; symétriquement pour le côté droit.
Le positionnement flottant est monté par l'appelant via `.overlay` (convention SwiftUI), le composant
fournissant lui-même le niveau d'empilement `zIndex.sticky`.

```swift
ZStack {
  contentView
    .padding(.top, LhTokens.Navbar.height)
  LhNavbar(title: "青花瓷", leftText: "Retour", onLeftClick: { dismiss() })
    .overlay(alignment: .top) { ... }
}
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `title` | Titre centré | `String` | `""` |
| `leftText` | Texte du côté gauche (ne répond pas aux appuis si vide et sans `leftIcon`) | `String` | `""` |
| `leftIcon` | Nom logique de l'icône de gauche (mappé via `LhIconMap`) | `String?` | `nil` |
| `rightText` | Texte du côté droit (ne répond pas aux appuis si vide et sans `rightIcon`) | `String` | `""` |
| `rightIcon` | Nom logique de l'icône de droite | `String?` | `nil` |
| `bordered` | Affiche la ligne de séparation inférieure ou non | `Bool` | `true` |
| `onLeftClick` | Rappel de clic du côté gauche | `(() -> Void)?` | `nil` |
| `onRightClick` | Rappel de clic du côté droit | `(() -> Void)?` | `nil` |

### Couleurs

| Zone | Couleur |
| --- | --- |
| Fond | `color.background.default` |
| Titre / textes latéraux / icônes | `color.text.primary` |
| Ligne de séparation | `color.border.lighter` (largeur `navbar.borderWidth`) |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `navbar.height` | Hauteur de la barre de navigation (44pt) |
| `navbar.paddingHorizontal` | Marge interne horizontale des deux côtés (12pt) |
| `navbar.titleFontSize` | Taille de police du titre et des textes latéraux (16pt) |
| `navbar.iconSize` | Taille des icônes latérales (20pt) |
| `navbar.borderWidth` | Largeur de la ligne de séparation inférieure |
| `color.border.lighter` | Couleur de la ligne de séparation |
| `color.text.primary` | Couleur du titre et du contenu latéral |
| `color.background.default` | Couleur de fond |
| `zIndex.sticky` | Niveau d'empilement flottant |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `title-renders-text` | Le titre est correctement rendu | `testTitleUsesNavbarTokens` |
| `leftclick-emits-onleftclick` | Un clic à gauche déclenche onLeftClick | `testLeftContentIsClickable` |
| `rightclick-emits-onrightclick` | Un clic à droite déclenche onRightClick | `testRightContentIsClickable` |
| `no-left-content-no-onleftclick` | Sans contenu à gauche, pas de déclenchement | `testNoLeftContentIsNotClickable` |
| `bordered-uses-border-token` | La ligne de séparation consomme le jeton border.lighter | `testBorderedUsesBorderToken` |
| `height-uses-navbar-height-token` | La hauteur consomme le jeton navbar.height | `testHeightUsesNavbarHeightToken` |

Tests supplémentaires : `testContainerUsesBackgroundToken` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testNavbarInitAndRender`.

```bash
swift test --filter LhNavbarTests    # exécutable sur l'hôte macOS, sans simulateur
```
