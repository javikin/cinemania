import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:cinemania/features/movies/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MovieDetailsPage displays movie details correctly', (WidgetTester tester) async {
    final movie = Movie(
      id: 1,
      title: "Inception",
      posterPath: "/inception.jpg",
      genreIds: [28],
      genreNames: ["Action", "Sci-Fi"],
      overview: "A thief who steals corporate secrets",
      releaseDate: "2010-07-16",
    );

    await tester.pumpWidget(
      MaterialApp(
        home: MovieDetailsPage(movie: movie),
      ),
    );

    expect(find.text("Inception"), findsWidgets);
    expect(find.text("Action, Sci-Fi"), findsWidgets);
    expect(find.text("Release Date: 2010-07-16"), findsWidgets);
    expect(find.text("A thief who steals corporate secrets"), findsWidgets);

    final poster = find.byType(Image);
    expect(poster, findsOneWidget);
  });
}
