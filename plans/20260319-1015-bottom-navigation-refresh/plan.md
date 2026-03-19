---
title: "Bottom Navigation Refresh"
description: "Tight plan to improve the main Flutter bottom navigation based on the provided mobile navigation checklist."
status: completed
priority: P2
effort: 2h
branch: main
tags: [flutter, navigation, mobile-ui]
created: 2026-03-19
---

# Bottom Navigation Refresh

## Scope
- Improve only the shared bottom navigation experience.
- Keep current 4 top-level destinations and persistent tab behavior.
- Avoid route or information-architecture expansion.

## Findings
- Current nav uses 4 tabs, which matches the target 3-5 range.
- Active and inactive states rely mostly on color and weight; icon meaning does not change.
- Icon size is set to `28`, larger than the 24px baseline in the checklist.
- Surface separation relies on a soft shadow only; a lighter divider-based separation is safer and cleaner.
- Destinations are defined inline, making the shared nav harder to tune consistently.

## Phases
1. [Phase 01](phase-01-implement-bottom-navigation-refresh.md) - completed.
2. Verify with `flutter analyze` and `flutter test` - completed.
3. Review docs impact and update only if the design/system guidance materially changed - completed with no docs change needed.

## Success Criteria
- 4 tabs remain persistent and visually consistent.
- Active tab is clearer via at least 2 visual signals.
- Icon size, label sizing, and spacing stay mobile-friendly.
- No compile or analyzer errors introduced.

## Unresolved Questions
- None.
