import 'package:dio/dio.dart';

class GenresApi {
  final Dio dio;
  static final Map<String, Map<int, String>> _genresCacheByLanguage = {};

  late String lastLanguageUsed;

  GenresApi(this.dio);

  Future<void> fetchGenres({required String language}) async {
    lastLanguageUsed = language;
    if (_genresCacheByLanguage.containsKey(language)) return;

    try {
      final response = await dio.get("/genre/movie/list", queryParameters: {"language": language});

      final List genresList = response.data["genres"];
      _genresCacheByLanguage[language] = {for (var genre in genresList) genre["id"]: genre["name"]};
    } catch (e) {
      throw Exception("Failed to load genres");
    }
  }

  String getGenreName(int id) {
    final genresCache = _genresCacheByLanguage[lastLanguageUsed];
    return genresCache?[id] ?? "Unknown";
  }
}
