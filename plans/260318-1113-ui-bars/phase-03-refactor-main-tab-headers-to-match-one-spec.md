# Phase 03: Refactor Main-Tab Headers To Match One Spec

## Context Links

- [main_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\bottom_navigation\main_screen.dart)
- [home_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\home\home_screen.dart)
- [recipes_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\recipes\recipes_screen.dart)
- [saved_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\saved\saved_screen.dart)
- [history_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\history\history_screen.dart)
- [user_setting_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\user_setting\user_setting_screen.dart)

## Overview

- Priority: P1
- Current status: Completed
- Brief description: Rebuild the root-tab top bars against one visual contract so height, padding, icon treatment, and title layout are consistent.

## Key Insights

- `home` uses a centered title with a left menu icon and right avatar action.
- `recipes` fakes a title block inside `leading` and uses a custom `leadingWidth`.
- `saved` renders a custom stack-based header with a back button that must remain.
- `history` currently exposes no header.
- `settings` looks like a detail screen rather than a root tab, but its back button must remain.

## Requirements

- Same toolbar height across all main tabs.
- Same leading and trailing action frame sizes.
- Same title sizing, hierarchy rules, and centered alignment.
- Same horizontal paddings and top safe-area behavior.
- Navigation behavior must remain coherent with `MainScreen` bottom-navigation usage while preserving `back button` on `saved` and `settings`.

## Architecture

- Extract shared header sizing and spacing tokens first.
- If repeated layout code remains high, extract a focused root-tab header widget.
- Keep the API narrow; this is not a generic design-system project.

## Related Code Files

- Modify: `lib/features/home/home_screen.dart`
- Modify: `lib/features/recipes/recipes_screen.dart`
- Modify: `lib/features/saved/saved_screen.dart`
- Modify: `lib/features/history/history_screen.dart`
- Modify: `lib/features/user_setting/user_setting_screen.dart`
- Create if needed: shared header/tokens file
- Delete: none expected

## Implementation Steps

1. Extract shared header sizing and spacing tokens.
2. Convert `saved` from custom header layout to the shared contract.
3. Add a proper header to `history`.
4. Rebuild `home`, `recipes`, and `settings` so leading/title/actions follow the same structure with centered titles.
5. Remove ad hoc inline colors and spacing where shared theme tokens already exist.

## Todo List

- [x] Extract shared header constants
- [x] Standardize `home`
- [x] Standardize `recipes`
- [x] Standardize `saved`
- [x] Add header to `history`
- [x] Standardize `settings`

## Success Criteria

- All 5 root tabs present the same header contract.
- Icon/button/title alignment is visually consistent.
- Existing interactions still work after refactor.

## Risk Assessment

- A shared contract may require small UX changes in tabs that currently feel different.
- If the shared logic is placed poorly, file size and coupling may increase.

## Security Considerations

- No auth or data-security changes.
- Preserve navigation safety while keeping back-button patterns on `saved` and `settings`.

## Next Steps

- Hand the unified headers into validation on small phones, normal Android widths, and tablet-sized layouts.

## Unresolved Questions

- None
