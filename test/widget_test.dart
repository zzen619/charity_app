import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:charity_app/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const AtaaApp(initialThemeMode: ThemeMode.light), // ✅ صحيح
    );
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
