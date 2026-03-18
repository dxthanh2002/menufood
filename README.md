# MenuAI Flutter

MenuAI is a Flutter app for turning ingredient photos into meal ideas. The current product flow is:

1. Onboarding
2. Home
3. Camera scanner or gallery upload
4. Ingredient confirmation and preference selection
5. Recipe results
6. Recipe detail

## Current Status

- UI-first mobile app with a clear meal-discovery flow
- Feature-based MVVM structure under `lib/features/`
- Native Flutter navigation via `onGenerateRoute`
- `provider` for screen state and `get_it` for dependency registration
- Several flows still use local mock data and placeholder services

## Tech Stack

- Flutter / Dart
- `provider`
- `get_it`
- `google_fonts`
- `camera`
- `image_picker`
- `path_provider`
- `google_mlkit_text_recognition`
- `logger`

## Project Structure

```text
lib/
├── features/
│   ├── bottom_navigation/
│   ├── detail_recipes/
│   ├── history/
│   ├── home/
│   │   ├── step1_scaner/
│   │   ├── step2_confirm/
│   │   └── step3_result/
│   ├── onboard_screen/
│   ├── recipes/
│   ├── saved/
│   └── user_setting/
├── models/
├── navigation/
├── repositories/
├── services/
├── theme/
├── utils/
├── main.dart
└── service_locator.dart
```

## Key Files

- `lib/main.dart`: app bootstrap, theme, initial route
- `lib/navigation/router.dart`: route generation
- `lib/navigation/routes.dart`: route constants
- `lib/service_locator.dart`: DI registration
- `lib/theme/colors.dart`: shared palette
- `lib/theme/theme_data.dart`: Material 3 theme

## Main Screens

- `OnboardScreen`: entry experience
- `MainScreen`: bottom-navigation shell
- `HomeScreen`: launch point for scanning
- `ScannerScreen`: camera preview, capture, upload affordance
- `ConfirmIngredientsScreen`: edit ingredients and preferences
- `Step3ResultScreen`: suggested dishes
- `DetailRecipeScreen`: ingredient checklist and cooking steps
- `RecipesScreen`, `SavedScreen`, `UserSettingScreen`: additional tabs
- `HistoryScreen`: placeholder

## Known Gaps

- Scanner does not yet pass captured or uploaded image paths consistently into confirm flow
- Ingredient detection is still static UI state
- Recipe results and recipe detail content are hardcoded
- `ApiService`, `AppService`, and `AuthRepository` are placeholders
- `HomeViewModel` still contains boilerplate counter logic
- Test coverage is minimal

## Run Locally

```bash
flutter pub get
flutter run
```

## Helpful Commands

```bash
flutter analyze
flutter test
```

## Documentation

- `docs/project-overview-pdr.md`
- `docs/codebase-summary.md`
- `docs/code-standards.md`
- `docs/system-architecture.md`
- `docs/project-roadmap.md`
- `docs/deployment-guide.md`
- `docs/design-guidelines.md`

## Notes

- `docs/boilerplate-walkthrough.md` describes the original scaffold and is no longer a full picture of the app.
- `repomix-output.xml` was not generated in this session because `repomix` required elevated execution outside the sandbox.
