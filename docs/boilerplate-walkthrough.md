# Flutter MVVM Boilerplate Walkthrough

I have initialized your project with a feature-based MVVM architecture, following the pattern in `flutter_pattern.md`. As requested, I've avoided `go_router` and used Flutter's native navigation.

## Project Structure

```text
lib/
├── features/
│   └── home/
│       ├── home_screen.dart       # View
│       └── home_viewmodel.dart    # ViewModel
├── models/                         # Data Models
├── navigation/
│   ├── routes.dart                # Route Names
│   └── router.dart                # onGenerateRoute Logic
├── repositories/                   # Data Access
├── services/                       # Business Logic / Services
├── theme/
│   ├── colors.dart                # Color Palette
│   └── theme_data.dart            # App Theme
├── utils/
│   └── console.dart               # Logger Utility
├── main.dart                       # Entry point
└── service_locator.dart            # Dependency Injection (GetIt)
```

## Key Components

### 1. Navigation (Native)
I used `onGenerateRoute` in `lib/navigation/router.dart`. This allows you to define routes without `go_router`.
- **Routes**: Define names in `lib/navigation/routes.dart`.
- **Logic**: Manage route transitions in `lib/navigation/router.dart`.

### 2. State Management (MVVM)
Using the `provider` package:
- **ViewModels** (e.g., `HomeViewModel`) extend `ChangeNotifier`.
- **Screens** (e.g., `HomeScreen`) use `ChangeNotifierProvider` and `Consumer` to listen to state changes.

### 3. Dependency Injection (DI)
Using `get_it` in `lib/service_locator.dart`:
- Services and Repositories are registered in `setupLocator()`.
- You can access them anywhere using `locator<YourService>()`.

### 4. Theming
- Centralized colors in `lib/theme/colors.dart`.
- Configured Material 3 theme in `lib/theme/theme_data.dart`.

### 5. Logging
- Use `Console.debug('msg')`, `Console.error('msg')`, etc., for pretty-printed logs using the `logger` package.

## Next Steps
1. Add your data models in `lib/models/`.
2. Implement API logic in `lib/services/api_service.dart`.
3. Create new features in `lib/features/` following the `home` pattern.
