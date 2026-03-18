# Codebase Summary

## Summary

This repository is a Flutter application with a feature-based structure and a UI-first implementation of an AI meal suggestion product. The codebase is farther along than the original scaffold, but the service layer and data flow are still early-stage.

## Repo Layout

| Area | Purpose |
| --- | --- |
| `lib/features/` | Screen and feature-specific UI/state |
| `lib/navigation/` | Route constants and route factory |
| `lib/theme/` | Shared palette and theme |
| `lib/models/` | Shared data models |
| `lib/services/` | Service layer placeholders |
| `lib/repositories/` | Repository placeholders |
| `lib/utils/` | Utility helpers |
| `test/` | Widget test coverage |
| `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` | Standard Flutter platform scaffolding |

## Feature Summary

| Feature | Status | Notes |
| --- | --- | --- |
| Onboarding | Implemented | Branded entry screen with CTA into main shell |
| Bottom navigation | Implemented | Home, recipes, saved, history, settings |
| Home | Implemented | Launch point for scan flow |
| Scanner | Partial | Camera init and gallery picker exist; image handoff incomplete |
| Confirm ingredients | Partial | UI complete, state is static and local |
| Recipe results | Partial | Uses hardcoded result data |
| Recipe detail | Partial | Uses hardcoded recipe detail data |
| Recipes tab | Partial | UI implemented with local recipe list |
| Saved tab | Partial | UI implemented with local mock data |
| Settings tab | Partial | UI implemented, handlers mostly empty |
| History tab | Placeholder | Simple placeholder screen |

## Architecture Summary

- `MaterialApp` bootstraps from `lib/main.dart`
- Native route generation lives in `lib/navigation/router.dart`
- State uses `ChangeNotifier` with `provider`
- Dependency registration happens in `lib/service_locator.dart`
- Theme primitives live in `lib/theme/colors.dart` and `lib/theme/theme_data.dart`
- Main-tab screens now share `lib/features/bottom_navigation/root-tab-app-bar.dart`
- Light-theme status bar behavior is centralized in `lib/theme/theme_data.dart`

## Data And Service State

- `lib/models/recipe.dart` defines a reusable `Recipe` model
- `lib/features/home/step3_result/step3_result_viewmodel.dart` defines a separate in-feature recipe model for result/detail flow
- `lib/services/api_service.dart`, `lib/services/app_service.dart`, and `lib/repositories/auth_repository.dart` are placeholders

## Testing State

- `test/widget_test.dart` contains a single widget test focused on the confirm ingredients screen
- No broad unit, integration, or scanner-flow coverage exists yet

## Documentation Notes

- `docs/boilerplate-walkthrough.md` reflects the original scaffold, not the full current app
- README was previously boilerplate and has been refreshed in this session

## Repomix Status

`repomix-output.xml` was regenerated in this session.

## Unresolved Questions

- Should the result/detail recipe model be merged with the shared `Recipe` model?
- Should saved/history features persist locally before backend work begins?
