# System Architecture

## Overview

MenuAI is a client-side Flutter application with a feature-oriented presentation layer and a mostly stubbed service layer. The current architecture is optimized for UI iteration, not production data flow yet.

## High-Level Layers

| Layer | Current Responsibility |
| --- | --- |
| App bootstrap | Initialize Flutter bindings, DI, theme, routes |
| Navigation | Map route names to screens |
| Presentation | Screens, widgets, and feature UI composition |
| State | `ChangeNotifier` viewmodels |
| Domain/data | Minimal today; mostly static lists and placeholder classes |
| Platform integration | Camera and gallery packages |

## Bootstrap

- `lib/main.dart` calls `WidgetsFlutterBinding.ensureInitialized()`
- `setupLocator()` registers app dependencies
- `MaterialApp` sets `initialRoute` to onboarding and uses `AppRouter.generateRoute`
- `AppTheme.lightTheme` also owns the default light-surface status bar overlay style through `AppBarTheme.systemOverlayStyle`

## Routing

`lib/navigation/router.dart` is the routing hub.

Known routes:

- `Routes.onboard`
- `Routes.main`
- `Routes.home`
- `Routes.settings`
- `Routes.scanner`
- `Routes.confirmIngredients`
- `Routes.step3Result`
- `Routes.detailRecipe`

## State Architecture

- Each main screen creates its own `ChangeNotifierProvider`
- Viewmodels currently mix simple state handling with mock content ownership
- There is no central app-wide state container yet

## Feature Architecture

### Onboarding

- Entry marketing screen with CTA into the main shell

### Main Shell

- `MainScreen` hosts bottom navigation
- `NavigationViewModel` controls selected tab index
- Root tabs now share a common `RootTabAppBar` contract for centered titles and optional leading/trailing actions

### Home To Recipe Flow

1. `HomeScreen` launches scanner
2. `ScannerScreen` initializes camera and supports gallery pick
3. `ConfirmIngredientsScreen` edits ingredient and preference selections
4. `Step3ResultScreen` lists suggested dishes
5. `DetailRecipeScreen` renders the recipe walkthrough

## Data Flow Reality

- Most data is local in widgets or viewmodels
- Scanner capture currently does not complete a verified image-path handoff into confirm
- Confirm screen uses static ingredient defaults
- Results and detail screens use hardcoded recipe data

## Shared UI Infrastructure

- `AppColors` provides the palette
- `AppTheme.lightTheme` defines the Material theme
- `Responsive` contains width/height/scale helpers
- `RootTabAppBar` standardizes top-bar layout for the main tabs

## External Integrations

| Package | Current Usage |
| --- | --- |
| `camera` | Camera preview and capture |
| `image_picker` | Gallery image selection |
| `google_mlkit_text_recognition` | Declared, not yet wired into verified flow |
| `get_it` | DI registration |
| `provider` | UI state management |

## Architectural Risks

- Service and repository layers are structurally present but not functionally meaningful yet
- In-feature hardcoded models can drift from future shared/domain models
- Placeholder tabs and handlers can create misleading expectations

## Suggested Next Architectural Moves

- Complete image-path handoff through scanner to confirm flow
- Define one recipe domain model strategy
- Move mock content behind repositories or local data sources
- Introduce explicit OCR and recommendation boundaries before backend work

## Unresolved Questions

- Is OCR intended to be on-device only, or a precursor to a backend-assisted pipeline?
