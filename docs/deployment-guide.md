# Deployment Guide

## Current Reality

This repository is a Flutter app prototype without project-specific production deployment automation. The guide below covers local setup and standard Flutter build entry points only.

## Prerequisites

- Flutter SDK compatible with Dart `^3.11.1`
- Android Studio or Xcode for mobile targets
- A connected device, emulator, or simulator

## Local Setup

```bash
flutter pub get
flutter run
```

## Validation

```bash
flutter analyze
flutter test
```

## Build Commands

### Android APK

```bash
flutter build apk
```

### Android App Bundle

```bash
flutter build appbundle
```

### iOS

```bash
flutter build ios
```

### Web

```bash
flutter build web
```

### Desktop

```bash
flutter build windows
flutter build macos
flutter build linux
```

## Platform Notes

- Camera and gallery flows will require correct platform permissions and usage descriptions
- iOS and Android production signing are not documented in this repo yet
- No environment file, API base URL, or deployment profile was verified in the current codebase

## Release Readiness Gaps

- No documented CI/CD pipeline
- No verified production backend configuration
- No release checklist in repo docs yet
- No confirmed analytics or crash reporting setup

## Recommended Next Additions

- Signing guide per platform
- Permission checklist for camera and photo library
- Release checklist for analyze, test, and manual flow verification

## Unresolved Questions

- Which platforms are considered primary release targets: Android only, mobile-first, or all Flutter targets?
