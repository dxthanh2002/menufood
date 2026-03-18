# Scout Report

## Summary

Scoped the 2 requested issues to theme/bootstrap plus the 5 root-tab screens in `MainScreen`.

## Findings

- `lib/theme/theme_data.dart` defines `AppBarTheme` but does not set `systemOverlayStyle`.
- `lib/main.dart` bootstraps `MaterialApp` without explicit system UI overlay configuration.
- `lib/features/home/home_screen.dart` uses a transparent `AppBar` with centered title and custom actions.
- `lib/features/recipes/recipes_screen.dart` uses an `AppBar`, but title content is embedded in `leading` with a custom `leadingWidth`.
- `lib/features/saved/saved_screen.dart` does not use `AppBar`; it builds a custom `SafeArea` header with a back button.
- `lib/features/history/history_screen.dart` has no top bar.
- `lib/features/user_setting/user_setting_screen.dart` uses a detail-style `AppBar` with a back button.

## Implications

- Status bar readability should be fixed centrally first.
- Top-bar inconsistency is structural, not just spacing noise.
- Root-tab semantics are intentionally mixed here because `saved` and `settings` must keep their back buttons.

## Unresolved Questions

- None
