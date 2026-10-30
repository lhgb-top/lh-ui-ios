# Chargement

Indicateur de chargement. Côté SwiftUI, anneau autodessiné (`Circle().trim` + animation de rotation) ; la durée est réglée par `motion.duration.base` (en secondes).

> Source du contrat : `lh-ui-core/specs/loading.json` ·
> Cas dorés : `lh-ui-core/cases/loading.json` (5 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Tons

Cinq tons issus des jetons de couleurs sémantiques, `.primary` par défaut.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Tons de Loading</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--success"></span>
      <span class="sim-loading sim-loading--warning"></span>
    </div>
    <div class="sim-row">
      <span class="sim-loading sim-loading--danger"></span>
      <span class="sim-loading sim-loading--info"></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhLoading(tone: .success)
```

## Dimensions

Trois dimensions mappées sur le jeton `loading.size` ; la largeur du trait prend `loading.strokeWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Loading</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-loading sim-loading--small"></span>
      <span class="sim-loading"></span>
      <span class="sim-loading sim-loading--large"></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Image statique

`animating: false` fige la rotation (le cas doré `render-emits-ring-command` vérifie les paramètres de dessin
de l'anneau statique) ; sert aux tests par capture d'écran et aux images statiques de la documentation.

```swift
LhLoading(lhSize: .large, animating: false)
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `lhSize` | Dimension de l'anneau, mappée aux jetons de dimension | `LhLoadingSize` | `.medium` |
| `tone` | Ton de l'anneau, mappé aux jetons de couleurs sémantiques | `LhLoadingTone` | `.primary` |
| `animating` | Rotation ou non (`false` fige en image statique) | `Bool` | `true` |

### LhLoadingSize

| Valeur | Dimension |
| --- | --- |
| `.small` | `loading.size.small` (16pt) |
| `.medium` | `loading.size.medium` (20pt) |
| `.large` | `loading.size.large` (24pt) |

### LhLoadingTone

| Valeur | Couleur |
| --- | --- |
| `.primary` | `color.primary.default` |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `loading.size.{small,medium,large}` | Trois dimensions |
| `loading.strokeWidth` | Largeur du trait de l'anneau |
| `color.{primary,success,warning,danger,info}.default` | Cinq tons |
| `motion.duration.base` | Durée d'une rotation complète (en secondes côté iOS) |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `medium-size-uses-medium-token` | La taille moyenne prend le jeton de dimension medium | `testMediumSizeUsesMediumToken` |
| `large-size-uses-large-token` | La grande taille prend le jeton de dimension large | `testLargeSizeUsesLargeToken` |
| `primary-tone-uses-primary-token` | Le ton principal prend le jeton de couleur principale | `testPrimaryToneUsesPrimaryToken` |
| `success-tone-uses-success-token` | Le ton succès prend le jeton de couleur succès | `testSuccessToneUsesSuccessToken` |
| `render-emits-ring-command` | Le trait de l'anneau consomme le jeton strokeWidth | `testRingUsesStrokeWidthToken` |

Tests supplémentaires dédiés au sombre : `testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testLoadingViewInitAndRender`.

```bash
swift test --filter LhLoadingTests    # exécutable sur l'hôte macOS, sans simulateur
```
