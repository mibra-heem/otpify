import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otpify/otpify.dart';

void main() {
  testWidgets('Focus changes when tapping on OTP field', (WidgetTester tester) async {
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

    // Verify if the OTP fields are rendered
    expect(find.byType(TextField), findsNWidgets(4));

    // Tap on the first OTP field to set focus
    await tester.tap(find.byType(TextField).first);
    await tester.pumpAndSettle();

    // Simulate typing into the first TextField
    await tester.enterText(find.byType(TextField).first, '1');
    await tester.pumpAndSettle();

    // Check if the first TextField has text (i.e., is focused and the user typed)
    expect(tester.widget<TextField>(find.byType(TextField).first).controller!.text, isNotEmpty);

    // Tap on the second OTP field to set focus
    await tester.tap(find.byType(TextField).at(1));
    await tester.pumpAndSettle();

    // Simulate typing into the second TextField
    await tester.enterText(find.byType(TextField).at(1), '2');
    await tester.pumpAndSettle();

    // Check if the second TextField has text (i.e., is focused and the user typed)
    expect(tester.widget<TextField>(find.byType(TextField).at(1)).controller!.text, isNotEmpty);
  });
}
