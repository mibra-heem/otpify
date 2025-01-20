import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:otpify/otpify.dart';

void main() {
  testWidgets('Resend button timer functionality', (WidgetTester tester) async {
    // Mock widget properties
    const String resendText = "RESEND CODE";
    const int resendSeconds = 5;
    bool isResendCalled = false;

    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Otpify(
            fields: 4,
            resendText: resendText,
            resendSecond: resendSeconds,
            resendEnableColor: Colors.green,
            resendColor: Colors.grey,
            onResend: () => isResendCalled = true,
          ),
        ),
      ),
    );

    // Verify initial state (timer = 0, button enabled)
    expect(find.text(resendText), findsOneWidget);
    expect(isResendCalled, isFalse);

    // Tap the button to start the timer
    await tester.tap(find.text(resendText));
    await tester.pump(); // Trigger onTap logic

    // Verify button is disabled and timer starts (e.g., RESEND CODE 5)
    expect(find.text("$resendText $resendSeconds"), findsOneWidget);
    expect(isResendCalled, isTrue);

    // Simulate countdown by pumping time
    for (int i = resendSeconds - 1; i >= 0; i--) {
      await tester.pump(const Duration(seconds: 1));
      expect(find.text("$resendText $i"), findsOneWidget);
    }

    // Verify button re-enables after countdown
    await tester.pump(const Duration(seconds: 1)); // Simulate timer ending
    expect(find.text(resendText), findsOneWidget);
  });
}
