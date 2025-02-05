import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Cinemania';

  @override
  String get popularMovies => 'Películas Populares';

  @override
  String get searchHint => 'Buscar Películas';

  @override
  String get loading => 'Cargando...';

  @override
  String get error => 'Ocurrió un error. Por favor, inténtalo de nuevo.';
}
