---
title: "Scanner Image Upload"
description: "Add gallery image upload to the scanner flow and pass the selected image into confirm."
status: in-progress
priority: P2
effort: 1.5h
branch: main
tags: [flutter, scanner, upload, gallery]
created: 2026-03-18
---

# Scanner Image Upload

## Phases
- [x] Inspect current scanner, confirm, routing, and platform config
- [ ] Add gallery picker dependency and required platform usage descriptions
- [ ] Unify captured/uploaded image state in `ScannerViewModel`
- [ ] Navigate to confirm with selected image path via route arguments
- [ ] Render selected image preview in confirm screen
- [ ] Run `flutter pub get`, `flutter analyze`, and relevant tests

## Key Decisions
- Keep MVVM shape already used by feature
- Pass a plain image path through route arguments; no new domain model yet
- Reuse one scanner state for both camera capture and gallery upload
- Avoid OCR/detection plumbing here because current flow is still UI-only

## Risks
- iOS requires photo library usage description
- Existing camera flow also lacks explicit usage descriptions; add while touching platform config
- Confirm screen already uses placeholder ingredients, so uploaded image preview is the only real downstream effect in this change

## Success Criteria
- Upload button in scanner opens gallery
- Picking an image navigates to confirm screen
- Confirm screen receives and renders the selected image
- Capture flow still navigates with captured image
- Project analyzes without new errors

## Unresolved Questions
- None
