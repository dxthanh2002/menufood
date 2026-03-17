# Implementation Plan: AI Menu Bottom Navigation

This plan details the implementation of a features-rich, 4-tab bottom navigation for the AI Menu application, ensuring a premium user experience and adherence to the project's MVVM architecture.

## Phase 1: Infrastructure and Feature Scaffolding
- [ ] Create placeholder screens for Recipes, Saved, and History features.
- [ ] Implement `NavigationViewModel` to manage navigation state globally.
- [ ] Update `service_locator.dart` to register the `NavigationViewModel`.

## Phase 2: Create Navigation Shell (MainScreen)
- [ ] Implement `MainScreen` in `lib/features/bottom_navigation/main_screen.dart`.
- [ ] Use `IndexedStack` to preserve the state of each tab.
- [ ] Build a custom-styled `NavigationBar` that matches the reference image:
  - **Icons**: Home (active tint orange), Recipes (grey), Saved (grey), History (grey).
  - **Colors**: Active tab should have orange icons/text. Inactive should have grey icons/text.

## Phase 3: Integration and Routing
- [ ] Update `lib/navigation/routes.dart` with a new root route for the navigation shell.
- [ ] Refactor `AppRouter` to set `MainScreen` as the initial destination.
- [ ] Standardize the app entry point to load the shell.

## Phase 4: Styling and UI/UX Polish
- [ ] Define precise colors in `lib/theme/colors.dart`.
- [ ] Add micro-animations (e.g., scale on tap, smooth color transition) using `Animate` or basic Flutter animations.
- [ ] Ensure the design looks premium (e.g., balanced padding, proper icon sizes, subtle box shadow for the nav bar).

## Technical Requirements
- Use **Provider** for state management.
- Avoid **go_router** as specified.
- Support **persistence** of scroll positions and user data across tab switches.

## Verification Tasks
- [ ] Verify tab switching is smooth.
- [ ] Ensure state is preserved when switching back to a tab.
- [ ] Check design against reference image for icon accuracy and color.
