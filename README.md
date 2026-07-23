# Penalty

A Flutter application for discovering and booking football fields. Penalty aims to simplify access to nearby fields and organize the booking experience through a modern interface that supports both Arabic and English.

> **Project Status:** Under active development. The current version includes onboarding, location services, localization, and the core application architecture. Booking and field-management features are still being developed.

## Current Features

- Native splash screen.
- Interactive onboarding experience.
- Location permission handling.
- Current user location detection.
- Arabic and English localization.
- Smooth navigation using GoRouter.
- Scalable Clean Architecture structure.
- State management using BLoC.
- Dependency injection using GetIt.
- Material 3 user interface.
- Authentication infrastructure using Supabase.

## Planned Features

- Discover nearby football fields.
- Search for fields using location and maps.
- View field information and available services.
- Browse available booking times.
- Book football fields through the application.
- Manage current and previous bookings.
- Track payments and outstanding balances.
- Receive booking notifications and reminders.
- Support multiple fields within one management system.

## Tech Stack

- Flutter
- Dart
- Supabase
- BLoC
- Clean Architecture
- Dio
- GoRouter
- GetIt
- Easy Localization
- Google Maps Flutter
- Geolocator
- Image Picker
- File Picker
- Dartz
- Equatable
- Flutter Native Splash

## Project Architecture

The project follows a feature-first structure with separated layers based on Clean Architecture:

```text
lib/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── location/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── app_router.dart
├── injection_container.dart
└── main.dart
```

## Requirements

- Flutter SDK compatible with Dart 3.9 or later.
- Android Studio or Visual Studio Code.
- Android/iOS emulator or physical device.
- A configured Supabase project for authentication.
- A Google Maps API key when map features are enabled.

## Getting Started

```bash
git clone https://github.com/Saeed-Qatan/Penalty-Flutter.git
cd Penalty-Flutter
flutter pub get
flutter run
```

## Code Quality and Testing

```bash
flutter analyze
flutter test
```

## Roadmap

- Complete registration and login using Supabase.
- Add field discovery based on the user’s location.
- Integrate interactive maps.
- Build field details and availability screens.
- Implement the complete booking workflow.
- Add online payment support.
- Build user profiles and booking history.
- Integrate real-time notifications.

## Developer

**Saeed Qatan**

[GitHub Profile](https://github.com/Saeed-Qatan)