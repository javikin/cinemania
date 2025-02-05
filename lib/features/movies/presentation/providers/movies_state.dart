import 'package:cinemania/features/movies/domain/entities/movie.dart';

class MoviesState {
  final List<Movie> movies;
  final bool isLoading;

  const MoviesState({
    this.movies = const [],
    this.isLoading = false,
  });

  MoviesState copyWith({
    List<Movie>? movies,
    bool? isLoading,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
