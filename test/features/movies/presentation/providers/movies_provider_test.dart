import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:cinemania/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:cinemania/features/movies/presentation/providers/get_popular_movies_provider.dart';
import 'package:cinemania/features/movies/presentation/providers/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPopularMovies extends Mock implements GetPopularMovies {}

void main() {
  late ProviderContainer container;
  late MockGetPopularMovies mockGetPopularMovies;

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
    mockGetPopularMovies = MockGetPopularMovies();
    container = ProviderContainer(overrides: [
      getPopularMoviesProvider.overrideWithValue(mockGetPopularMovies),
      moviesNotifierProvider.overrideWith((ref) {
        return MoviesNotifier(mockGetPopularMovies);
      }),
    ]);

    when(() => mockGetPopularMovies(language: any(named: "language"), page: any(named: "page")))
        .thenAnswer((_) async => movies);
  });

  tearDown(() {
    container.dispose();
  });

  test('filteredMoviesProvider filters movies based on search query', () async {
    await container.read(moviesNotifierProvider.notifier).loadMovies(language: "en-US");
    container.read(searchQueryProvider.notifier).state = "Inception";
    final filteredMovies = container.read(filteredMoviesProvider);
    expect(filteredMovies.length, 1);
    expect(filteredMovies.first.title, "Inception");
  });

  test('filteredMoviesProvider returns all movies when query is empty', () async {
    await container.read(moviesNotifierProvider.notifier).loadMovies(language: "en-US");
    container.read(searchQueryProvider.notifier).state = "";
    final filteredMovies = container.read(filteredMoviesProvider);
    expect(filteredMovies.length, movies.length);
  });

  test('moviesNotifierProvider loads movies correctly', () async {
    await container.read(moviesNotifierProvider.notifier).loadMovies(language: "en-US");
    final state = container.read(moviesNotifierProvider);
    expect(state.movies, movies);
  });

  test('loadMovies sets isLoading to true while loading', () async {
    final notifier = container.read(moviesNotifierProvider.notifier);

    when(() => mockGetPopularMovies(language: "en-US", page: 1)).thenAnswer((_) async => Future.delayed(
          const Duration(milliseconds: 100),
          () => <Movie>[],
        ));

    expect(container.read(moviesNotifierProvider).isLoading, isFalse);

    notifier.loadMovies(language: "en-US");
    expect(container.read(moviesNotifierProvider).isLoading, isTrue);

    await Future.delayed(const Duration(milliseconds: 200));
    expect(container.read(moviesNotifierProvider).isLoading, isFalse);
  });
}
