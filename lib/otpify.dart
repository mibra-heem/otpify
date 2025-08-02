import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that provides OTP (One-Time Password) input functionality
/// with customizable styles, validation, and a resend button.
class Otpify extends StatefulWidget {
  /// Constructs the [Otpify] widget.
  Otpify({
    required this.fields,
    this.borderColor,
    this.borderRadius,
    this.borderRadiusValue,
    this.borderWidth,
    this.cursorColor,
    this.fieldColor,
    this.fieldSpacing,
    this.fieldTextColor,
    this.fieldTextStyle,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.height,
    this.isResendButtonEnable = true,
    this.onChanged,
    this.onCompleted,
    this.onResend,
    this.padding,
    this.resendAlignment = ResendAlignment.start,
    this.resendEnableColor,
    this.resendDisableColor,
    this.resendFontFamily,
    this.resendFontSize,
    this.resendFontWeight,
    this.resendSecond,
    this.resendText = 'RESEND CODE',
    this.showResendButton = true,
    this.verticalSpacing,
    this.width,
    super.key,
  });

  /// Border color of the OTP fields.
  final Color? borderColor;

  /// Border radius of the OTP fields,
  /// (overrides [borderRadiusValue] if provided).
  final BorderRadiusGeometry? borderRadius;

  /// Border radius value for the OTP fields.
  final double? borderRadiusValue;

  /// Border width of the OTP fields.
  final double? borderWidth;

  /// Color of the cursor in the OTP fields.
  final Color? cursorColor;

  /// Background color of the OTP fields.
  final Color? fieldColor;

  /// Spacing between OTP fields.
  final double? fieldSpacing;

  /// Text color of the OTP fields.
  final Color? fieldTextColor;

  /// Custom text style for the OTP fields.
  final TextStyle? fieldTextStyle;

  /// Border color of the currently focused OTP field.
  final Color? focusedBorderColor;

  /// Border width of the currently focused OTP field.
  final double? focusedBorderWidth;

  /// Total number of OTP input fields.
  final int fields;

  /// Height of each OTP field.
  final double? height;

  /// Whether the resend button is enabled.
  final bool isResendButtonEnable;

  /// Callback function triggered when the value in any OTP field changes.
  final void Function(String value)? onChanged;

  /// Callback function triggered when all OTP fields are filled.
  final void Function(String value)? onCompleted;

  /// Callback function triggered when the resend button is tapped.
  final VoidCallback? onResend;

  /// Padding around the OTP fields.
  final EdgeInsets? padding;

  /// Alignment of the resend button.
  final ResendAlignment resendAlignment;

  /// Color of the resend button text when it is enabled.
  final Color? resendEnableColor;

  /// Color of the resend button text when it is disabled.
  final Color? resendDisableColor;

  /// Font family of the resend button text.
  final String? resendFontFamily;

  /// Font size of the resend button text.
  final double? resendFontSize;

  /// Font weight of the resend button text.
  final FontWeight? resendFontWeight;

  /// Countdown seconds for enabling the resend button.
  final int? resendSecond;

  /// Text displayed on the resend button.
  final String resendText;

  /// Whether to show resend button.
  final bool showResendButton;

  /// Spacing between OTP fields and resend button.
  final double? verticalSpacing;

  /// Width of each OTP field.
  final double? width;

  /// A list of [ValueNotifier] bool to track the focus state of each OTP field.
  late final List<ValueNotifier<bool>> _focusNotifiers =
      List.generate(fields, (_) => ValueNotifier(false));

  /// A list of [TextEditingController] to manage the text input for each OTP field.
  late final List<TextEditingController> _otpControllers =
      List.generate(fields, (_) => TextEditingController());

  @override
  State<Otpify> createState() => _OtpifyState();
}

class _OtpifyState extends State<Otpify> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  Timer? _timer;
  bool _isResendEnabled = true;
  bool _isFilled = false;

  @override
  void dispose() {
    _timer?.cancel();
    _counter.dispose();
    for (final notifier in widget._focusNotifiers) {
      notifier.dispose();
    }
    for (final controller in widget._otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Starts the countdown timer for the resend button.
  void _startCountDown() {
    _counter.value = widget.resendSecond ?? 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter.value > 0) {
        _counter.value -= 1;
      } else {
        timer.cancel();
      }
    });
  }

  /// Updates the focus state of the OTP fields
  /// based on the currently focused index.
  void _updateFocusState(int focusedIndex) {
    for (var i = 0; i < widget._focusNotifiers.length; i++) {
      widget._focusNotifiers[i].value = i == focusedIndex;
    }
  }

  /// Returns the cross-axis alignment for the resend button
  /// based on the alignment setting.
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
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: _getResendAlignment(widget.resendAlignment),
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: widget.verticalSpacing ?? 30,
        children: [
          // OTP Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: widget.fieldSpacing ?? 0,
            children: List.generate(widget.fields, (index) {
              return ValueListenableBuilder<bool>(
                valueListenable: widget._focusNotifiers[index],
                builder: (context, isFocused, child) {
                  final color = Theme.of(context).colorScheme;
                  return Container(
                    height: widget.height ?? 50,
                    width: widget.width ?? 50,
                    decoration: BoxDecoration(
                      color: widget.fieldColor ?? color.surfaceBright,
                      borderRadius: widget.borderRadius ??
                          BorderRadius.circular(widget.borderRadiusValue ?? 12),
                      border: Border.all(
                        color: isFocused
                            ? (widget.focusedBorderColor ?? color.outline)
                            : (widget.borderColor ?? Colors.grey),
                        width: isFocused
                            ? (widget.focusedBorderWidth ?? 2)
                            : (widget.borderWidth ?? 1.5),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: TextField(
                      style: widget.fieldTextStyle ??
                          TextStyle(
                            color: widget.fieldTextColor ?? color.onSurface,
                          ),
                      controller: widget._otpControllers[index],
                      cursorColor: widget.cursorColor ?? color.primary,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(1),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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

                        // Automatically move to the next
                        //or previous field based on input
                        if (value.isNotEmpty && index < widget.fields - 1) {
                          _updateFocusState(index + 1);
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          _updateFocusState(index - 1);
                          FocusScope.of(context).previousFocus();
                        }
                        // Submit OTP if all fields are filled
                        if (widget._otpControllers.every(
                            (controller) => controller.text.isNotEmpty)) {
                          final otp = widget._otpControllers
                              .map((controller) => controller.text)
                              .join();
                          // Triggering onCompleted Callback
                          // on all otp fields complete
                          widget.onCompleted?.call(otp);
                          setState(() {
                            _isFilled = true;
                          });
                        } else {
                          setState(() {
                            _isFilled = false;
                          });
                        }
                      },
                    ),
                  );
                },
              );
            }),
          ),
          // Resend Button
          if (widget.showResendButton)
            ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (context, value, child) {
                _isResendEnabled = value == 0;
                return GestureDetector(
                  onTap: _isResendEnabled
                      ? () {
                          if (_isFilled) {
                            _startCountDown();
                            widget.onResend?.call();
                          }
                        }
                      : null,
                  child: Text(
                    _isResendEnabled
                        ? widget.resendText
                        : '${widget.resendText} $value',
                    style: TextStyle(
                      color: (_isResendEnabled && _isFilled)
                          ? widget.resendEnableColor
                          : widget.resendDisableColor,
                      fontSize: widget.resendFontSize ?? 14,
                      fontWeight: widget.resendFontWeight,
                      fontFamily: widget.resendFontFamily,
                    ),
                  ),
                );
              },
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}

/// Enumeration to define the alignment of the resend button.
enum ResendAlignment {
  /// Align the resend button to the start (left).
  start,

  /// Align the resend button to the center.
  center,

  /// Align the resend button to the end (right).
  end,
}
