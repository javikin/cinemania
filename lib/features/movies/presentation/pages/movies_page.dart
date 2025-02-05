import 'package:cinemania/features/movies/presentation/providers/movies_provider.dart';
import 'package:cinemania/features/movies/presentation/widgets/movie_card.dart';
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
      ref.read(moviesNotifierProvider.notifier).loadMovies(language: "en-US");
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      ref.read(moviesNotifierProvider.notifier).loadMovies(language: "en-US");
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredMovies = ref.watch(filteredMoviesProvider);
    final state = ref.watch(moviesNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Popular Movies")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: "Search Movies",
                border: OutlineInputBorder(),
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
