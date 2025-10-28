import 'dart:async';
import 'package:flutter/material.dart';
import '../model/login_model.dart';

class LoginProvider extends ChangeNotifier {
  LoginModel _loginModel = const LoginModel();
  Timer? _imageTimer;

  LoginModel get loginModel => _loginModel;

  final List<String> _animationImages = [
    'assets/images/splashscreen.png',
    'assets/images/splashscreen.png',
    'assets/images/splashscreen.png',
    'assets/images/splashscreen.png',
  ];

  LoginProvider() {
    _startImageAnimation();
  }

  void _startImageAnimation() {
    _imageTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _loginModel = _loginModel.copyWith(
        currentImageIndex:
            (_loginModel.currentImageIndex + 1) % _animationImages.length,
      );
      notifyListeners();
    });
  }

  void updatePhoneNumber(String phoneNumber) {
    _loginModel = _loginModel.copyWith(phoneNumber: phoneNumber);
    notifyListeners();
  }

  void selectImage(int index) {
    _imageTimer?.cancel();
    _loginModel = _loginModel.copyWith(currentImageIndex: index);
    notifyListeners();
    _startImageAnimation();
  }

  Future<void> sendOTP(BuildContext context) async {
    _loginModel = _loginModel.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    _loginModel = _loginModel.copyWith(isLoading: false);
    notifyListeners();
    
    // Navigate to OTP screen
    Navigator.pushNamed(context, '/otp');
  }

  String get currentImage => _animationImages[_loginModel.currentImageIndex];

  @override
  void dispose() {
    _imageTimer?.cancel();
    super.dispose();
  }
}
