# Icône

Icône vectorielle. Un nom logique est mappé vers le symbole système de la plateforme (côté iOS : SF Symbol) ; la dimension et le ton passent entièrement par des jetons.

> Source du contrat : `lh-ui-core/specs/icon.json` ·
> Cas dorés : `lh-ui-core/cases/icon.json` (5 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Tons

`tone` détermine la couleur de l'icône. `default` suit la couleur de texte principale, `regular` / `secondary` prennent les couleurs de texte du niveau correspondant, les autres prennent les couleurs sémantiques.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tons de Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--success"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M4 12.5l5 5L20 6.5"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-icon sim-icon--warning"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 3l10 18H2z"/><path d="M12 10v5"/></svg></span>
      <span class="sim-icon sim-icon--danger"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M12 8v5M12 16.5v.5"/></svg></span>
      <span class="sim-icon sim-icon--regular"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
      <span class="sim-icon sim-icon--secondary"><svg viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="8"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel ; sur appareil réel, ce sont des vecteurs SF Symbol qui sont dessinés</p>

```swift
LhIcon(name: "star", tone: .primary)
```

## Dimensions

Trois dimensions mappées sur le jeton `icon.size`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Icon</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-icon sim-icon--small sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
      <span class="sim-icon sim-icon--large sim-icon--primary"><svg viewBox="0 0 24 24" fill="currentColor"><path d="M12 2l2.9 6.3 6.9.8-5.1 4.7 1.4 6.8L12 17.3 5.9 20.6l1.4-6.8L2.2 9.1l6.9-.8z"/></svg></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Correspondance des noms d'icône

`name` est un nom logique aligné avec la lignée web, mappé côté plateforme vers SF Symbol via `LhIconMap.symbol(for:)` :

| Nom logique | SF Symbol |
| --- | --- |
| `star` / `search` / `check` / `close` | `star` / `magnifyingglass` / `checkmark` / `xmark` |
| `arrow-up` / `arrow-down` / `arrow-left` / `arrow-right` | `arrow.up` / `arrow.down` / `arrow.left` / `arrow.right` |
| `refresh` / `plus` / `minus` / `eye` / `link` | `arrow.clockwise` / `plus` / `minus` / `eye` / `link` |

Les noms non enregistrés ne sont pas dessinés (retour `nil`), sans crash.

```swift
LhIcon(name: "search", lhSize: .large, tone: .secondary) {
  // lhOnClick
}
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `name` | Nom logique de l'icône (mappé vers SF Symbol via `LhIconMap`) | `String` | — |
| `lhSize` | Dimension de l'icône, mappée sur les jetons de dimension | `LhIconSize` | `.medium` |
| `tone` | Ton de l'icône, mappé sur les jetons de couleur de texte / sémantiques | `LhIconTone` | `.default` |
| `lhOnClick` | Callback de clic ; s'il n'est pas fourni, le clic n'est pas géré | `(() -> Void)?` | `nil` |

### LhIconSize

| Valeur | Dimension |
| --- | --- |
| `.small` | `icon.size.small` (16pt) |
| `.medium` | `icon.size.medium` (20pt) |
| `.large` | `icon.size.large` (24pt) |

### LhIconTone

| Valeur | Couleur |
| --- | --- |
| `.default` | `color.text.primary` |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `icon.size.{small,medium,large}` | Trois dimensions |
| `color.text.{primary,regular,secondary}` | Tons de texte |
| `color.{primary,success,warning,danger,info}.default` | Tons sémantiques |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `click-emits-onclick` | Un clic déclenche `lhOnClick` une fois | Couche View `onTapGesture` (les assertions de geste nécessitent le simulateur, voir #Preview) |
| `default-tone-uses-text-primary` | Le ton par défaut prend la couleur de texte principale | `testDefaultToneUsesTextPrimary` |
| `primary-tone-uses-primary-token` | Le ton principal prend le jeton de la couleur principale | `testPrimaryToneUsesPrimaryToken` |
| `small-size-uses-small-token` | La petite taille prend le jeton de dimension small | `testSmallSizeUsesSmallToken` |
| `render-emits-icon-command` | Émet une seule commande de dessin d'icône | `testRegisteredIconResolvesToSymbol` / `testUnknownIconReturnsNilSymbol` |

Tests supplémentaires dédiés au sombre : `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode`.

```bash
swift test --filter LhIconTests    # exécutable sur l'hôte macOS, sans simulateur
```
