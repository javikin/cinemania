import 'package:cinemania/core/l10n/locale_provider.dart';
import 'package:cinemania/features/movies/presentation/providers/movies_provider.dart';
import 'package:cinemania/features/movies/presentation/widgets/movie_card.dart';
import 'package:cinemania/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesPage extends ConsumerStatefulWidget {
  const MoviesPage({super.key});

  @override
  _MoviesPageState createState() => _MoviesPageState();
}

class _MoviesPageState extends ConsumerState<MoviesPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final locale = ref.read(localeProvider);
      ref.read(moviesNotifierProvider.notifier).loadMovies(language: locale.toLanguageTag());
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      final locale = ref.read(localeProvider);
      ref.read(moviesNotifierProvider.notifier).loadMovies(language: locale.toLanguageTag());
    }
  }

  void _changeLanguage(Locale newLocale) {
    ref.read(localeProvider.notifier).state = newLocale;

    ref.read(moviesNotifierProvider.notifier).resetMovies();
    ref.read(moviesNotifierProvider.notifier).loadMovies(language: newLocale.toLanguageTag());
  }

  @override
  Widget build(BuildContext context) {
    final filteredMovies = ref.watch(filteredMoviesProvider);
    final state = ref.watch(moviesNotifierProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.popularMovies),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              final locale = ref.read(localeProvider);
              final newLocale = locale.toLanguageTag() == 'en-US' ? const Locale('es', 'MX') : const Locale('en', 'US');
              _changeLanguage(newLocale);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: l10n.searchHint,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: filteredMovies.length + (state.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == filteredMovies.length && state.isLoading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return MovieCard(movie: filteredMovies[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
