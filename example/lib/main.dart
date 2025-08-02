import 'package:flutter/material.dart';
import 'package:otpify/otpify.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData.light(
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Otpify Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Otpify(
          fields: 5,
          resendSecond: 15,
          fieldColor: Colors.amber,
          borderRadiusValue: 16,
          resendAlignment: ResendAlignment.start,
          resendText: 'Resend code',
          resendDisableColor: Colors.grey[600],
          onChanged: (value) {
            /// Perform action on field change.
          },
          onCompleted: (code) {
            /// Assign [code] to your TextController to get the full code.
          },
          onResend: () {
            /// Initiate OnResendEvent()
          },
        ),
      ),
    );
  }
}
