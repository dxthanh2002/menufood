# Phase 04: Validate On Device Sizes

## Context Links

- [plan.md](D:\Flutter\ai_menu_flutter\plans\260318-1113-ui-bars\plan.md)
- [theme_data.dart](D:\Flutter\ai_menu_flutter\lib\theme\theme_data.dart)
- [home_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\home\home_screen.dart)
- [recipes_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\recipes\recipes_screen.dart)
- [saved_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\saved\saved_screen.dart)
- [history_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\history\history_screen.dart)
- [user_setting_screen.dart](D:\Flutter\ai_menu_flutter\lib\features\user_setting\user_setting_screen.dart)

## Overview

- Priority: P2
- Current status: Pending
- Brief description: Validate that the status bar fix and shared top-bar contract hold across relevant mobile layouts.

## Key Insights

- The current app already uses responsive helpers, but top-bar consistency is still uneven.
- `saved` and `settings` have tablet-aware layout behavior, so header validation must include those states.

## Requirements

- No compile or analyze errors after changes.
- No clipped icons or truncated titles on narrow mobile widths.
- Status bar readability must persist when switching tabs.
- Tablet behavior for `saved` and `settings` must remain visually stable.

## Architecture

- Use lightweight verification: `flutter analyze` plus manual QA on representative widths.
- Focus on root-tab transitions and top safe-area rendering instead of deep feature flows.

## Related Code Files

- Modify only if validation exposes regressions in target files
- Delete: none expected

## Implementation Steps

1. Run `flutter analyze`.
2. Check a small-phone portrait width.
3. Check a typical modern Android width.
4. Check tablet rendering for `saved` and `settings`.
5. Verify status bar readability after switching between all root tabs.

## Todo List

- [ ] Run `flutter analyze`
- [ ] Validate small-phone portrait layout
- [ ] Validate standard Android width
- [ ] Validate tablet behavior for `saved` and `settings`
- [ ] Validate status bar after tab switching

## Success Criteria

- Analyze passes.
- No visible top-bar alignment regressions remain.
- Status bar content remains readable throughout the main tab flow.

## Risk Assessment

- Manual visual QA may miss edge cases without widget/screenshot coverage.
- Transparent headers can still hide platform-specific status bar differences.

## Security Considerations

- No auth or data-security changes.
- Keep verification focused and reproducible.

## Next Steps

- Runtime validation still required before plan completion. Implementation landed, but validation is blocked in the current environment.

## Unresolved Questions

- Should widget-level tests be added later for header layout consistency, or is manual QA enough for this scope?
