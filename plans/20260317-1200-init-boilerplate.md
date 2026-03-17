# Implementation Plan - Initialize Flutter Boilerplate (MVVM)

Initialize a Flutter project with a feature-based MVVM architecture as defined in `flutter_pattern.md`, avoiding `go_router`.

## User Requirements
- Follow `lib/` structure in `flutter_pattern.md`.
- Use MVVM pattern.
- **Do not use `go_router`**.
- Initialize boilerplate.

## Proposed Architecture
- **State Management**: `provider` (standard for this pattern).
- **Dependency Injection**: `get_it` (standard for this pattern).
- **Navigation**: Native `Navigator` with `onGenerateRoute` in `lib/navigation/router.dart`.
- **Project Structure**:
    - `lib/features/`: UI and ViewModels.
    - `lib/models/`: Data models.
    - `lib/navigation/`: Routing logic.
    - `lib/repositories/`: Data access.
    - `lib/services/`: Services.
    - `lib/theme/`: Theme data.
    - `lib/utils/`: Constants and logging.

## Phases

### Phase 1: Dependency Setup
- Add `provider`, `get_it`, `logger` to `pubspec.yaml`.
- Run `flutter pub get`.

### Phase 2: Folder Structure & Core Files
- Create directory structure.
- Initialize `lib/utils/console.dart` (logger).
- Initialize `lib/theme/colors.dart` and `theme_data.dart`.
- Initialize `lib/navigation/routes.dart` (route names) and `router.dart` (onGenerateRoute).

### Phase 3: DI & Service Layer
- Create `lib/services/api_service.dart`.
- Create `lib/services/app_service.dart`.
- Create `lib/repositories/auth_repository.dart`.
- Setup `lib/service_locator.dart` (get_it initialization).

### Phase 4: Initial Feature (Home)
- Create `lib/features/home/home_screen.dart`.
- Create `lib/features/home/home_viewmodel.dart`.
- Update `lib/main.dart` to use the new navigation and DI.

### Phase 5: Cleanup
- Remove default counter code.
- Verify everything compiles.
