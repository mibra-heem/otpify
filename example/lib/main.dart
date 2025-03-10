import 'package:flutter/foundation.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      body: Otpify(
        fields: 5,
        resendSecond: 10,
        borderRadiusValue: 24,
        fieldColor: Colors.transparent,
        fieldTextColor: Colors.black,
        borderColor: Colors.blueGrey,
        focusedBorderColor: Colors.purple,
        resendAlignment: ResendAlignment.start,
        resendText: "Try again",
        onChanged: (value) {
          if (kDebugMode) {
            print("onChanged value : $value");
          }
        },
        onResend: () {
          if (kDebugMode) {
            print("Resend button pressed");
          }
        },
        onCompleted: (value) {
          if (kDebugMode) {
            print("onCompleted value is $value");
          }
        },
      ),
    );
  }
}
