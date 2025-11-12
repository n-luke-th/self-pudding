# Pudding by LukeCreated release history

Release history is adapting the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) version **1.1.0** format.

## [Unreleased]

- Theme config
- Multi-locales support
- Add essential auth related functions (e.g. password retrieval)
- Add Analytic and Crash report
- Add report and block violence actions or contents

## Initial Development: [`0.1.8`] - 2025-10-30

### Added

- Platform adaptive logout confirmation dialog.
- Added success toast when user successfully login with email.

### Changed

- Overall improvement.
- Refactored blurry background panels to a reusable method.
- More complete drawer design and elements.
- `CollectionDraftScreen` is now `CookingCollectionScreen`.

### Deprecated

- none

### Removed

- none

### Fixed

- Fixed sometime the login with email panel is not disappear when the login is success.

### Others

- Included `cupertino_icons` direct dependency and upgraded the dependency constraints.

## Initial Development: [`0.1.7`] - 2025-10-23

### Added

- All in one `utils.dart` file for utility methods.
- Draft of the new Pudding form panel.

### Changed

- Draft of the Drawer panel.
- Code refactored.
- Draft of the collection creation form.
- Overall improvement.

### Deprecated

- none

### Removed

- none

### Fixed

- Fixed the overflow of all auth panels when the mobile is displaying wide axis as 'X' axis.

### Others

- Upgraded dependency constraints.

## Initial Development: [`0.1.6`] - 2025-10-14

### Added

- Important fields of collection creation panel added.

### Changed

- Adjusted the initialization files of the app.
- Using the global navigator key as the way to navigate (routing) between pages on app.
- `CollectionDraftScreen` with related functions are being implemented.
- Overall improvement.

### Deprecated

- none

### Removed

- none

### Fixed

- Fixed type 'Null' is not a subtype of type 'Object' where it is expected to be return type when routing to Talker page (dev log page) and other page(s).

### Others

- `choice` direct dependency is added.
- Upgraded dependency constraints.

## Initial Development: [`0.1.5`] - 2025-10-13

### Added

- Signup panel added.

### Changed

- Code refactored.
- Overall improvement.

### Deprecated

- none

### Removed

- none

### Fixed

- Fixed the keyboard is covered the dialog's contents when the dialog is shown (fixed screen not resizing).
- Fixed the focus is not move to the next field of the interactive dialog when user clicks 'next' on the keyboard.
- Linked the icon size param of the `closeBtn`.

### Others

- none

## Initial Development: [`0.1.4+1`] - 2025-10-13

### Added

- Comments added.

### Changed

- Code refactored.

### Deprecated

- none

### Removed

- none

### Fixed

- none

### Others

- none

## Initial Development: [`0.1.4`] - 2025-10-13

### Added

- Auto retrieve app package info.
- Blurry background behind the default loading indicator and signin options panels.
- Custom toasts with details panel.

### Changed

- Reorganized folder structure.
- A working signin with email panel.
- Overall improvement.

### Deprecated

- none

### Removed

- none

### Fixed

- none

### Others

- `talker_riverpod_logger`, `blurrycontainer`, `lucide_icons_flutter`, `glass_kit`, `validatorless`, `package_info_plus`, and `soft_edge_blur` direct dependencies are added.

## Initial Development: [`0.1.3`] - 2025-10-10

### Added

- `FullPageLoading`, the full page loading indicator.
- Panel `SigninEmailPanel` added.
- `Parts` class added for reusable stuff like `defaultEdgeInsetsAll` and etc.
- Dedicated `Routing` class for shorthanded routing calls.

### Changed

- Adjusted the way of initialize app and initial page loading.
- Added more `meta` tags for web.
- Edited initial `title` tag for web.

### Deprecated

- none

### Removed

- none

### Fixed

- none

### Others

- `talker_riverpod_logger` direct dependency is added and upgraded other dependencies.

## Initial Development: [`0.1.2`] - 2025-10-06

### Added

- Loading overlay works.
- Panel `SigninAnonyPanel` added.

### Changed

- Design edited.

### Deprecated

- none

### Removed

- none

### Fixed

- none

### Others

- `flutter_svg` direct dependency is added.

## Initial Development: [`0.1.1`] - 2025-10-03

### Added

- EndDrawer added as draft.
- Components added, including the `pageViewWrapper`.

### Changed

- Adjusted Riverpod compatible folder Structure.

### Deprecated

- none

### Removed

- none

### Fixed

- none

### Others

- `flutter_smart_dialog` direct dependency is added.

## Initial Development: [`0.1.0`] - 2025-10-02

### Added

- Riverpod compatible folder Structure.
- Draft of add new collection and item(pudding) inside collection itself.
- Able to sign in anonymously.
- Beautiful logger added.

### Changed

- none

### Deprecated

- none

### Removed

- none

### Fixed

- none

### Others

- none
