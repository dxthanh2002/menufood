# Project Overview And PDR

## Product Summary

MenuAI is a Flutter mobile app for ingredient-driven meal discovery. Users scan or upload a photo of ingredients, review detected items and preferences, then browse suggested dishes and open a recipe detail view.

## Product Goals

- Reduce friction between available ingredients and meal choice
- Give users a guided cooking flow from scan to recipe detail
- Provide a clean mobile-first experience across phone and larger layouts

## Current Implemented Scope

- Onboarding flow
- Bottom-navigation shell
- Home scan entry point
- Camera scanner UI
- Ingredient confirmation UI
- Recipe results UI
- Recipe detail UI
- Recipes, saved recipes, and settings tabs

## Current Non-Implemented Or Partial Scope

- Real OCR-driven ingredient extraction
- Real recommendation engine or backend integration
- Persisted saved/history state
- Authentication and account management
- Production-ready analytics, error reporting, and telemetry

## Primary User Flow

1. User lands on onboarding
2. User enters main shell
3. User opens scanner from home
4. User captures or uploads an image
5. User reviews ingredients and preferences
6. User opens recipe results
7. User drills into recipe detail

## Functional Requirements

- App must boot into Flutter `MaterialApp` with a configured theme
- App must support named route generation through `AppRouter.generateRoute`
- User must be able to reach scanner flow from home
- User must be able to review ingredient and preference selections before results
- User must be able to browse recipes from results and tab navigation
- Recipe detail must show ingredients and step-by-step instructions

## Non-Functional Requirements

- Mobile-first responsive layout
- Clear feature-based code organization
- Readable, maintainable screen and viewmodel separation
- No compile-time dependency on backend services yet
- Safe handling of camera or gallery failure states at UI level

## Technical Constraints

- Flutter with Dart `^3.11.1`
- Native navigation, not `go_router`
- `provider` for screen state
- `get_it` for dependency registration
- Camera and image picker access must satisfy platform permissions

## Acceptance Criteria For Current Phase

- App launches successfully
- Onboarding, main, home, scanner, confirm, results, and detail screens are reachable
- Bottom navigation switches tabs
- Theme and shared colors are applied consistently
- Documentation reflects current implementation, including gaps

## Success Metrics

- Users can complete the scan-to-recipe flow without dead ends
- Navigation remains stable across core screens
- Future contributors can identify where UI, state, routing, and services belong

## Risks

- Scanner flow currently stops short of a real image-to-ingredients pipeline
- Hardcoded data may hide future integration complexity
- Model duplication can create maintenance drift
- Minimal tests increase regression risk

## Dependencies

- Flutter SDK
- Platform camera/gallery capabilities
- Third-party packages declared in `pubspec.yaml`

## Unresolved Questions

- Should OCR use `google_mlkit_text_recognition` in the next phase, or was it added preemptively?
- Should recipe recommendations come from a backend API, local rules, or a hybrid approach?
