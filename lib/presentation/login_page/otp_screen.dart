import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mavericscare/presentation/home_screen.dart';
import 'package:mavericscare/utils/constants.dart';
import '../../widgets/custom_pincode_text_field.dart';
import '../../widgets/custom_snack_bar.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  final String country;

  const OTPScreen({required this.phone, required this.country});

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late Timer _timer;
  int _remainingSeconds = 60;
  bool _isResendClickable = false;
  TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isResendClickable = true;
          _timer.cancel();
        }
      });
    });
  }

  void _validateOtp() {
    final enteredOTP = _otpController.text;
    if (enteredOTP == '888888') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
      CustomSnackbar.show(context, message: "OTP Successfully Verified!");
    } else {
      CustomSnackbar.show(context,message:"Incorrect OTP, please try again.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('OTP Verification'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                "Enter the 6 digit OTP sent to +${widget.country}-${widget.phone}",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomPinCodeTextField(
                context: context,
                controller: _otpController,
                onChanged: (value) {
                  // You can perform any necessary operations here
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateOtp,
                child: const Text('Verify OTP',style: TextStyle(color: AppColors.darkAppColor300),),
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Didn’t receive OTP? ", style: TextStyle(color: Colors.black)
                      ),
                      TextSpan(
                        text: _isResendClickable ? 'Resend OTP' : 'Resend OTP in $_remainingSeconds sec',
                        style: _isResendClickable
                            ? const TextStyle(color:Colors.blueGrey,decoration: TextDecoration.underline)
                            : const TextStyle(color: Colors.black),
                        recognizer: _isResendClickable
                            ? (TapGestureRecognizer()
                          ..onTap = () {
                            // _generateOtp();
                            // sendOtp();
                            // Handle resend OTP
                            CustomSnackbar.show(context, message: "OTP resent to +91-${widget.phone}");
                            if (mounted) {
                              setState(() {
                                _remainingSeconds = 30;
                                _isResendClickable = false;
                                _startTimer();
                              });
                            }
                          })
                            : null,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
