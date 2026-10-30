# Toast (notification)

Toast léger déclaratif. `@Binding var visible` contrôle l'affichage ; disparaît automatiquement à l'échéance ; le fond sombre prend le jeton `color.ink`.

> Source du contrat : `lh-ui-core/specs/toast.json` ·
> Cas dorés : `lh-ui-core/cases/toast.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Types

Le type par défaut n'a pas d'icône ; les autres types affichent un point de couleur sémantique à gauche du texte. Fond sombre + texte blanc, le contraste est garanti par `color.ink`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Types de Toast</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Par défaut</button></div>
  </div>
  <div class="sim-toast">Enregistré</div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Toast sémantique</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--success">Succès</button></div>
  </div>
  <div class="sim-toast"><span class="sim-toast__dot sim-toast__dot--success"></span>Opération réussie</div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var visible = false

LhToast(visible: $visible, text: "Enregistré", type: .success)
```

## Positionnement

Trois positionnements : `top` (en haut), `center` (au centre, par défaut), `bottom` (en bas).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Positionnement de Toast</span></div>
  <div class="sim-screen">
    <div class="sim-row"><button class="sim-btn sim-btn--primary">Positionnement bottom</button></div>
  </div>
  <div class="sim-toast sim-toast--bottom"><span class="sim-toast__dot sim-toast__dot--warning"></span>Astuce en bas</div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Disparition automatique

Lorsque `visible` passe à `true`, une minuterie `.task` démarre ; après `duration` millisecondes, `visible` est
automatiquement remis à `false` et `onClose` est déclenché (cas doré `auto-hides-after-duration`) ; tant que la
minuterie n'est pas échue, le toast reste affiché sans déclencher de rappel
(`tick-before-duration-keeps-visible`) ; une mise manuelle à `false` depuis l'extérieur ne déclenche pas de rappel
(`hide-is-silent`).

::: tip Unité de durée
Le jeton `toast.duration` est en millisecondes (2000) ; le `Task.sleep` de SwiftUI exige des secondes, la conversion
`Double(duration) / 1000` est effectuée côté appareil (voir `LhToastStyle`).
:::

```swift
LhToast(visible: $visible, text: "Opération réussie", type: .success, duration: 2000) {
  // onClose (déclenché uniquement à la disparition automatique)
}
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `visible` | Affiché ou non (liaison bidirectionnelle contrôlée, automatiquement remis à false à l'échéance) | `Bool` | — |
| `text` | Texte de la notification | `String` | — |
| `type` | Type de notification, détermine la présence et la couleur du point | `LhToastType` | `.default` |
| `lhPosition` | Position d'affichage | `LhToastPosition` | `.center` |
| `duration` | Durée d'affichage (en millisecondes) | `Int` | `2000` (jeton `toast.duration`) |
| `onClose` | Rappel de disparition automatique (un masquage manuel externe ne le déclenche pas) | `(() -> Void)?` | `nil` |

### LhToastType

| Valeur | Couleur du point |
| --- | --- |
| `.default` | Pas de point |
| `.success` | `color.success.default` |
| `.warning` | `color.warning.default` |
| `.danger` | `color.danger.default` |
| `.info` | `color.info.default` |

### LhToastPosition

| Valeur | Positionnement |
| --- | --- |
| `.top` | En haut (marge `spacing.xl`) |
| `.center` | Au centre |
| `.bottom` | En bas (marge `spacing.xl`) |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `toast.paddingHorizontal` / `toast.paddingVertical` | Marges internes |
| `toast.fontSize` | Taille de police du texte de la notification |
| `toast.borderRadius` | Arrondi (suit `radius.small`) |
| `toast.gap` | Espacement entre le point et le texte |
| `toast.duration` | Durée d'affichage par défaut (en millisecondes) |
| `color.ink` | Fond sombre (couverture dédiée en mode sombre, pour se détacher du fond de page) |
| `color.onPrimary` | Texte blanc |
| `color.{success,warning,danger,info}.default` | Couleurs sémantiques du point |
| `zIndex.toast` | Niveau d'empilement |
| `spacing.xl` | Marge de positionnement haut / bas |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `show-makes-visible` | Affiché, donc rendu | `testShowMakesVisible` |
| `auto-hides-after-duration` | Disparition automatique à l'échéance avec déclenchement de onClose | `testDurationConvertsToSeconds` |
| `tick-before-duration-keeps-visible` | Avant l'échéance de la minuterie, reste affiché | `testVisibleDuringDuration` |
| `hide-is-silent` | Un masquage manuel externe ne déclenche pas de rappel | `testHideIsSilent` |
| `success-type-uses-success-token` | Le type succès consomme les jetons succès et ink | `testSuccessTypeUsesSuccessToken` / `testInkBackgroundUsesInkToken` |
| `hidden-emits-no-commands` | Masqué, les instructions de dessin sont vides | `testHiddenNotRendered` |

Tests supplémentaires : `testDefaultTypeHasNoDot` / `testLayoutUsesToastTokens` /
`testDarkColorsComeFromDarkTokens` / `testDarkInkDiffersFromLightInk` /
`testDimensionsAreIdenticalInDarkMode` / `testToastViewInitAcceptsConstant`.

```bash
swift test --filter LhToastTests    # exécutable sur l'hôte macOS, sans simulateur
```
