import 'package:cinemania/core/l10n/locale_provider.dart';
import 'package:cinemania/core/theme/theme_provider.dart';
import 'package:cinemania/features/movies/presentation/pages/movies_page.dart';
import 'package:cinemania/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  final initialLocale = await LocaleNotifier.initializeLocale();

  runApp(ProviderScope(
    overrides: [
      localeProvider.overrideWith((ref) => initialLocale),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Cinemania',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'MX'),
      ],
      locale: locale,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: const MoviesPage(),
    );
  }
}
