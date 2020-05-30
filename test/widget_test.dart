import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linos_dictionary/main.dart';
import 'package:linos_dictionary/words.dart';

void main() {
  testWidgets('Test MaterialApp widget exits',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MyApp());
    var materialApp = find.byType(MaterialApp);
    expect(materialApp, findsOneWidget);
  });

  testWidgets('Test WordsPage widget exists',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MyApp());
    var wordsPage = find.byType(WordsPage);
    expect(wordsPage, findsOneWidget);
  });

  testWidgets('Ensure we have a loading word list',
      (WidgetTester widgetTester) async {
    await widgetTester.pumpWidget(MyApp());

    var wordsPage = find.byType(WordsPage);
    expect(wordsPage, findsOneWidget);

    // We know we got a WordsPage, do we have a WordList?
    var wordsList = find.byType(WordList);
    expect(wordsList, findsOneWidget);

    var progress = find.byType(CircularProgressIndicator);
    expect(progress, findsOneWidget);
  });
}
