import 'package:cinemania/features/movies/data/datasources/genres_api.dart';
import 'package:cinemania/features/movies/data/models/movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel extends Movie {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'poster_path')
  final String posterPath;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  @JsonKey(name: 'overview')
  final String overview;
  @JsonKey(name: 'release_date')
  final String releaseDate;

  MovieModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    required this.overview,
    required this.releaseDate,
    required List<String> genreNames,
  }) : super(
          id: id,
          title: title,
          posterPath: posterPath,
          genreIds: genreIds,
          genreNames: genreNames,
          overview: overview,
          releaseDate: releaseDate,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json, GenresApi genresApi) {
    List<int> genreIds = List<int>.from(json['genre_ids']);
    List<String> genreNames = genreIds.map((id) => genresApi.getGenreName(id)).toList();

    return MovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'] ?? "",
      genreIds: genreIds,
      overview: json['overview'],
      releaseDate: json['release_date'] ?? "Unknown",
      genreNames: genreNames,
    );
  }
}
