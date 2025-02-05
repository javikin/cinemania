import 'package:cinemania/core/logging/app_logger.dart';
import 'package:cinemania/core/network/dio_config.dart';
import 'package:cinemania/features/movies/data/datasources/genres_api.dart';
import 'package:cinemania/features/movies/data/datasources/movies_api.dart';
import 'package:cinemania/features/movies/data/repositories/movies_repository.dart';
import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:cinemania/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:cinemania/features/movies/presentation/providers/get_popular_movies_provider.dart';
import 'package:cinemania/features/movies/presentation/providers/movies_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider((ref) => DioConfig.createDio());
final genresApiProvider = Provider((ref) => GenresApi(ref.read(dioProvider)));
final moviesApiProvider = Provider((ref) => MoviesApi(ref.read(dioProvider), ref.read(genresApiProvider)));
final moviesRepositoryProvider = Provider((ref) => MoviesRepository(ref.read(moviesApiProvider)));

class MoviesNotifier extends StateNotifier<MoviesState> {
  final GetPopularMovies getPopularMovies;
  int _currentPage = 1;

  MoviesNotifier(this.getPopularMovies) : super(const MoviesState());

  Future<void> loadMovies({required String language}) async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);

    try {
      final movies = await getPopularMovies(language: language, page: _currentPage);
      state = state.copyWith(
        movies: [...state.movies, ...movies],
        isLoading: false,
      );
      _currentPage++;
    } catch (e) {
      AppLogger.error("Error fetching movies", error: e);
      state = state.copyWith(isLoading: false);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void resetMovies() {
    state = MoviesState();
  }
}

final moviesNotifierProvider = StateNotifierProvider<MoviesNotifier, MoviesState>((ref) {
  final getPopularMovies = ref.read(getPopularMoviesProvider);
  return MoviesNotifier(getPopularMovies);
});

final searchQueryProvider = StateProvider<String>((ref) => "");

final filteredMoviesProvider = Provider<List<Movie>>((ref) {
  final movies = ref.watch(moviesNotifierProvider).movies;
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if (query.isEmpty) return movies;
  return movies.where((movie) => movie.title.toLowerCase().contains(query)).toList();
});
