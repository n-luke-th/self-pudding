# Pudding

## Features

- Create a set of items for saving such things together with your partner for future reference.
- Edit each pudding (item) on the list in real time with your partner.

## Tech Stack & System Architecture

- Firebase: Authentication, Database (Firestore)

## Folder Structure

```text
lib/
├── main.dart # App entry point & ProviderScope
│
├── core/ # Shared code, not a specific feature
│   └── firebase_providers.dart # Global providers for Firestore/Auth
│
└── features/ # Main app features
|   ├── auth/
|   │   ├── data/
|   │   |   └── auth_repository.dart
|   │   └── providers/
|   │   |   └── auth_providers.dart
│   |
|   ├── collections/
│   |   ├── data/
│   │   |   ├── collection_model.dart
│   │   |   └── collections_repository.dart
│   |   ├── presentation/
│   │   |   └── collections_list_screen.dart
│   |   └── providers/
│   |   |   └── collections_providers.dart
│   |
|   └── puddings/
|   |   ├── data/
│   |   |   ├── pudding_model.dart
│   |   |   └── puddings_repository.dart
|   |   ├── presentation/
│   |   |   └── puddings_screen.dart
|   |   └── providers/
|   |   |   └── puddings_providers.dart
```

## Getting Started

0. make sure you have config the latest changes of the app by run command: `git pull`

1. run `dart pub global activate flutterfire_cli` then run `flutterfire configure` to configure the firebase options

2. run `flutter clean && flutter pub get` to clean up and get dependencies

3. run app on another terminal by using command `flutter run -d chrome --web-port 5555` (this will run on Chrome with port 5555)

## Notable Configurations

### Splash screen

(source: https://pub.dev/packages/flutter_native_splash)

- config the [`native_splash.yaml`](native_splash.yaml) file then
- (everytime after changes were made) regenerate the splash screen based on the [`native_splash.yaml`](native_splash.yaml) file by run command: `dart run flutter_native_splash:create --path=native_splash.yaml`

### Launcher icon

(source: https://pub.dev/packages/icons_launcher)

- run command `flutter pub add -d icons_launcher`
- config the [`launcher_icons.yaml`](launcher_icons.yaml) file then
- (everytime after changes were made) regenerate the launcher icon based on the [`launcher_icons.yaml`](launcher_icons.yaml) file by run command: `dart run icons_launcher:create --path launcher_icons.yaml`

### Change package name

(source: https://pub.dev/packages/change_app_package_name)

- run command `flutter pub add -d change_app_package_name` to add the helper package
- then run `dart run change_app_package_name:main com.your.package.name` to change the package name
