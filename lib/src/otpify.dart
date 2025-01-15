import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dimensions.dart';


class Otpify extends StatefulWidget {

  final Color? borderColor;
  final BorderRadiusGeometry? borderRadius;
  final double? borderRadiusValue;
  final double? borderWidth;
  final Color? cursorColor;
  final Color? fieldColor;
  final double? fieldSpacing;
  final Color? fieldTextColor;
  final TextStyle? fieldTextStyle;
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final int fields;
  final double? height;
  final Function(String value)? onChanged;
  final Function(String value)? onCompleted;
  final VoidCallback? onResend;
  final EdgeInsets? padding;
  final ResendAlignment resendAlignment;
  final Color? resendColor;
  final Color? resendEnableColor;
  final String? resendFontFamily;
  final double? resendFontSize;
  final FontWeight? resendFontWeight;
  final String resendText;
  final int? seconds;
  final double? width;

  late final List<ValueNotifier<bool>> _focusNotifiers = List.generate(fields, (_) => ValueNotifier(false));
  late final List<TextEditingController> _otpControllers = List.generate(fields, (_) => TextEditingController());

  Otpify({
    super.key,
    this.borderColor,
    this.borderRadius,
    this.borderRadiusValue,
    this.borderWidth,
    this.cursorColor,
    this.fieldColor,
    this.fieldSpacing,
    this.fieldTextColor,
    this.fieldTextStyle,
    required this.fields,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.height,
    this.onChanged,
    this.onCompleted,
    this.onResend,
    this.padding,
    this.resendAlignment = ResendAlignment.start,
    this.resendColor = Colors.black,
    this.resendEnableColor = Colors.grey,
    this.resendFontFamily,
    this.resendFontSize,
    this.resendFontWeight,
    this.resendText = "RESEND CODE",
    this.seconds,
    this.width,
  });

  @override
  State<Otpify> createState() => _OtpifyState();
}

class _OtpifyState extends State<Otpify> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  Timer? _timer;
  bool _isResendEnabled = true;

  @override
  void dispose() {
    _timer?.cancel();
    _counter.dispose();
    for (var notifier in widget._focusNotifiers) {
      notifier.dispose();
    }
    for (var controller in widget._otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Starts the countdown timer for the resend button.
  void _startCountDown() {
    _counter.value = widget.seconds ?? 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter.value > 0) {
        _counter.value -= 1;
      } else {
        timer.cancel();
      }
    });
  }

  /// Updates the focus state of the OTP fields based on the currently focused index.
  void _updateFocusState(int focusedIndex) {
    for (int i = 0; i < widget._focusNotifiers.length; i++) {
      widget._focusNotifiers[i].value = i == focusedIndex;
    }
  }

  /// Returns the cross-axis alignment for the resend button based on the alignment setting.
  CrossAxisAlignment _getResendAlignment(ResendAlignment alignment) {
    switch (alignment) {
      case ResendAlignment.start:
        return CrossAxisAlignment.start;
      case ResendAlignment.center:
        return CrossAxisAlignment.center;
      case ResendAlignment.end:
        return CrossAxisAlignment.end;
    }
  }

  @override
  Widget build(BuildContext context) {
    Dimensions.init(context);
    return Padding(
      padding: widget.padding ?? EdgeInsets.all(Dimensions.size(20)),
      child: Column(
        crossAxisAlignment: _getResendAlignment(widget.resendAlignment),
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: Dimensions.height(25),
        children: [
          // OTP Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: widget.fieldSpacing ?? 0,
            children: List.generate(widget.fields, (index) {
              return ValueListenableBuilder<bool>(
                valueListenable: widget._focusNotifiers[index],
                builder: (context, isFocused, child) {
                  return Container(
                    height: widget.height ?? Dimensions.height(60),
                    width: widget.width ?? Dimensions.width(50),
                    decoration: BoxDecoration(
                      color: widget.fieldColor ?? Colors.transparent,
                      borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.borderRadiusValue ?? Dimensions.width(12)),
                      border: Border.all(
                        color: isFocused
                            ? (widget.focusedBorderColor ?? Colors.black)
                            : (widget.borderColor ?? Colors.grey),
                        width: isFocused ? (widget.focusedBorderWidth ?? 2) : (widget.borderWidth ?? 1.5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      // maxLength: 1,
                      style: widget.fieldTextStyle ?? TextStyle(
                        color: widget.fieldTextColor ?? Colors.black
                      ),
                      controller: widget._otpControllers[index],
                      cursorColor: widget.cursorColor ?? Colors.black,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(1),FilteringTextInputFormatter.digitsOnly,],
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      onTap: () => _updateFocusState(index),
                      onChanged: (value) {
                        // Triggering onChange Callback on otp field change
                        widget.onChanged?.call(value);
                        widget._otpControllers[index].text = value;

                        // Automatically move to the next or previous field based on input
                        if (value.isNotEmpty && index < widget.fields - 1) {
                          _updateFocusState(index + 1);
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          _updateFocusState(index - 1);
                          FocusScope.of(context).previousFocus();
                        }
                        // Submit OTP if all fields are filled
                        if (widget._otpControllers.every((controller) => controller.text.isNotEmpty)) {
                          final otp = widget._otpControllers.map((controller) => controller.text).join();
                        // Triggering onCompleted Callback on all otp fields complete
                          widget.onCompleted?.call(otp);
                        }
                      },
                    ),
                  );
                },
              );
            }),
          ),
          // Resend Button
          GestureDetector(
            onTap: _isResendEnabled
                ? () {
                    _startCountDown();
                    widget.onResend?.call();
                  }
                : null,
            child: ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (context, value, child) {
                _isResendEnabled = value == 0;
                return Text(
                  _isResendEnabled ? widget.resendText : "${widget.resendText} $value",
                  style: TextStyle(
                    color: _isResendEnabled ? widget.resendColor : widget.resendEnableColor,
                    fontSize: widget.resendFontSize ?? 14,
                    fontWeight: widget.resendFontWeight,
                    fontFamily: widget.resendFontFamily,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Enumeration to define the alignment of the resend button.
enum ResendAlignment {
  start,
  center,
  end,
}
