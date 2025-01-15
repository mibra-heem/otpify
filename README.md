Here's the updated README file with the full MIT License text included:

---

# Otpify  

**Otpify** is a highly customizable OTP (One-Time Password) input field widget for Flutter, designed to provide a seamless user experience. It features responsive and adaptive design, making it perfect for mobile screens of all sizes. The widget includes a resend OTP timer button, ensuring user convenience while maintaining functionality.

---

## Features  

- **Highly Customizable**: Easily modify the widget to match your design needs.  
- **Resend OTP Timer Button**: Includes a built-in timer to handle OTP resending.  
- **Responsive Design**: Works perfectly across various screen sizes.  
- **Easy Integration**: Plug-and-play widget for quick implementation.  
- **Adaptive Design**: Automatically adjusts to fit mobile screens.  

---

## Installation  

To use Otpify in your Flutter project, add it as a dependency in your `pubspec.yaml` file:  

```yaml  
dependencies:  
  otpify: ^0.0.1  
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
            length: 6,  
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

## Parameters  

Below is a table of customizable parameters for the `Otpify` widget:  

| Parameter      | Type           | Description                                                        | Default Value |  
|----------------|----------------|--------------------------------------------------------------------|---------------| 
| `height`       | `double`       | Specifies the height of OTP input fields.                          | `60`          |  
| `width`        | `double`       | Specifies the width of OTP input fields.                           | `50`          |  
| `fields`       | `int`          | Specifies the number of OTP input fields.                          | `4`           |  
| `onChanged`    | `Function`     | Method triggered when the OTP value changes.                       | `null`        |  
| `onCompleted`  | `Function`     | Method triggered when the user completes all input fields.         | `null`        |  
| `onResend`     | `VoidCallback` | Callback triggered when resend button enabled. button.             | `null`        |  
| `seconds`      | `int`          | Sets the duration for the resend OTP timer.                        | `30`          |  

---

## Responsive and Adaptive Design  

**Otpify** is designed with responsiveness in mind, ensuring that it works seamlessly across devices with different screen sizes and resolutions.  

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

### MIT License Text

```
Copyright (c) 2025 Muhammad Ibrahim

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```

---

## Links  

- **Homepage**: [GitHub Repository](https://github.com/mibra-heem/otpify)  
- **Pub.dev**: [Otpify Package](https://pub.dev/packages/otpify)  

---

Feel free to reach out if you have any questions or suggestions!  

---

This README now includes the full MIT License text as part of the project’s open-source terms.