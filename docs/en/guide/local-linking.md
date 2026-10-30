# Local Linking

## Family layout convention

```
lh-ui/                        # Family parent directory (not a repo)
├── lh-ui-core/               # Token source of truth + codegen
├── lh-ui-android/            # Sibling repo
├── lh-ui-ios/                # This repo
├── lh-ui-harmony/
└── lh-ui-windows/
```

When every repo shares the same parent directory, tokens are **linked locally**; when a sibling repo is absent (a single-repo CI clone), it **falls back to the npm package automatically**.
This is structurally the same as the web bloodline's vite alias guard mechanism (master plan D18).

## Three-level guard

`scripts/link-tokens.mjs` looks for the token artifacts in priority order:

| Priority | Source | Notes |
| --- | --- | --- |
| 1 | `../lh-ui-core/dist/ios` | Local linking: token changes take effect immediately |
| 2 | `node_modules/@lh-ui/core/dist/ios` | npm fallback: `@lh-ui/core`'s `files:["dist"]` ships all four platform artifacts |
| 3 | — | Errors out — without tokens there is nothing to build |

## Daily workflow

```bash
# 1. Change tokens (in the core repo)
cd ../lh-ui-core
vim tokens/color.json           # or spacing / typography / ...

# 2. Regenerate + verify
pnpm codegen                    # Generates the dist/ artifacts for all four platforms
pnpm verify                     # schema + references + WCAG contrast + spec consistency

# 3. Sync back to this repo
cd ../lh-ui-ios
pnpm link:tokens                # Overwrites Sources/LhUITokens/

# 4. Regression
swift test
```

## CI gate

```bash
pnpm link:tokens:check          # Checks whether tokens are in sync (file-count comparison; exit code 1 if not)
```

## Forbidden

- ❌ Hand-editing `Sources/LhUITokens/` (generated output, gitignored)
- ❌ Committing generated token files to the repo
- ❌ Writing color or spacing literals inside components (e.g. `Color(red: 0.169, ...)`, `CGFloat(40)`, a font size of `14`)
- ❌ Copying artifacts over manually instead of running `link:tokens`

## Troubleshooting

| Symptom | Cause | Fix |
| --- | --- | --- |
| Compile error `cannot find 'LhTokens' in scope` | Tokens not synced | `pnpm link:tokens` |
| Token values do not match expectations | The core repo was not re-run through codegen | Run `pnpm codegen` in the core repo, then link again |
| `link:tokens` reports "token artifacts not found" | Sibling repo absent and the npm package not installed | Check the family layout or run `pnpm i -D @lh-ui/core` |
| Dark colors look wrong | The light primary was changed but the dark pre-computation was not updated | Update `color-dark.json` and re-run (R-n6) |
| `default`-related compile errors | A generated member name colliding with a keyword was not escaped | Upgrade core (fixed: member names are wrapped in backticks, `` `default` ``) |
