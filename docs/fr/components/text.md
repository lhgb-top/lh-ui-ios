# Texte (Text)

Primitive d'affichage de texte : consomme les tokens typographiques globaux, avec niveaux de taille, graisse, ton et alignement.

> Contrat : `lh-ui-core/specs/text.json` · Cas dorés : `lh-ui-core/cases/text.json` (5, traduits en XCTest, exécutables sur hôte macOS)

## Niveaux de taille

`level` est mappé au token `typography.fontSize.<level>` ; par défaut `base`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--extraLarge">extraLarge</p>
    <p class="sim-text sim-text--large">large</p>
    <p class="sim-text sim-text--medium">medium</p>
    <p class="sim-text">base</p>
    <p class="sim-text sim-text--small">small</p>
    <p class="sim-text sim-text--extraSmall">extraSmall</p>
  </div>
</div>
<p class="sim-note">Aperçu du simulateur HTML (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhText("Title text", level: .large)
```

## Graisse

`weight` est mappé au token `typography.fontWeight.<weight>` (primary 400 / bold 600).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--bold">bold</p>
  </div>
</div>
<p class="sim-note">Aperçu du simulateur HTML (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Ton

`tone` est mappé au token `color.text.<tone>` ; `selected` prend `color.selected`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text">primary</p>
    <p class="sim-text sim-text--regular">regular</p>
    <p class="sim-text sim-text--secondary">secondary</p>
    <p class="sim-text sim-text--placeholder">placeholder</p>
    <p class="sim-text sim-text--disabled">disabled</p>
    <p class="sim-text sim-text--selected">selected</p>
  </div>
</div>
<p class="sim-note">Aperçu du simulateur HTML (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

## Alignement et hauteur de ligne

`lhAlign` aligne dans la boîte de ligne ; la hauteur de ligne prend toujours `typography.lineHeight.primary` (taille × 1,8).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Text</span></div>
  <div class="sim-screen">
    <p class="sim-text sim-text--align-center">center</p>
    <p class="sim-text sim-text--align-end">end</p>
  </div>
</div>
<p class="sim-note">Aperçu du simulateur HTML (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhText("Centered", lhAlign: .center)
```

## API

| Propriété | Description | Type | Par défaut |
| --- | --- | --- | --- |
| `content` | contenu du texte (premier argument de l'initialiseur ; le slot par défaut du spec) | `String` | `""` |
| `level` | Niveaux de taille | `LhTextLevel` | `.base` |
| `weight` | Graisse | `LhTextWeight` | `.primary` |
| `tone` | Ton | `LhTextTone` | `.primary` |
| `lhAlign` | Alignement et hauteur de ligne | `LhTextAlign` | `.start` |

### LhTextLevel

| Propriété | fontSize token |
| --- | --- |
| `.extraLarge` | `typography.fontSize.extraLarge` (20pt) |
| `.large` | `typography.fontSize.large` (18pt) |
| `.medium` | `typography.fontSize.medium` (16pt) |
| `.base` | `typography.fontSize.base` (14pt, default) |
| `.small` | `typography.fontSize.small` (13pt) |
| `.extraSmall` | `typography.fontSize.extraSmall` (12pt) |

### LhTextTone

| Propriété | text color token |
| --- | --- |
| `.primary` | `color.text.primary` |
| `.regular` | `color.text.regular` |
| `.secondary` | `color.text.secondary` |
| `.placeholder` | `color.text.placeholder` |
| `.disabled` | `color.text.disabled` |
| `.selected` | `color.selected` |

## Référence des tokens

| Token | Usage |
| --- | --- |
| `typography.fontSize.<level>` | six size levels |
| `typography.fontWeight.{primary,bold}` | two weights |
| `typography.lineHeight.primary` | line height (font size × 1.8) |
| `color.text.<tone>` / `color.selected` | text tones |

## Référence des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `default-level-uses-base-tokens` | default level consumes the base typography tokens | `LhTextTests.testDefaultLevelUsesBaseTokens` |
| `large-level-uses-large-token` | large level consumes the large size token | `LhTextTests.testLargeLevelUsesLargeToken` |
| `bold-weight-uses-bold-token` | bold consumes the bold weight token | `LhTextTests.testBoldWeightUsesBoldToken` |
| `secondary-tone-uses-text-secondary` | secondary tone takes the secondary text color token | `LhTextTests.testSecondaryToneUsesTextSecondary` |
| `render-emits-single-text-command` | render emits a single TEXT command | `LhTextTests.testAllLevelsUseTheirTokens` |

```bash
swift test --filter LhTextTests
```
