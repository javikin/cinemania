# 🎬 Cinemania

## 📌 Overview
This project is a Flutter application that lists the most popular movies using TheMovieDB API.

## 🚀 Features
- [X]List popular movies
- [X]Display movie details
- [X]Search movies
- [X]Pagination support
- [X]Multi-language support (EN, ES)
- [X]Dark mode
- [X]Local Storage

## 🏗️ Architecture Diagram
![Architecture Diagram](docs/architecture_diagram.png)

For a detailed view of the architecture in **Mermaid format**, see [architecture_diagram.mmd](docs/architecture_diagram.mmd).

## 🔧 Installation & Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/javikin/cinemania.git
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the application:
   ```sh
   flutter run
   ```
4. Run the tests:
   ```sh
   flutter test
   ```

## Localization (i18n)

This project supports multiple languages using Flutter Localizations. To generate the translations, ensure the `.arb` files are located in the directory defined as `lib/core/i10n/`.

### Generate Translations
If you make changes to the `.arb` files or need to regenerate translations, run the following command:

   ```sh
   flutter gen-l10n
   ```
This command will automatically generate the required classes for translations and place them in the lib/generated/l10n directory

## 📱 Download the App

![App Preview](docs/app_preview.gif)

You can download the app for testing via the following links:

- **Android**: [Download APK](https://i.diawi.com/QaPQ1B)
- **iOS**: [Download App](https://i.diawi.com/A5rMba)

## 📄 License
This project is open-source under the MIT License.
