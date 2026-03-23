---
title: "Remove unused google_mlkit_text_recognition dependency"
description: "Clean dependency, lockfile, and docs for the unused OCR package."
status: completed
priority: P2
effort: 30m
branch: main
tags: [flutter, dependencies, cleanup]
created: 2026-03-23
---

# Overview

- status: completed
- Goal: remove unused `google_mlkit_text_recognition` cleanly, keep app compiling
- Scope: dependency config, generated lockfile, docs references, validation

# Phases

1. Audit current usage
- Confirm no runtime imports, DI registration, platform setup, or build scripts depend on the package.
- Re-scan repo for `google_mlkit_text_recognition`, `TextRecognizer`, `RecognizedText`, `InputImage`.

2. Remove package config
- Delete the dependency from `pubspec.yaml`.
- Refresh `pubspec.lock` via `flutter pub get` so the package is removed from resolved dependencies.

3. Clean docs references
- Update docs that still list OCR package as active stack or planned architecture detail.
- At minimum check `README.md`, `docs/project-overview-pdr.md`, and `docs/system-architecture.md`.

4. Validate project health
- Run `flutter analyze`.
- Run targeted repo search again to ensure no remaining live references outside historical/generated artifacts.
- If analyze fails, fix fallout caused by dependency removal before finishing.

# TODO

- [x] Verify package is truly unused in source code
- [x] Remove dependency from `pubspec.yaml`
- [x] Regenerate `pubspec.lock`
- [x] Update stale documentation references
- [x] Run analyze and final search

# Risks

- `pubspec.lock` update needs local Flutter toolchain and may fail if dependency resolution is blocked.
- Historical/generated files may still mention the package; decide whether to keep or refresh them based on project conventions.

# Success Criteria

- Package removed from `pubspec.yaml` and `pubspec.lock`
- No source-code references remain
- Docs no longer present the OCR package as active dependency
- Dart analysis reports no errors for project sources

# Unresolved Questions

- Should generated artifact `repomix-output.xml` be refreshed now or left as historical output?

