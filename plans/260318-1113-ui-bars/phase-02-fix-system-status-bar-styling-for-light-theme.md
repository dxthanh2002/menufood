# Phase 02: Fix System Status Bar Styling For Light Theme

## Context Links

- [theme_data.dart](D:\Flutter\ai_menu_flutter\lib\theme\theme_data.dart)
- [main.dart](D:\Flutter\ai_menu_flutter\lib\main.dart)
- [main_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\bottom_navigation\main_screen.dart)

## Overview

- Priority: P1
- Current status: Completed
- Brief description: Make system status bar content readable on light backgrounds in the main app flow.

## Key Insights

- `AppBarTheme` exists but does not set `systemOverlayStyle`.
- `main.dart` does not configure any system UI overlay behavior.
- Several screens use transparent app bars over light backgrounds, which leaves status bar styling inconsistent.

## Requirements

- Light theme must render dark status bar content on Android.
- The chosen fix must work across the main tabs, not only on one screen.
- Status bar background and content must remain visually compatible with current light surfaces.

## Architecture

- Try central control first through `AppBarTheme.systemOverlayStyle`.
- If that is not sufficient, apply one shell-level `AnnotatedRegion<SystemUiOverlayStyle>` or app-level system UI configuration.
- Avoid duplicating overlay configuration in every tab unless one screen truly needs a different style.

## Related Code Files

- Modify: `lib/theme/theme_data.dart`
- Modify if needed: `lib/main.dart`
- Modify if needed: `lib/features/bottom_navigation/main_screen.dart`
- Delete: none expected

## Implementation Steps

1. Add a light-theme status bar style at the most central layer.
2. Verify that transparent app bars inherit the expected icon brightness.
3. Add a shell-level override only if theme-level control does not hold during tab switching.

## Todo List

- [x] Set central status bar overlay style for light theme
- [x] Verify behavior on main tabs with transparent/light headers
- [x] Add fallback shell-level override only if needed

## Success Criteria

- Status bar time, battery, Wi-Fi, and network icons are readable on light theme.
- No root tab regresses to white-on-light after navigation or tab switching.

## Risk Assessment

- Android and iOS brightness mapping may differ.
- Transparent app bars can still look wrong if overlay style and background are out of sync.

## Security Considerations

- No auth or data-security changes.
- Keep platform configuration minimal to avoid accidental visual regressions outside the target flow.

## Next Steps

- Hand the final overlay approach into Phase 03 so shared headers adopt the same behavior.

## Unresolved Questions

- None
