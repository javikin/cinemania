import 'package:dio/dio.dart';

class GenresApi {
  final Dio dio;
  static Map<int, String> _genresCache = {};

  GenresApi(this.dio);

  Future<void> fetchGenres({String language = 'en-US'}) async {
    if (_genresCache.isNotEmpty) return;

    try {
      final response = await dio.get("/genre/movie/list", queryParameters: {"language": language});

      final List genresList = response.data["genres"];
      _genresCache = {for (var genre in genresList) genre["id"]: genre["name"]};
    } catch (e) {
      throw Exception("Failed to load genres");
    }
  }

  String getGenreName(int id) {
    return _genresCache[id] ?? "Unknown";
  }
}
