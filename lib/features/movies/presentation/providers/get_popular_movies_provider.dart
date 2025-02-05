import 'package:cinemania/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:cinemania/features/movies/presentation/providers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getPopularMoviesProvider = Provider<GetPopularMovies>((ref) {
  final repository = ref.read(moviesRepositoryProvider);
  return GetPopularMovies(repository);
});
