import 'package:cinemania/core/logging/app_logger.dart';
import 'package:cinemania/core/network/api_exceptions.dart';
import 'package:cinemania/features/movies/data/datasources/genres_api.dart';
import 'package:cinemania/features/movies/data/models/movie_model.dart';
import 'package:dio/dio.dart';

class MoviesApi {
  final Dio dio;
  final GenresApi genresApi;

  MoviesApi(this.dio, this.genresApi);

  Future<List<MovieModel>> getPopularMovies({
    String language = 'en-US',
  }) async {
    try {
      await genresApi.fetchGenres(language: language);

      final response = await dio.get(
        "/discover/movie",
        queryParameters: {
          "include_adult": false,
          "include_video": false,
          "language": language,
          "page": 1,
          "sort_by": "popularity.desc"
        },
      );
      return (response.data['results'] as List)
          .map((json) => MovieModel.fromJson(
                json,
                genresApi,
              ))
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error("Error fetching movies", error: e, stackTrace: stackTrace);
      throw ServerException();
    }
  }
}
