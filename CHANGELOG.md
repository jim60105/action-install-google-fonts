# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/).

> [!NOTE]  
> Versions `1.x.x` summarize the original upstream project (`hms5232/install-CNS11643-fonts-action`) so the migration history remains discoverable.

<!-- markdownlint-disable MD024 -->

## [Unreleased]

### Added

- Install any Google Fonts families by listing them in the `fonts` input, supporting comma-separated or multi-line values.
- Customize downloadable font weights with the `weights` input while keeping `400,700` as a sensible default.

### Changed

- Switch the action implementation from CNS11643 archives to Google Fonts CSS endpoints so any language set can be installed.
- Inline the install script inside `action.yml` for simpler maintenance on composite runners.

### Removed

- Dropped the `download-flag` action input in favor of the standard quiet `wget` flags used by the installer script.

## [1.1.1] - 2025-04-03

### Fixed

- Adjusted the CNS11643 download flow to match the upstream website changes, thanks to @Snorlax-sour for the report.

## [1.1.0] - 2022-07-23

### Added

- Added the `download-flag` parameter so users could fine-tune the verbosity of the underlying `wget` command (defaulting to `-nv`).

## [1.0.0] - 2022-04-07

### Added

- Initial release of the CNS11643 fonts installer for GitHub Actions.

[Unreleased]: https://github.com/jim60105/action-install-google-fonts/compare/v1.1.1...HEAD
[1.1.1]: https://github.com/jim60105/action-install-google-fonts/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/jim60105/action-install-google-fonts/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/jim60105/action-install-google-fonts/releases/tag/v1.0.0
