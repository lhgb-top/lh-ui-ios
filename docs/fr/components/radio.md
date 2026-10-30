# Bouton radio

Bouton radio contrôlé. `@Binding var checked` indique « si cet élément est sélectionné » ; généralement utilisé au sein d'un groupe : un seul élément peut valoir `true` dans le même groupe.

> Source du contrat : `lh-ui-core/specs/radio.json` ·
> Cas dorés : `lh-ui-core/cases/radio.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## États

L'état sélectionné est un anneau bordé de couleur principale + un point plein de couleur principale ; l'état non sélectionné est un anneau vide bordé. Le diamètre du point vaut la taille multipliée par `radio.dotScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>États de Radio</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio"><span class="sim-radio__ring"></span>Non sélectionné</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Sélectionné</span>
    </div>
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked sim-radio--disabled"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Sélectionné désactivé</span>
      <span class="sim-radio sim-radio--disabled"><span class="sim-radio__ring"></span>Non sélectionné désactivé</span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var picked = "blue"

LhRadio(checked: Binding(get: { picked == "blue" }, set: { _ in }), value: "blue", label: "青花瓷") { _ in
  picked = "blue"
}
```

## Dimensions

Trois dimensions mappées sur le jeton `radio.size` ; la bordure de l'anneau prend `radio.ringWidth`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Radio</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--small"><span class="sim-radio__dot sim-radio__dot--small"></span></span>Petit</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring"><span class="sim-radio__dot"></span></span>Moyen</span>
      <span class="sim-radio sim-radio--checked"><span class="sim-radio__ring sim-radio__ring--large"><span class="sim-radio__dot sim-radio__dot--large"></span></span>Grand</span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Porte de clic

Un appui sur un élément déjà sélectionné le conserve sélectionné et ne déclenche pas `onChange`
(cas doré `tap-checked-keeps-checked`) ; l'état désactivé ne déclenche rien (`disabled-blocks-change`).
Le conteneur de groupe est réservé à une version ultérieure.

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `checked` | Cet élément est sélectionné ou non (liaison bidirectionnelle contrôlée) | `Bool` | — |
| `value` | Valeur représentée par cet élément (combinée à `checked` pour réaliser un groupe radio) | `String` | `""` |
| `disabled` | Désactivé ou non (ne déclenche pas onChange) | `Bool` | `false` |
| `lhSize` | Dimension du bouton radio, mappée aux jetons de dimension | `LhRadioSize` | `.medium` |
| `label` | Étiquette textuelle | `String` | `""` |
| `onChange` | Rappel de changement de sélection, le payload est la nouvelle valeur | `((Bool) -> Void)?` | `nil` |

### LhRadioSize

| Valeur | Dimension de l'anneau | Diamètre du point |
| --- | --- | --- |
| `.small` | `radio.size.small` (16pt) | Taille × `radio.dotScale` (8pt) |
| `.medium` | `radio.size.medium` (20pt) | Taille × `radio.dotScale` (10pt) |
| `.large` | `radio.size.large` (24pt) | Taille × `radio.dotScale` (12pt) |

### Couleurs

| État | Bordure de l'anneau | Point |
| --- | --- | --- |
| Non sélectionné | `color.border.base` (`radio.ringWidth`) | — |
| Sélectionné | `color.primary.default` | `color.primary.default` |
| Désactivé | `color.disabled.border` | `color.disabled.text` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `radio.size.{small,medium,large}` | Trois dimensions d'anneau |
| `radio.dotScale` | Proportion du point par rapport à la taille de l'anneau (50%) |
| `radio.ringWidth` | Largeur de la bordure de l'anneau |
| `radio.gap` | Espacement entre l'anneau et le texte (suit `spacing.sm`) |
| `color.primary.default` | Couleurs de la bordure et du point à l'état sélectionné |
| `color.border.base` | Couleur de bordure à l'état non sélectionné |
| `color.disabled.{border,text}` | Couleurs de la bordure et du point à l'état désactivé |
| `color.text.{primary,disabled}` | Couleur du texte de l'étiquette |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `tap-unchecked-emits-onchange` | Un appui sur un élément non sélectionné déclenche `onChange(true)` | `testUncheckedIsInteractive` |
| `tap-checked-keeps-checked` | Un appui sur un élément sélectionné le conserve et n'émet pas de rappel | `testCheckedShowsDot` |
| `disabled-blocks-change` | L'état désactivé ne déclenche pas onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | L'état sélectionné consomme les jetons de la couleur principale | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | L'état non sélectionné consomme le jeton de bordure | `testUncheckedUsesBorderToken` |
| `small-size-uses-small-token` | La petite taille consomme les jetons de dimension small | `testSmallSizeUsesSmallToken` |

Tests supplémentaires : `testStrokeUsesRadioTokens` / `testDarkColorsComeFromDarkTokens` /
`testDisabledInDarkUsesDarkDisabledTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testRadioViewInitAcceptsConstant`.

```bash
swift test --filter LhRadioTests    # exécutable sur l'hôte macOS, sans simulateur
```
