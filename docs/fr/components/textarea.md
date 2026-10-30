# Zone de texte

Zone de texte multiligne contrôlée. `@Binding var value` est une liaison bidirectionnelle, associée à un texte d'espace réservé et à un comptage de caractères.

> Source du contrat : `lh-ui-core/specs/textarea.json` ·
> Cas dorés : `lh-ui-core/cases/textarea.json` (6 cas, traduits en XCTest, exécutables sur l'hôte macOS)

## Forme de base

La hauteur minimale est `textarea.minHeight`, les marges internes sont `textarea.paddingHorizontal` / `paddingVertical` ;
lors du focus, la bordure passe à `color.focus`.

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Textarea de base</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea"><textarea class="sim-textarea__field" placeholder="Veuillez saisir le contenu"></textarea></span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--focus"><textarea class="sim-textarea__field">青花瓷</textarea></span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
@State private var text = ""

LhTextarea(value: $text, placeholder: "Veuillez saisir le contenu") { newValue in
  // onValueChange
}
```

## Comptage de caractères

Lorsque `showCount = true`, un compteur s'affiche en bas à droite : si `maxlength` est défini, il affiche `actuel/plafond`
(cas doré `showcount-renders-count`) ; sinon, seule la longueur actuelle est affichée
(`showcount-without-maxlength-renders-length-only`).

<div class="sim-phone">
  <div class="sim-statusbar"><span>9:41</span><span>Comptage de Textarea</span></div>
  <div class="sim-screen">
    <div class="sim-row">
      <span class="sim-textarea">
        <textarea class="sim-textarea__field">青花瓷</textarea>
        <span class="sim-textarea__count">3/10</span>
      </span>
    </div>
    <div class="sim-row">
      <span class="sim-textarea sim-textarea--disabled">
        <textarea class="sim-textarea__field" disabled>Désactivé</textarea>
      </span>
    </div>
  </div>
</div>
<p class="sim-note">Aperçu HTML simulé (apparence iOS / SwiftUI), pas un rendu sur appareil réel</p>

```swift
LhTextarea(value: $text, showCount: true, maxlength: 10)
```

## API

### Props

| Prop | Description | Type | Valeur par défaut |
| --- | --- | --- | --- |
| `value` | Contenu saisi (liaison bidirectionnelle contrôlée) | `String` | — |
| `placeholder` | Texte de l'espace réservé | `String` | `""` |
| `rows` | Nombre de lignes souhaité (influe sur la hauteur minimale) | `Int` | `3` |
| `disabled` | Désactivé ou non (ne déclenche aucun rappel) | `Bool` | `false` |
| `readonly` | En lecture seule ou non (ne déclenche pas onValueChange, conserve le style de focus) | `Bool` | `false` |
| `showCount` | Affiche le comptage de caractères ou non | `Bool` | `false` |
| `maxlength` | Nombre maximal de caractères (tronqué au-delà) | `Int?` | `nil` |
| `onValueChange` | Rappel de changement de contenu, le payload est la nouvelle valeur | `((String) -> Void)?` | `nil` |
| `lhOnFocus` | Rappel de focus | `(() -> Void)?` | `nil` |
| `lhOnBlur` | Rappel de perte de focus | `(() -> Void)?` | `nil` |

### Couleurs

| État | Bordure | Texte / espace réservé |
| --- | --- | --- |
| Par défaut | `color.border.base` (`textarea.borderWidth`) | `color.text.primary` / `color.text.placeholder` |
| Focus | `color.focus` (`textarea.focusRingWidth`) | Identique |
| Désactivé | `color.disabled.border` | `color.disabled.text` |

## Référence des jetons

| Jeton | Utilisation |
| --- | --- |
| `textarea.minHeight` | Hauteur minimale |
| `textarea.paddingHorizontal` / `textarea.paddingVertical` | Marges internes |
| `textarea.fontSize` | Taille de police |
| `textarea.countFontSize` | Taille de police du compteur |
| `textarea.borderRadius` / `textarea.borderWidth` | Arrondi et largeur de bordure |
| `textarea.focusRingWidth` | Largeur de l'anneau de focus |
| `color.focus` | Couleur de bordure au focus |
| `color.text.{primary,placeholder,disabled}` | Couleurs du texte et de l'espace réservé |
| `color.border.base` / `color.disabled.border` | Couleurs de bordure |
| `color.background.default` / `color.disabled.bg` | Couleurs de fond |

## Correspondance des cas dorés

| case id | Assertion | Test local |
| --- | --- | --- |
| `input-emits-onvaluechange` | La saisie déclenche `onValueChange("青花瓷")` | `testDefaultIsEditable` |
| `disabled-blocks-input` | L'état désactivé ne déclenche pas onValueChange | `testDisabledBlocksInput` |
| `showcount-renders-count` | Le compteur affiche `3/10` et consomme le jeton de taille de police du compteur | `testShowCountRendersCount` |
| `showcount-without-maxlength-renders-length-only` | Sans plafond défini, seul `3` est affiché | `testShowCountWithoutMaxlengthRendersLengthOnly` |
| `focus-uses-focus-token` | Le focus consomme le jeton focus et déclenche lhOnFocus | `testFocusUsesFocusToken` |
| `maxlength-truncates-input` | Troncature au-delà du nombre maximal de caractères | `testMaxlengthTruncatesInput` |

Tests supplémentaires : `testLayoutUsesTextareaTokens` / `testReadonlyBlocksInputButKeepsFocusStyle` /
`testDarkColorsComeFromDarkTokens` / `testDimensionsAreIdenticalInDarkMode` /
`testTextareaViewInitAcceptsConstant`.

```bash
swift test --filter LhTextareaTests    # exécutable sur l'hôte macOS, sans simulateur
```
