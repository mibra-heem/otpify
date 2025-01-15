import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otpify/otpify.dart';

void main() {
  group('Otpify Widget Tests', () {
    testWidgets('Renders OTP input fields correctly', (WidgetTester tester) async {
      // Build the Otpify widget
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Otpify(
            fields: 4,
            onChanged: (value) {},
            onCompleted: (otp) {},
          ),
        ),
      ));

      // Check if all 4 OTP input fields are rendered
      expect(find.byType(TextField), findsNWidgets(4));
    });

    testWidgets('OTP value changes when typing', (WidgetTester tester) async {
      // Build the Otpify widget
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Otpify(
            fields: 4,
            onChanged: (value) {
              // Check if value changes
              expect(value, isNotEmpty);
            },
            onCompleted: (otp) {},
          ),
        ),
      ));

      // Tap on the first OTP field and enter a value
      await tester.tap(find.byType(TextField).first);
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '1');
    });

    testWidgets('Completes OTP after entering all digits', (WidgetTester tester) async {
      // Build the Otpify widget
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Otpify(
            fields: 4,
            onChanged: (value) {},
            onCompleted: (otp) {
              // Check if the completed OTP is correct
              expect(otp, equals('1234'));
            },
          ),
        ),
      ));

      // Tap on each field and enter a digit
      await tester.enterText(find.byType(TextField).at(0), '1');
      await tester.enterText(find.byType(TextField).at(1), '2');
      await tester.enterText(find.byType(TextField).at(2), '3');
      await tester.enterText(find.byType(TextField).at(3), '4');
      await tester.pumpAndSettle();
    });
  });
}
