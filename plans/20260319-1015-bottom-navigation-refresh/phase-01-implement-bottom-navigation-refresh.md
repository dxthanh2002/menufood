## Context Links
- `mobile_bottom_navigation.md`
- `lib/features/bottom_navigation/main_screen.dart`
- `lib/theme/theme_data.dart`
- `lib/theme/colors.dart`

## Overview
- Priority: P2
- Current status: completed
- Brief description: Refresh the shared bottom navigation visuals without changing app structure.

## Key Insights
- Existing tab count and persistence are already correct.
- The highest-value change is stronger active-state clarity with lighter, cleaner chrome.
- Shared config should live in one place so detail flows and main shell stay aligned.

## Requirements
- Keep 4 destinations.
- Keep labels short and single-line.
- Improve active vs inactive distinction with at least 2 visual cues.
- Keep hit targets and safe area behavior intact.

## Architecture
- `MainScreen` continues owning the persistent `IndexedStack`.
- `AppBottomNavigationBar` continues acting as the shared bottom bar.
- Theme-level nav tokens stay centralized in `AppTheme`.

## Related Code Files
- Modify: `lib/features/bottom_navigation/main_screen.dart`
- Modify: `lib/theme/theme_data.dart`
- Optional modify: `docs/design-guidelines.md`
- Optional modify: `docs/code-standards.md`

## Implementation Steps
1. Extract destination metadata into a shared constant list in `main_screen.dart`.
2. Provide paired selected/unselected icons for clearer state changes.
3. Tune `NavigationBarThemeData` icon and label styling to better match the checklist.
4. Replace heavy visual treatment with a clean top divider plus subtle elevation/shadow.
5. Ensure container height and padding still respect mobile tap comfort.
6. Run analyzer and tests.

## Todo List
- [x] Refactor shared destination config
- [x] Improve selected/unselected icon states
- [x] Tune nav sizing and typography
- [x] Refine nav surface separation
- [x] Run verification

## Success Criteria
- Bar remains reusable across shell and detail flows.
- Selected tab is obvious at a glance.
- Bottom bar feels lighter and more intentional.

## Risk Assessment
- Theme changes can affect all nav usages.
- Destination refactor must not break existing index mapping.

## Security Considerations
- No auth, storage, or network impact.

## Next Steps
- `flutter analyze` completed with existing non-blocking warnings outside the modified scope
- `flutter test` passed
- Docs impact assessed as none

## Unresolved Questions
- None.
