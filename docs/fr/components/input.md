# Champ de saisie

Champ de saisie sur une ligne, contrôlé. `@Binding var value` est une liaison bidirectionnelle ; prend en charge le texte clair / chiffré, le bouton d'effacement, le nombre maximal de caractères et l'anneau de focus.

> Source du contrat : `lh-ui-core/specs/input.json` ·
> Cas dorés : `lh-ui-core/cases/input.json` (8 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Forme de base

La hauteur est alignée avec Button (trois niveaux de jetons `input.height`) ; lors du focus, la bordure passe à `color.focus` et s'élargit pour former l'anneau de focus.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input de base</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" placeholder="Veuillez saisir le contenu" /></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--focus"><input class="sim-input__field" value="青花瓷" /></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var text = ""

LhInput(value: $text, placeholder: "Veuillez saisir le contenu") { newValue in
  // onValueChange
}
```

## Dimensions

Trois dimensions mappées sur les jetons `input.height` / `paddingHorizontal` / `fontSize`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Dimensions de Input</span></div>
  <div class="sim-screen">
    <div class="sim-row"><span class="sim-input sim-input--small"><input class="sim-input__field" placeholder="Petit" /></span></div>
    <div class="sim-row"><span class="sim-input"><input class="sim-input__field" placeholder="Moyen" /></span></div>
    <div class="sim-row"><span class="sim-input sim-input--large"><input class="sim-input__field" placeholder="Grand" /></span></div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Mot de passe et effacement

`type: .password` est implémenté via `SecureField` (test `testPasswordTypeIsSecure`) ;
`clearable` affiche un bouton d'effacement lorsqu'il y a une valeur ; un appui déclenche `onValueChange("")`
(cas doré `clearable-emits-empty-value`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Input étendu</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-input"><input class="sim-input__field" type="password" value="secret" /><svg class="sim-input__clear" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 100 20 10 10 0 000-20zm1 15h-2v-2h2zm0-4h-2V7h2z"/></svg></span>
    </div>
    <div class="sim-row">
      <span class="sim-input sim-input--disabled"><input class="sim-input__field" value="Désactivé" disabled /></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhInput(value: $pwd, type: .password, clearable: true)
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `value` | Contenu saisi (liaison bidirectionnelle contrôlée) | `String` | — |
| `placeholder` | Texte de l'espace réservé | `String` | `""` |
| `type` | Type de saisie (texte clair / mot de passe) | `LhInputType` | `.text` |
| `lhSize` | Dimension du champ de saisie, mappée aux jetons de dimension | `LhInputSize` | `.medium` |
| `disabled` | Désactivé ou non (ne déclenche aucun rappel) | `Bool` | `false` |
| `readonly` | En lecture seule ou non (ne déclenche pas onValueChange, conserve le style de focus) | `Bool` | `false` |
| `clearable` | Affiche le bouton d'effacement ou non | `Bool` | `false` |
| `maxlength` | Nombre maximal de caractères (tronqué au-delà, cas doré `maxlength-truncates-input`) | `Int?` | `nil` |
| `onValueChange` | Rappel de changement de contenu, le payload est la nouvelle valeur | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Rappel de focus | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Rappel de perte de focus | `(() -> Void)?` | `nil` |

### LhInputSize

| Valeur | height | paddingHorizontal | fontSize |
| --- | --- | --- | --- |
| `.small` | `input.height.small` (32pt) | `input.paddingHorizontal.small` (12pt) | `input.fontSize.small` (13pt) |
| `.medium` | `input.height.medium` (40pt) | `input.paddingHorizontal.medium` (16pt) | `input.fontSize.medium` (14pt) |
| `.large` | `input.height.large` (48pt) | `input.paddingHorizontal.large` (20pt) | `input.fontSize.large` (16pt) |

### LhInputType

| Valeur | Implémentation |
| --- | --- |
| `.text` | `TextField` |
| `.password` | `SecureField` |

### Couleurs

| État | Bordure | Texte / espace réservé |
| --- | --- | --- |
| Par défaut | `color.border.base` (`input.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Focus | `color.focus` (`input.focusRingWidth`) | Identique |
| Désactivé | `color.disabled.border` | `color.disabled.text` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `input.height.{small,medium,large}` | Trois hauteurs |
| `input.paddingHorizontal.{small,medium,large}` | Trois marges internes horizontales |
| `input.fontSize.{small,medium,large}` | Trois tailles de police |
| `input.borderRadius` / `input.borderWidth` | Arrondi (suit `radius.small`) et largeur de bordure |
| `input.focusRingWidth` | Largeur de l'anneau de focus |
| `input.clearIconSize` | Taille de l'icône du bouton d'effacement |
| `color.focus` | Couleur de bordure au focus |
| `color.text.{primary,placeholder,disabled}` | Couleurs du texte et de l'espace réservé |
| `color.border.base` / `color.disabled.border` | Couleurs de bordure |
| `color.background.default` / `color.disabled.bg` | Couleurs de fond |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `input-emits-onvaluechange` | La saisie déclenche `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `clearable-emits-empty-value` | L'effacement déclenche `onValueChange("")` | `testClearableShowsClearButtonWhenHasValue` |
| `disabled-blocks-input` | L'état désactivé ne déclenche pas onValueChange | `testDisabledBlocksInput` |
| `readonly-blocks-input` | L'état en lecture seule ne déclenche pas onValueChange | `testReadonlyBlocksInput` |
| `placeholder-uses-placeholder-token` | Le texte de l'espace réservé prend le jeton de couleur d'espace réservé | `testPlaceholderUsesPlaceholderToken` |
| `focus-uses-focus-token` | Le focus consomme le jeton focus et déclenche lhOnFocus | `testFocusUsesFocusToken` |
| `small-size-uses-small-tokens` | La petite taille consomme les jetons de dimension small | `testSmallSizeUsesSmallTokens` |
| `maxlength-truncates-input` | Troncature au-delà du nombre maximal de caractères | `testMaxlengthTruncatesInput` |

Tests supplémentaires : `testPasswordTypeIsSecure` / `testDarkColorsComeFromDarkTokens` /
`testDimensionsAreIdenticalInDarkMode` / `testInputViewInitAcceptsConstant`.

```bash
swift test --filter LhInputTests    # exécutable sur l'hôte macOS, sans simulateur
```
