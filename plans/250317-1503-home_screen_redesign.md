# Implementation Plan - HomeScreen Design Redesign

Redesign the `HomeScreen` to match the provided HTML template, using theme colors and Material 3 patterns.

## User Request
- Design the `HomeScreen` based on provided HTML sample.
- Reuse existing theme colors.
- Follow the visual structure: Header (Menu, Title, Account), Hero (Scan prompt, Camera FAB, Upload button), and Discovery (Horizontal list of dishes).

## Technical Approach
1. **Theme Update (Optional but recommended)**: Align `AppColors` with the brand colors in the HTML (Orange primary).
2. **HomeScreen Structure**:
    - Use `Column` to stack sections.
    - **Header Section**: Custom `Row` with Menu icon, Title, and Rounded Profile button.
    - **Hero Section**: `Expanded` or `Center` widget containing the text instructions and the prominent Camera button with glow effect.
    - **Discovery Section**: Horizontal `ListView` with dish items.
3. **Components**:
    - `DiscoveryCard`: A stateless widget for dish items.
    - `GlowButton`: For the large camera button (using `BoxShadow` and `Decoration`).

## Proposed Changes

### 1. Style & Theme Updates
- Update `lib/theme/colors.dart` to match HTML colors (Orange brand).

### 2. HomeScreen Redesign
- Modify `lib/features/home/home_screen.dart` to implement the layouts.
- Use `MaterialSymbols` if available, otherwise `Icons.camera_alt_outlined` etc.

### 3. Navigation Check
- Ensure `HomeScreen` fits within `MainScreen`'s `IndexedStack`.

## File Changes
- `lib/theme/colors.dart`: Update brand colors to match "primary": "#ff8e42".
- `lib/features/home/home_screen.dart`: Complete redesign.

## Verification
- Run the app and verify the visual layout matches the HTML description.
- Check responsive behavior.
