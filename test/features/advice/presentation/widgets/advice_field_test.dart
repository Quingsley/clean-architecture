import 'package:clean_architecture/features/advice/presentation/widgets/advice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String advice}) {
    return MaterialApp(
      home: AdviceField(advice: advice),
    );
  }

  group('Advice Field', () {
    group('should be displayed correctly', () {
      testWidgets('when a short text is given', (widgetTester) async {
        String text = 'test';

        await widgetTester.pumpWidget(widgetUnderTest(advice: text));
        await widgetTester.pumpAndSettle(); //no animation
        final adviceFinderField = find.textContaining(text);

        expect(adviceFinderField, findsOneWidget);
      });
    });
  });
}
