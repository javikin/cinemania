import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:cinemania/features/movies/presentation/providers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;
  final movies = [
    Movie(
      id: 1,
      title: "Inception",
      posterPath: "/inception.jpg",
      genreIds: [28],
      genreNames: ["Action"],
      overview: "A thief who steals corporate secrets",
      releaseDate: "2010-07-16",
    ),
    Movie(
      id: 2,
      title: "Interstellar",
      posterPath: "/interstellar.jpg",
      genreIds: [12],
      genreNames: ["Adventure", "Sci-Fi"],
      overview: "A team of explorers travel through a wormhole",
      releaseDate: "2014-11-07",
    ),
    Movie(
      id: 3,
      title: "The Dark Knight",
      posterPath: "/the_dark_knight.jpg",
      genreIds: [28, 80],
      genreNames: ["Action", "Crime"],
      overview: "When the menace known as the Joker wreaks havoc",
      releaseDate: "2008-07-18",
    ),
  ];

  setUp(() {
    container = ProviderContainer(overrides: [
      moviesProvider.overrideWith((ref) async => movies),
    ]);
  });

  test('filteredMoviesProvider filters movies based on search query', () async {
    List<Movie>? filteredMovies;
    container.listen<List<Movie>>(filteredMoviesProvider, (previous, next) {
      filteredMovies = next;
    });

    container.read(searchQueryProvider.notifier).state = "Inception";
    await Future.delayed(const Duration(milliseconds: 100));

    expect(filteredMovies!.length, 1);
    expect(filteredMovies!.first.title, "Inception");
  });

  test('filteredMoviesProvider returns all movies when query is empty', () async {
    List<Movie>? filteredMovies;
    container.listen<List<Movie>>(filteredMoviesProvider, (previous, next) {
      filteredMovies = next;
    });

    container.read(searchQueryProvider.notifier).state = "";

    await Future.delayed(const Duration(milliseconds: 100));

    expect(filteredMovies!.length, movies.length);
  });
}
