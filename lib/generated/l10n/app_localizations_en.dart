import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Cinemania';

  @override
  String get popularMovies => 'Popular Movies';

  @override
  String get searchHint => 'Search Movies';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'An error occurred. Please try again.';
}
