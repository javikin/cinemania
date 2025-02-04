import 'package:cinemania/features/movies/data/datasources/genres_api.dart';
import 'package:cinemania/features/movies/data/datasources/movies_api.dart';
import 'package:cinemania/features/movies/data/models/movie_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

class MockGenresApi extends Mock implements GenresApi {}

void main() {
  late MoviesApi moviesApi;
  late MockDio mockDio;
  late MockGenresApi mockGenresApi;

  setUp(() {
    mockDio = MockDio();
    mockGenresApi = MockGenresApi();
    moviesApi = MoviesApi(mockDio, mockGenresApi);

    when(() => mockGenresApi.getGenreName(any())).thenReturn("Action");
    when(() => mockGenresApi.fetchGenres(language: any(named: "language"))).thenAnswer((_) async {});
  });

  test('getPopularMovies() should return a list of movies', () async {
    final mockResponse = {
      "results": [
        {
          "id": 1,
          "title": "Interstellar",
          "poster_path": "/interstellar.jpg",
          "genre_ids": [28, 12],
          "overview": "Interstellar is a 2014 epic science fiction film directed by Christopher Nolan.",
          "release_date": "2014-11-05",
        },
        {
          "id": 2,
          "title": "Inception",
          "poster_path": "/inception.jpg",
          "genre_ids": [28, 12],
          "overview": "Inception is a 2010 science fiction action film written and directed by Christopher Nolan.",
          "release_date": "2010-07-16",
        },
        {
          "id": 3,
          "title": "The Dark Knight",
          "poster_path": "/the_dark_knight.jpg",
          "genre_ids": [28, 12],
          "overview":
              "The Dark Knight is a 2008 superhero film directed, produced, and co-written by Christopher Nolan.",
          "release_date": "2008-07-18",
        }
      ]
    };

    when(() => mockDio.get(any(), queryParameters: any(named: "queryParameters"))).thenAnswer((_) async => Response(
          data: mockResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: ""),
        ));

    final movies = await moviesApi.getPopularMovies(language: "en-US");

    expect(movies, isA<List<MovieModel>>());
    expect(movies.length, 3);
    expect(movies.first.title, "Interstellar");
    expect(movies.first.genreNames, contains("Action"));
  });

  test('getPopularMovies() should throw an error on API failure', () async {
    when(() => mockDio.get(any(), queryParameters: any(named: "queryParameters"))).thenThrow(DioException(
        requestOptions: RequestOptions(path: ""),
        response: Response(statusCode: 500, requestOptions: RequestOptions(path: ""))));

    expect(() => moviesApi.getPopularMovies(language: "en-US"), throwsA(isA<Exception>()));
  });
}
