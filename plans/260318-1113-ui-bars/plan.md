---
title: "Light Theme Status Bar And Main Tab Top Bar Standardization"
description: "Fix unreadable status bar content in light theme and normalize top bar layout across the main tabs."
status: in-progress
priority: P2
effort: 3h
tags: [flutter, ui, theme, app-bar]
created: 2026-03-18
---

# Light Theme Status Bar And Main Tab Top Bar Standardization

## Overview

Resolve 2 UI issues in the main shell: status bar content disappears on light surfaces, and top bars across root tabs use inconsistent layouts.

## Phases

| # | Phase | Status | Effort | Link |
|---|---|---|---|---|
| 1 | Audit and define shared top-bar spec | Completed | 30m | [phase-01](./phase-01-audit-and-define-shared-top-bar-spec.md) |
| 2 | Fix light-theme status bar styling | Completed | 30m | [phase-02](./phase-02-fix-system-status-bar-styling-for-light-theme.md) |
| 3 | Refactor main-tab headers to one contract | Completed | 90m | [phase-03](./phase-03-refactor-main-tab-headers-to-match-one-spec.md) |
| 4 | Validate layouts and analyze | Pending | 30m | [phase-04](./phase-04-validate-on-device-sizes.md) |

## Dependencies

- Phase 2 depends on the current theme/app-shell behavior in `lib/theme/theme_data.dart` and `lib/main.dart`.
- Phase 3 depends on Phase 1 locking one header contract before refactoring tab screens.
- Phase 4 depends on Phases 2 and 3 finishing.

## Affected Files

- `lib/theme/theme_data.dart`
- `lib/main.dart`
- `lib/features/bottom_navigation/main_screen.dart`
- `lib/features/home/home_screen.dart`
- `lib/features/recipes/recipes_screen.dart`
- `lib/features/saved/saved_screen.dart`
- `lib/features/history/history_screen.dart`
- `lib/features/user_setting/user_setting_screen.dart`
- Optional shared header/tokens file if refactor needs extraction

## Notes

- Favor one shared header contract over 5 isolated fixes.
- Keep the solution minimal: centralize overlay style first, add per-screen overrides only if required.
- Keep `back button` on `saved` and `settings`.
- Standardize root-tab title alignment to `centered`.
- Current progress: 3 of 4 phases completed. Runtime validation remains open because `flutter analyze` could not be completed in this environment.

## Unresolved Questions

- None
