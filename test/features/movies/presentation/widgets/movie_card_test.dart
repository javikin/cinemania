import 'package:cinemania/features/movies/domain/entities/movie.dart';
import 'package:cinemania/features/movies/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MovieCard displays movie data correctly', (WidgetTester tester) async {
    final movie = Movie(
      id: 1,
      title: "Inception",
      posterPath: "/inception.jpg",
      genreIds: [28],
      genreNames: ["Action"],
      overview: "A thief who steals corporate secrets",
      releaseDate: "2010-07-16",
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MediaQuery(
            data: const MediaQueryData(),
            child: Builder(builder: (context) {
              return MovieCard(movie: movie);
            }),
          ),
        ),
      ),
    );

    expect(find.text("Inception"), findsWidgets);
    expect(find.text("Action"), findsWidgets);
    expect(find.byType(Image), findsWidgets);
  });
}
