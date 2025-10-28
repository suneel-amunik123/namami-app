import 'dart:async';
import 'package:flutter/material.dart';
import '../model/otp_model.dart';

class OtpProvider extends ChangeNotifier {
  OtpModel _otpModel = const OtpModel();
  Timer? _resendTimer;
  
  OtpModel get otpModel => _otpModel;

  OtpProvider() {
    _startResendTimer();
  }

  void _startResendTimer() {
    _otpModel = _otpModel.copyWith(resendTimer: 60, canResend: false);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpModel.resendTimer > 0) {
        _otpModel = _otpModel.copyWith(resendTimer: _otpModel.resendTimer - 1);
        notifyListeners();
      } else {
        _otpModel = _otpModel.copyWith(canResend: true);
        timer.cancel();
        notifyListeners();
      }
    });
  }

  void updateOtp(String otp) {
    _otpModel = _otpModel.copyWith(otp: otp);
    notifyListeners();
  }

  Future<void> verifyOtp(BuildContext context) async {
    _otpModel = _otpModel.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2));
    
    _otpModel = _otpModel.copyWith(isLoading: false);
    notifyListeners();
    
    // Navigate to register screen
    Navigator.pushNamed(context, '/register');
  }

  void resendOtp() {
    if (_otpModel.canResend) {
      _startResendTimer();
    }
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }
}