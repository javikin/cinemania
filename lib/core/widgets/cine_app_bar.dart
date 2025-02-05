import 'package:cinemania/core/l10n/locale_provider.dart';
import 'package:cinemania/core/theme/theme_provider.dart';
import 'package:cinemania/features/movies/presentation/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class CineAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;
  final bool showActions;

  const CineAppBar({
    super.key,
    required this.title,
    this.showActions = false,
  });

  void _changeLanguage(WidgetRef ref) {
    final currentLocale = ref.read(localeProvider);
    final newLocale = currentLocale.languageCode == 'en' ? 'es' : 'en';
    ref.read(localeProvider.notifier).changeLocale(newLocale);
    ref.read(localeProvider.notifier).changeLocale(newLocale);
    ref.read(moviesNotifierProvider.notifier).resetMovies();
    ref.read(moviesNotifierProvider.notifier).loadMovies(language: newLocale);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title),
      actions: showActions
          ? [
              NeuIconButton(
                icon: const Icon(Icons.language),
                enableAnimation: true,
                buttonWidth: 50,
                buttonColor: const Color(0xFF91D5FF),
                borderRadius: BorderRadius.circular(10),
                onPressed: () {
                  _changeLanguage(ref);
                },
              ),
              const SizedBox(width: 8),
              NeuIconButton(
                icon: const Icon(Icons.brightness_6),
                buttonWidth: 50,
                buttonColor: const Color(0xFFFFE58F),
                borderRadius: BorderRadius.circular(10),
                enableAnimation: true,
                onPressed: () {
                  ref.read(themeNotifierProvider.notifier).toggleTheme();
                },
              ),
              const SizedBox(width: 8),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
