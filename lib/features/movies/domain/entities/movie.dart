class Movie {
  final int id;
  final String title;
  final String posterPath;
  final List<int> genreIds;
  final List<String> genreNames;
  final String overview;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.genreIds,
    required this.genreNames,
    required this.overview,
    required this.releaseDate,
  });
}
