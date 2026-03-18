# Code Standards

## Scope

These standards describe the codebase as it exists today and the conventions future work should follow.

## Core Principles

- Keep features simple and composable
- Prefer clear UI flow over premature abstraction
- Reuse shared theme tokens and route constants
- Document only verified behavior

## Codebase Structure

| Directory | Rule |
| --- | --- |
| `lib/features/` | Keep feature UI and viewmodel code together |
| `lib/models/` | Put reusable cross-feature models here |
| `lib/navigation/` | Centralize route names and route factory logic |
| `lib/services/` | Put business/service integrations here |
| `lib/repositories/` | Put data-access abstractions here |
| `lib/theme/` | Keep palette and theme definitions centralized |
| `lib/utils/` | Keep lightweight shared helpers only |

## State Management

- Use `ChangeNotifier` viewmodels with `provider` for screen-scoped state
- Instantiate feature viewmodels close to the screen that owns them
- Keep viewmodels focused on UI state until real domain logic requires extraction

## Navigation

- Add route constants to `lib/navigation/routes.dart`
- Register screen transitions in `lib/navigation/router.dart`
- Prefer named route navigation for consistency with the current app

## Dependency Injection

- Register shared dependencies in `lib/service_locator.dart`
- Only register services or repositories that have concrete value
- Avoid unused DI registrations

## Styling

- Use `AppColors` and `AppTheme` as the first source of truth
- Reuse `Responsive` utility for layout scaling where the codebase already does so
- Keep typography and component styling consistent with the existing warm brand palette

## Models

- Put reusable models in `lib/models/`
- Avoid duplicating domain concepts across feature-local and shared models unless there is a strong boundary
- When a feature-specific model must exist, document why

## Services And Repositories

- Keep external API or persistence logic out of widgets
- Move mock data out of UI classes once a real data source exists
- Add explicit error handling before wiring production integrations

## Testing

- Add widget tests for user-visible flows
- Add unit tests for non-trivial viewmodel logic
- Expand coverage before major service or OCR integration

## Current Deviations To Address

- `HomeViewModel` still contains scaffold-style counter logic
- Placeholder services and repository are registered before containing business logic
- Recipe modeling is split across shared and feature-local classes
- Many UI handlers are stubs

## Documentation Rule

- Update docs when feature scope, architecture, or roadmap state changes

## Unresolved Questions

- Should the project standardize on shared models earlier, or wait until backend contracts exist?
