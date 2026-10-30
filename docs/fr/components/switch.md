# Interrupteur

Interrupteur contrôlé. `@Binding var checked` est une liaison bidirectionnelle ; la track a un ratio 2:1, le diamètre du curseur = hauteur − 2 × `switch.gap`.

> Source du contrat : `lh-ui-core/specs/switch.json` ·
> Cas dorés : `lh-ui-core/cases/switch.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## États

À l'état ouvert, la track prend la couleur principale et le curseur se déplace à droite ; à l'état fermé, la track prend la couleur de bordure. L'état `loading` affiche un petit indicateur à l'intérieur de la track et ne répond pas au basculement.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>États de Switch</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
    <div class="sim-row">
      <span class="sim-switch sim-switch--on sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--disabled"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var on = true

LhSwitch(checked: $on) { newValue in
  // onChange
}
```

## Dimensions

Trois dimensions mappées sur les jetons `switch.width` / `switch.height` ; l'arrondi s'adapte automatiquement au rayon de la track selon la hauteur.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Switch</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-switch sim-switch--small sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--on"><span class="sim-switch__thumb"></span></span>
      <span class="sim-switch sim-switch--large sim-switch--on"><span class="sim-switch__thumb"></span></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## État de chargement

Lorsque `loading = true`, la track intègre un `LhLoading(lhSize: .small, tone: .primary)` et l'appui est intercepté
par la porte de clic (cas doré `loading-blocks-change`).

```swift
LhSwitch(checked: $submitting, loading: submitting) { _ in }
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `checked` | État de l'interrupteur (liaison bidirectionnelle contrôlée) | `Bool` | — |
| `disabled` | Désactivé ou non (ne déclenche pas onChange) | `Bool` | `false` |
| `loading` | En chargement ou non (indicateur intégré, ne déclenche pas onChange) | `Bool` | `false` |
| `lhSize` | Dimension de l'interrupteur, mappée aux jetons de dimension | `LhSwitchSize` | `.medium` |
| `onChange` | Rappel de changement d'état, le payload est la nouvelle valeur | `((Bool) -> Void)?` | `nil` |

### LhSwitchSize

| Valeur | width | height | Diamètre du curseur |
| --- | --- | --- | --- |
| `.small` | `switch.width.small` (36pt) | `switch.height.small` (20pt) | height − 2 × `switch.gap` (16pt) |
| `.medium` | `switch.width.medium` (44pt) | `switch.height.medium` (24pt) | height − 2 × `switch.gap` (20pt) |
| `.large` | `switch.width.large` (52pt) | `switch.height.large` (28pt) | height − 2 × `switch.gap` (24pt) |

### Couleurs

| État | Track | Curseur |
| --- | --- | --- |
| Fermé | `color.border.base` | `color.onPrimary` |
| Ouvert | `color.primary.default` | `color.onPrimary` |
| Désactivé | `color.disabled.bg` | `color.disabled.text` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `switch.width.{small,medium,large}` | Trois largeurs de track |
| `switch.height.{small,medium,large}` | Trois hauteurs de track |
| `switch.gap` | Marge interne entre le curseur et la track (détermine le diamètre du curseur) |
| `color.primary.default` | Couleur de la track à l'état ouvert |
| `color.border.base` | Couleur de la track à l'état fermé |
| `color.onPrimary` | Couleur du curseur |
| `color.disabled.{bg,text}` | Les deux couleurs de l'état désactivé |
| `motion.duration.base` | Durée de l'animation de glissement du curseur (en secondes côté iOS) |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | Un appui active et rappelle `onChange(true)` | `testDefaultIsInteractive` |
| `tap-checked-turns-off` | Un appui à l'état ouvert passe à l'état fermé | `testCheckedUsesPrimaryTrack` |
| `disabled-blocks-change` | L'état désactivé ne déclenche pas onChange | `testDisabledBlocksChange` |
| `loading-blocks-change` | L'état de chargement ne déclenche pas onChange | `testLoadingBlocksChange` |
| `checked-uses-primary-token` | L'état ouvert consomme le jeton de la couleur principale, pas le jeton de bordure | `testCheckedUsesPrimaryToken` |
| `unchecked-uses-border-token` | L'état fermé consomme le jeton de bordure | `testUncheckedUsesBorderToken` |

Tests supplémentaires : `testSizeUsesSwitchTokens` / `testThumbDiameterIsHeightMinusTwoGaps` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testSwitchViewInitAcceptsConstant`.

```bash
swift test --filter LhSwitchTests    # exécutable sur l'hôte macOS, sans simulateur
```
