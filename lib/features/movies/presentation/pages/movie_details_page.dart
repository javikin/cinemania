import 'package:cinemania/core/constants/constants.dart';
import 'package:cinemania/core/widgets/cine_app_bar.dart';
import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final releaseDate = DateTime.tryParse(movie.releaseDate);

    final formattedDate = releaseDate != null ? DateFormat.yMMMd(locale).format(releaseDate) : movie.releaseDate;

    return Scaffold(
      appBar: CineAppBar(title: movie.title),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              "${Constants.baseImageUrl}${Constants.imageSizeMedium}${movie.posterPath}",
              width: double.infinity,
              height: 400,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.broken_image, size: 100)),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(movie.genreNames.join(', ')),
                  const SizedBox(height: 8),
                  Text(formattedDate),
                  const SizedBox(height: 8),
                  Text(movie.overview),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
