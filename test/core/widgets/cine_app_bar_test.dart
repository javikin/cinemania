import 'package:cinemania/core/widgets/cine_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CineAppBar displays the title correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            appBar: CineAppBar(title: 'Cinemania', showActions: false),
          ),
        ),
      ),
    );

    expect(find.text('Cinemania'), findsOneWidget);
  });

  testWidgets('CineAppBar shows actions when showActions is true', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            appBar: CineAppBar(title: 'Cinemania', showActions: true),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.language), findsOneWidget);
    expect(find.byIcon(Icons.brightness_6), findsOneWidget);
  });
}
