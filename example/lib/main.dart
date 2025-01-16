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
        resendSecond: 30,
        fieldColor: Colors.lime,
        fieldTextColor: Colors.white,
        cursorColor: Colors.black,
        borderColor: Colors.black,
        focusedBorderColor: Colors.deepOrange,
        resendAlignment: ResendAlignment.start,
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
