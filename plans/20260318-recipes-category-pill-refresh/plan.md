---
title: "Recipes Category Pill Refresh"
description: "Align the Recipes meal-category pills with the Saved screen pill sizing and structure."
status: completed
priority: P2
effort: 30m
branch: main
tags: [flutter, ui, recipes, saved]
created: 2026-03-18
---

## Overview
- Phase 1 `completed`: updated `lib/features/recipes/recipes_screen.dart` category pills to reuse Saved-screen sizing cues.
- Phase 2 `completed`: compile validation and automated test pass finished; manual narrow-device visual sanity check still recommended.

## Context Links
- `README.md`
- `lib/features/recipes/recipes_screen.dart`
- `lib/features/saved/saved_screen.dart`
- `docs/code-standards.md`
- `docs/design-guidelines.md`

## Key Insights
- `RecipesScreen` pills currently use `height: 44`, vertical padding `10`, radius `30`, border, and selected shadow.
- `SavedScreen` pills use list height `60`, vertical padding `5`, horizontal padding `20`, radius `20`, no border, no shadow.
- User asked specifically for Breakfast/Lunch/Dinner widget to match Saved pill size, so change should target pill dimensions/structure first, not broader Recipes redesign.

## TODO
- [x] Replace Recipes category list container sizing with Saved-style height and padding rhythm.
- [x] Update Recipes pill decoration to mirror Saved pill structure: same radius, fill treatment, and text alignment.
- [x] Keep existing Recipes selection logic and category data untouched.
- [ ] Verify long labels still render acceptably in horizontal scroll.
- [x] Run `flutter analyze` or equivalent compile check for touched file.

## Validation
- `dart analyze` for `lib/features/recipes/recipes_screen.dart`: no errors.
- `flutter test`: passed (`test/widget_test.dart`).
- `code_reviewer` agent: no findings.
- Manual visual QA on a narrow device was not run in this session.

## Implementation Notes
1. Edit only `lib/features/recipes/recipes_screen.dart` unless extraction is needed to keep file maintainable.
2. Preserve `ChangeNotifierProvider` and `RecipesViewModel` state flow.
3. Prefer `AppColors.softCream` and `AppColors.accentBrown` for unselected state to stay visually consistent with Saved.
4. Remove styling differences only if they affect the requested pill parity; avoid unrelated screen tweaks.

## Success Criteria
- Recipes category pills visually match Saved pills in size and core structure.
- Tap behavior and selected state still work.
- File remains readable and compilable.

## Risks
- Recipes has longer labels than Saved (`Breakfast`, `Desserts`), so exact Saved padding may need slight horizontal-scroll tolerance but not a structural redesign.
- If there is hidden design intent behind Recipes border/shadow, removing them may alter perceived hierarchy; acceptable unless user asks to preserve that look.

## Unresolved Questions
- Should the updated pill spacing also be visually verified on a narrow device before closing follow-up QA?
