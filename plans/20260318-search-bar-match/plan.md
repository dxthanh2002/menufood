---
title: "Match Saved Search Styling"
description: "Document steps to make the Saved tab search bar use the same rounded, elevated look as Recipes."
status: pending
priority: P2
effort: 1h
branch: main
tags: [ui, saved, search]
created: 2026-03-18
---

## Context
- `RecipesScreen` already renders the desired search input: `TextField` inside a surface-colored `Container` with rounded corners, soft shadow, slate hint text, and inline search icon.
- `SavedScreen` currently uses a translucent cream container with no shadow, a single colorized icon, and a different hint style; the rest of the saved screen structure already matches the overall tab.
- Minimal impact scope: only `_buildSearchBar()` needs updates to reuse the same decoration tokens and padding so the user experience matches across tabs.

## Requirements
- Mirror the Recipes search bar decoration (background color, corner radius, shadow, padding, hint style, prefix icon) while keeping hint text focused on saved content.
- Keep the `TextField` behavior identical (no functional changes, still a static widget).
- Avoid touching other sections of `SavedScreen` or creating new widgets unless it simplifies reuse without adding scope.

## Phases
1. **Inspect reference search bar**
   - Confirm exact decoration and padding used in `lib/features/recipes/recipes_screen.dart` (color, border radius, shadow, content padding, hint text).
   - Note any shared tokens (`AppColors.surface`, accent colors) that should be reused.

2. **Update Saved search UI**
   - Replace `_buildSearchBar()` wrapper with the same `Container` decoration used in `RecipesContent` (surface background, rounded 16 corners, box shadow).
   - Align `TextField` `InputDecoration` with `RecipesScreen`: hint text "Search saved recipes" but same `hintStyle`, prefix icon color, zero border, and identical content padding.
   - Keep existing padding/margins to preserve spacing unless the reference layout dictates slight adjustments.

3. **Verify locally**
   - Run `flutter analyze` to confirm no formatting or styling regressions.
   - Hot restart or `flutter run` on a local device/emulator (or view existing screenshot) to confirm the Saved tab search visually matches the Recipes tab.

## Verification
- `flutter analyze`
- Manual inspection of the Saved tab in a hot-reloaded run, checking both mobile and tablet breakpoints to confirm search bar appearance.

## Risks & Mitigations
- Risk: Unexpected color/opacity combination due to `AppColors.softCream.withOpacity(0.5)` vs `AppColors.surface`. Mitigate by explicitly using tokens from `RecipesScreen`.
- Risk: Additional layout shift if padding changes; keep padding values identical and test quickly by running the UI to confirm.

## Dependencies
- None beyond `lib/features/saved/saved_screen.dart`.

## Open Questions
- None.
