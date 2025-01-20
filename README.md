
# Otpify  

**Otpify** A highly customizable OTP (One-Time Password) input field widget for Flutter, designed to provide a seamless user experience. It features an adaptive design, making it perfect for mobile screens of all sizes. The widget includes a resend OTP timer button, ensuring user convenience while maintaining functionality.

---

## Features  

- **Highly Customizable**: Easily modify the widget to match your design needs.  
- **Resend OTP Timer Button**: Includes a built-in timer to handle OTP resending.  
- **Easy Integration**: Plug-and-play widget for quick implementation.  
- **Adaptive Design**: Automatically adjusts to fit mobile screens.  

---

## Installation  

To use Otpify in your Flutter project, add it as a dependency in your `pubspec.yaml` file:  

```yaml  
dependencies:  
  otpify: ^0.1.3  
```  

Then, run the following command to fetch the package:  

```bash  
flutter pub get  
```  

Alternatively, you can directly add it using the Flutter CLI:  

```bash  
flutter pub add otpify  
```  

---

## Usage  

Here's a basic example of how to use **Otpify** in your Flutter project:  

```dart  
import 'package:otpify/otpify.dart';  
import 'package:flutter/material.dart';  

void main() {  
  runApp(const MyApp());  
}  

class MyApp extends StatelessWidget {  
  const MyApp({Key? key}) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: Scaffold(  
        appBar: AppBar(title: const Text('Otpify Example')),  
        body: Center(  
          child: Otpify(  
            fields: 6,  
            onChanged: (value) {  
              print("OTP Entered: $value");  
            },  
            onCompleted: (value) {  
              print("Complete OTP: $value");  
            },  
          ),  
        ),  
      ),  
    );  
  }  
}  
```  

---

## Otpify Example

Here’s a quick demo of how the Otpify package works:

![Otpify Demo](Add example.gif link from github)

---

## Parameters  

Below is a table of customizable parameters for the `Otpify` widget:  

| Parameter               | Type           | Description                                                        | Default Value |  
|-------------------------|----------------|--------------------------------------------------------------------|---------------| 
| `height`                | `double`       | Specifies the height of OTP input fields.                          | `60`          |  
| `width`                 | `double`       | Specifies the width of OTP input fields.                           | `50`          |  
| `fields`                | `int`          | Specifies the number of OTP input fields.                          | `4`           |  
| `onChanged`             | `Function`     | Method triggered when the OTP value changes.                       | `null`        |  
| `onCompleted`           | `Function`     | Method triggered when the user completes all input fields.         | `null`        |  
| `onResend`              | `VoidCallback` | Callback triggered when resend button enabled. button.             | `null`        |  
| `resendSecond`          | `int`          | Sets the duration in second for the resend OTP timer.              | `30`          |  
| `showResendButton`      | `bool`         | To show the resend button below the OTP fields.                    | `true`        |  
| `verticalSpacing`       | `double`       | Spacing between OTP fields and resend button.                      | `30`          |  


---

## Contributing  

Contributions are always welcome! If you find a bug or want to add a new feature, please feel free to submit a pull request or open an issue in the repository.  

### Steps to Contribute:  
1. Fork the repository.  
2. Create a new branch for your feature/bugfix.  
3. Commit your changes.  
4. Push the branch and create a pull request.  

---

## License  

This project is licensed under the MIT License. See the [LICENSE](https://github.com/mibra-heem/otpify/blob/main/LICENSE) file for details.  

---

## Links  

- **Homepage**: [GitHub Repository](https://github.com/mibra-heem/otpify)  
- **Pub.dev**: [Otpify Package](https://pub.dev/packages/otpify)  

---

Feel free to reach out if you have any questions or suggestions!  

---

This README now includes the full MIT License text as part of the project’s open-source terms.