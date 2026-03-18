# Project Roadmap

## Status Snapshot

Project state on 2026-03-18: early product prototype with strong UI progress and incomplete data/integration layers.

## Phase Overview

| Phase | Status | Summary |
| --- | --- | --- |
| Foundation | Complete | Flutter app scaffold, theme, routes, MVVM baseline |
| Core navigation and screens | In progress | Main shell, onboarding, home, scanner, confirm, results, detail exist |
| Image intake flow | In progress | Camera/gallery present, path handoff still incomplete |
| Ingredient intelligence | Not started | OCR package present, no verified detection pipeline |
| Recommendation engine | Not started | Results are currently static |
| Persistence and account | Not started | Saved/history/settings are mostly UI only |
| Quality hardening | Not started | Minimal test coverage and placeholder services remain |

## Near-Term Priorities

1. Finish scanner image handoff into confirm flow
2. Replace static ingredient state with real extracted or mocked-through-service data
3. Decide on recipe domain model strategy
4. Add meaningful tests for navigation and scan-confirm-result flow

## Mid-Term Priorities

1. Introduce OCR integration behind a service boundary
2. Define recipe recommendation source
3. Persist saved recipes and history
4. Flesh out settings actions and account-related behavior

## Long-Term Priorities

1. Add production-grade backend integration if required
2. Add telemetry, error reporting, and offline strategy
3. Harden platform permission flows and edge cases

## Milestones

| Milestone | Definition Of Done |
| --- | --- |
| Prototype flow complete | Scan or upload leads to confirm, results, and detail using real app state |
| Intelligence integration | OCR-derived ingredients reach confirm view reliably |
| Data-backed recipes | Results are no longer hardcoded in the UI layer |
| Quality baseline | Analyze and test coverage catch common regressions |

## Current Blockers

- No completed image-state handoff from scanner
- No verified OCR pipeline
- Services and repositories are placeholders

## Documentation Follow-Up

- Update this roadmap when a phase changes status
- Add changelog docs if the project starts shipping releases

## Unresolved Questions

- Is persistence expected before backend integration, or only after API contracts exist?
