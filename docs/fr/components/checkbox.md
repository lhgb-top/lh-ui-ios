# Case à cocher

Case à cocher contrôlée. `@Binding var checked` est une liaison bidirectionnelle ; prend en charge trois états : coché / décoché / indéterminé.

> Source du contrat : `lh-ui-core/specs/checkbox.json` ·
> Cas dorés : `lh-ui-core/cases/checkbox.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## États

L'état coché est un carré plein de couleur principale avec une coche blanche ; l'état indéterminé est un carré plein de couleur principale avec une barre blanche ; l'état décoché est un cadre vide bordé.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>États de Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox"><span class="sim-checkbox__box"></span>Décoché</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Coché</span>
    </div>
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--indeterminate"><span class="sim-checkbox__box"><span class="sim-checkbox__dash"></span></span>Indéterminé</span>
      <span class="sim-checkbox sim-checkbox--checked sim-checkbox--disabled"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Désactivé</span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Coché") { newValue in
  // onChange
}
```

## Dimensions

Trois dimensions mappées sur le jeton `checkbox.size` ; la largeur du trait de la coche prend `checkbox.checkWidth`,
et la largeur de la barre de l'état indéterminé vaut la taille du carré multipliée par `checkbox.dashScale` (50%).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Checkbox</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--small"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Petit</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Moyen</span>
      <span class="sim-checkbox sim-checkbox--checked"><span class="sim-checkbox__box sim-checkbox__box--large"><svg class="sim-checkbox__check" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.8"><path d="M4 12.5l5 5L20 6.5"/></svg></span>Grand</span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## État indéterminé

Lorsque `indeterminate = true`, la coche est remplacée par une barre ; un appui passe toujours à l'état **coché**
(cas doré `indeterminate-becomes-checked`), et non à un simple basculement.

```swift
@State private var checked = false

LhCheckbox(checked: $checked, label: "Tout sélectionner", indeterminate: somePartial) { _ in }
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `checked` | État coché (liaison bidirectionnelle contrôlée) | `Bool` | — |
| `indeterminate` | État indéterminé ou non (affiche une barre ; un appui passe à l'état coché) | `Bool` | `false` |
| `disabled` | Désactivé ou non (ne déclenche pas onChange) | `Bool` | `false` |
| `lhSize` | Dimension de la case à cocher, mappée aux jetons de dimension | `LhCheckboxSize` | `.medium` |
| `label` | Étiquette textuelle | `String` | `""` |
| `onChange` | Rappel de changement d'état, le payload est la nouvelle valeur | `((Bool) -> Void)?` | `nil` |

### LhCheckboxSize

| Valeur | Dimension |
| --- | --- |
| `.small` | `checkbox.size.small` (16pt) |
| `.medium` | `checkbox.size.medium` (20pt) |
| `.large` | `checkbox.size.large` (24pt) |

### Couleurs

| État | Fond du carré | Couleur du marqueur |
| --- | --- | --- |
| Décoché | Transparent + bordure `color.border.base` (`checkbox.borderWidth`) | — |
| Coché / indéterminé | `color.primary.default` | `color.onPrimary` |
| Désactivé | `color.disabled.bg` + bordure `color.disabled.border` | `color.disabled.text` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `checkbox.size.{small,medium,large}` | Trois dimensions |
| `checkbox.borderRadius` / `checkbox.borderWidth` | Arrondi (suit `radius.small`) et largeur de bordure |
| `checkbox.checkWidth` | Largeur du trait de la coche |
| `checkbox.dashScale` | Proportion de la barre de l'état indéterminé par rapport au carré (50%) |
| `checkbox.gap` | Espacement entre le carré et le texte (suit `spacing.sm`) |
| `color.primary.default` / `color.onPrimary` | Couleurs fond / marqueur de l'état coché |
| `color.border.base` | Couleur de bordure à l'état décoché |
| `color.disabled.{bg,border,text}` | Les trois couleurs de l'état désactivé |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `tap-toggles-and-emits-onchange` | Un appui bascule l'état et rappelle `onChange(true)` | `testTapTogglesAndEmitsOnChange` |
| `tap-checked-unchecks` | Un appui sur une case cochée la décoche | `testTapCheckedUnchecks` |
| `disabled-blocks-change` | L'état désactivé ne déclenche pas onChange | `testDisabledBlocksChange` |
| `checked-uses-primary-tokens` | L'état coché consomme la couleur principale et onPrimary | `testCheckedUsesPrimaryTokens` |
| `unchecked-uses-border-token` | L'état décoché consomme le jeton de bordure | `testUncheckedUsesBorderToken` |
| `indeterminate-becomes-checked` | Après un appui en état indéterminé, l'état devient toujours coché | `testIndeterminateBecomesChecked` |

Tests supplémentaires : `testSizeUsesSizeTokens` / `testStrokeUsesCheckboxTokens` /
`testDarkColorsComeFromDarkTokens` / `testDisabledInDarkUsesDarkDisabledTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testCheckboxViewInitAcceptsConstant`.

```bash
swift test --filter LhCheckboxTests    # exécutable sur l'hôte macOS, sans simulateur
```
