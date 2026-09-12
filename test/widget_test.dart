import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_buddy/main.dart';

void main() {
  testWidgets('Study Buddy shows the main screen', (tester) async {
    await tester.pumpWidget(const StudyBuddyApp());

    expect(find.text('Study Buddy'), findsOneWidget);
    expect(find.text('Hello, Developer! 👋'), findsOneWidget);
    expect(find.text('Study tasks'), findsOneWidget);
  });

  testWidgets('user can add a study task', (tester) async {
    await tester.pumpWidget(const StudyBuddyApp());

    await tester.tap(find.text('Add task'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField),
      'Practice Dart functions',
    );

    await tester.tap(find.text('Add'));
    await tester.pumpAndSettle();

    expect(
      find.text('Practice Dart functions'),
      findsOneWidget,
    );
  });

  testWidgets('user can complete a study task', (tester) async {
    await tester.pumpWidget(const StudyBuddyApp());

    expect(
      find.text('Learn Flutter widgets'),
      findsOneWidget,
    );

    final checkbox = find.byType(CheckboxListTile).first;

    await tester.tap(checkbox);
    await tester.pump();

    expect(
      find.byType(CheckboxListTile),
      findsNWidgets(3),
    );
  });
}