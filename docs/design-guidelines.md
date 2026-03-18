# Design Guidelines

## Visual Direction

The current app uses a warm food-oriented palette with a light background, orange primary actions, soft cream surfaces, and rounded cards/buttons. Typography leans on `Inter` through `google_fonts`.

## Core Tokens

| Token | Value | Use |
| --- | --- | --- |
| Primary | `#FF8E42` | Main CTA, active emphasis |
| Secondary | `#FF8C00` | Supporting accent |
| Background | `#F8F7F5` | Main app background |
| Surface | `#FFFFFF` | Cards and panels |
| Accent brown | `#4A3728` | Premium/food tone for headings |
| Soft cream | `#F4ECE6` | Secondary surfaces |

Source: `lib/theme/colors.dart`

## Component Style

- Prefer rounded corners and soft shadows
- Use high-contrast CTA buttons for primary actions
- Keep navigation icons and labels simple and readable
- Use large, friendly headings for feature entry points

## Layout

- Design is mobile-first
- `Responsive` helper is already used for scaling, tablet checks, and desktop checks
- Preserve comfortable spacing around key actions, especially scan and recipe cards

## Screen-Specific Patterns

- Onboarding: editorial hero plus clear linear steps
- Home: centered scan CTA with supporting discovery content
- Scanner: dark immersive camera UI with overlay framing
- Confirm: sectioned chips and option groups
- Results/detail: content-forward scroll experience

## Consistency Rules

- Reuse `AppColors` instead of inline ad hoc color values where possible
- Prefer route constants over string literals for navigation
- Keep ingredient, recipe, and settings cards visually related

## Accessibility Notes

- Maintain readable contrast over light backgrounds
- Preserve large tap targets for scanner and navigation controls
- Validate text scaling behavior on smaller devices during future QA

## Current Design Debt

- Some screens still use inline colors instead of centralized tokens
- Visual consistency between tabs is not fully unified yet
- Placeholder screens and stub actions weaken UX continuity

## Unresolved Questions

- Should the app keep the current warm editorial style, or evolve toward a more utility-first cooking tool aesthetic?
