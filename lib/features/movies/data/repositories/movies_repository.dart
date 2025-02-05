import 'package:cinemania/features/movies/data/datasources/movies_api.dart';
import 'package:cinemania/features/movies/domain/entities/movie.dart';

class MoviesRepository {
  final MoviesApi api;

  MoviesRepository(this.api);

  Future<List<Movie>> getPopularMovies({
    required int page,
    required String language,
  }) async {
    return await api.getPopularMovies(
      language: language,
      page: page,
    );
  }
}
