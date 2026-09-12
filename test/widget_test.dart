import 'package:flutter_test/flutter_test.dart';
import 'package:study_buddy/main.dart';

void main() {
  testWidgets('Study Buddy shows the main title', (tester) async {
    await tester.pumpWidget(const StudyBuddyApp());

    expect(find.text('Study Buddy'), findsOneWidget);
    expect(find.text('Hello, Developer! 👋'), findsOneWidget);
    expect(find.text('Study tasks'), findsOneWidget);
  });
}
