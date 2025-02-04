import 'package:cinemania/core/constants/constants.dart';
import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(
          "${Constants.baseImageUrl}${Constants.imageSizeSmall}${movie.posterPath}",
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 30),
        ),
        title: Text(movie.title),
        subtitle: Text(movie.genreNames.join(', ')),
      ),
    );
  }
}
