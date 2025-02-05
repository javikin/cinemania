import 'package:cinemania/features/movies/data/repositories/movies_repository.dart';
import 'package:cinemania/features/movies/domain/entities/movie.dart';

class GetPopularMovies {
  final MoviesRepository repository;

  GetPopularMovies(this.repository);

  Future<List<Movie>> call({required int page, required String language}) async {
    return await repository.getPopularMovies(page: page, language: language);
  }
}
