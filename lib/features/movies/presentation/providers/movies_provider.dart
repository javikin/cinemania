import 'package:cinemania/core/network/dio_config.dart';
import 'package:cinemania/features/movies/data/datasources/genres_api.dart';
import 'package:cinemania/features/movies/data/datasources/movies_api.dart';
import 'package:cinemania/features/movies/data/repositories/movies_repository.dart';
import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => DioConfig.createDio());
final genresApiProvider = Provider((ref) => GenresApi(ref.read(dioProvider)));
final moviesApiProvider = Provider((ref) => MoviesApi(ref.read(dioProvider), ref.read(genresApiProvider)));
final moviesRepositoryProvider = Provider((ref) => MoviesRepository(ref.read(moviesApiProvider)));

final moviesProvider = FutureProvider<List<Movie>>((ref) async {
  final repository = ref.watch(moviesRepositoryProvider);
  return repository.getPopularMovies(language: "en-US");
});

final searchQueryProvider = StateProvider<String>((ref) => "");

final filteredMoviesProvider = Provider<List<Movie>>((ref) {
  final List<Movie> movies = ref.watch(moviesProvider).maybeWhen(data: (data) => data, orElse: () => []);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return movies;

  return movies.where((movie) => movie.title.toLowerCase().contains(query)).toList();
});
