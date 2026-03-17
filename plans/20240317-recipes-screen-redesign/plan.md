# Implementation Plan - Recipes Screen Redesign

The objective is to redesign the `RecipesScreen` to match a provided HTML/Tailwind CSS template.

## User Context
- **Name**: MenuAI
- **Screen**: Recipe Search / Recipes
- **Key Features**: Header, Search, Categories, Trending Recipes, Bottom Nav (already in a shell)

## Technical Details
- **Location**: `lib/features/recipes/recipes_screen.dart`
- **MVVM Pattern**: Will implement within the existing screen structure.
- **Theme**: Already matches colors (#ff8e42 primary).

## Phased Approach

### Phase 1: Setup & Scouting
- [ ] Review current `RecipesScreen` (done)
- [ ] Identify reusable components if any (e.g. `RecipeCard` if it exists elsewhere, or create one).
- [ ] Scout for existing images or assets if needed (will use placeholders/AI generated values for now as per HTML).

### Phase 2: Building the UI Components
- [ ] Create `RecipeCard` widget in a local `widgets/` folder or within the file if small.
- [ ] Create `CategoryItem` widget.

### Phase 3: Screen Implementation
- [ ] **Header**: Implement the title and notification button.
- [ ] **Search**: Implement the search bar with icon.
- [ ] **Categories**: Implement the horizontal list.
- [ ] **Recipes List**: Implement the vertical list of trending recipes.

### Phase 4: Styling & Polish
- [ ] Ensure dark mode compatibility (HTML uses `.dark` classes).
- [ ] Match padding, shadows, and radii (1rem = 16px).
- [ ] Add micro-animations or hover effects if appropriate (shadow changes on card).

### Phase 5: Verification
- [ ] Run `flutter run` and check the actual device/emulator.
- [ ] Compare with the HTML sample.

## Notes
- The HTML uses `Material Symbols Outlined`. We'll use `Icons.material_symbols_outlined` if possible or standard Material Icons that match.
- The bottom navigation in the HTML is slightly different from the default `NavigationBar`. Will check if I need to update `MainScreen`.
