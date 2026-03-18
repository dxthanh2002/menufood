# Phase 01: Audit And Define Shared Top-Bar Spec

## Context Links

- [README.md](D:\Flutter\ai_menu_flutter\README.md)
- [docs/code-standards.md](D:\Flutter\ai_menu_flutter\docs\code-standards.md)
- [docs/design-guidelines.md](D:\Flutter\ai_menu_flutter\docs\design-guidelines.md)
- [home_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\home\home_screen.dart)
- [recipes_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\recipes\recipes_screen.dart)
- [saved_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\saved\saved_screen.dart)
- [history_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\history\history_screen.dart)
- [user_setting_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\user_setting\user_setting_screen.dart)

## Overview

- Priority: P2
- Current status: Completed
- Brief description: Lock one top-bar contract for all main tabs before refactoring layouts.

## Key Insights

- `home`, `recipes`, `saved`, `history`, and `settings` use different header structures.
- `saved` bypasses `AppBar` and renders a custom `SafeArea` header.
- `history` has no top bar, so consistency is impossible until a header is added.
- `settings` and `saved` still expose back-button semantics although they are root tabs in `MainScreen`, and this behavior must be preserved.

## Requirements

- Same visual height across root-tab headers.
- Same horizontal padding and safe-area handling.
- Same icon button frame, tap target, and action alignment.
- Same title font scale, weight, and baseline behavior.
- Same rule for leading, title, and trailing zones.

## Architecture

- Prefer one reusable header contract, either as a small shared widget or a strict helper with shared constants.
- Keep variants minimal: title alignment, optional leading, optional trailing action.
- Reuse `AppColors` and existing responsive utilities instead of reintroducing ad hoc sizing.

## Related Code Files

- Modify: `lib/features/home/home_screen.dart`
- Modify: `lib/features/recipes/recipes_screen.dart`
- Modify: `lib/features/saved/saved_screen.dart`
- Modify: `lib/features/history/history_screen.dart`
- Modify: `lib/features/user_setting/user_setting_screen.dart`
- Create if needed: shared header/tokens file under `lib/features/bottom_navigation/` or `lib/theme/`
- Delete: none expected

## Implementation Steps

1. Audit current root-tab headers and list differences in height, padding, title alignment, and actions.
2. Choose one header structure that fits the warm light-theme design system.
3. Define header constants and action-button rules.
4. Preserve `back button` on `saved` and `settings` while aligning sizing and spacing with the shared header contract.

## Todo List

- [x] Record header differences from each root tab
- [x] Select one shared visual/header contract
- [x] Define leading/title/action rules
- [x] Preserve `back button` behavior on `saved` and `settings`

## Success Criteria

- One clear top-bar spec exists before UI edits start.
- No root tab keeps a one-off header without a justified exception.

## Risk Assessment

- Over-abstracting a simple 5-screen problem.
- Carrying forward back-button behavior that conflicts with root-tab navigation.

## Security Considerations

- No auth or data-security changes.
- Ensure refactor does not accidentally expose blocked back navigation paths.

## Next Steps

- Feed the shared contract into the status bar fix and tab-header refactor.
- Use centered titles as the standard in Phase 03.

## Unresolved Questions

- None
