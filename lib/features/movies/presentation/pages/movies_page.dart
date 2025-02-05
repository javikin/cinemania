import 'package:cinemania/features/movies/presentation/providers/movies_provider.dart';
import 'package:cinemania/features/movies/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoviesPage extends ConsumerWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredMovies = ref.watch(filteredMoviesProvider);

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
              onChanged: (value) => ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: filteredMovies.isNotEmpty
                ? ListView.builder(
                    itemCount: filteredMovies.length,
                    itemBuilder: (context, index) => MovieCard(movie: filteredMovies[index]),
                  )
                : const Center(child: Text("No movies found")),
          ),
        ],
      ),
    );
  }
}
