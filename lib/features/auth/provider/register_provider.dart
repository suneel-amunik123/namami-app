import 'package:flutter/material.dart';
import '../model/register_model.dart';
import '../../../core/routes/routes.dart';

class RegisterProvider extends ChangeNotifier {
  RegisterModel _registerModel = const RegisterModel();
  
  RegisterModel get registerModel => _registerModel;

  final List<String> experienceOptions = [
    '0 to 1 years',
    '1 to 3 years',
    '3 to 5 years',
    '5 to 7 years',
    '7 to 10 years',
    '10+ years',
  ];

  final List<String> languageOptions = [
    'Telugu',
    'Hindi',
    'English',
    'Marathi',
    'Kannada',
    'Tamil',
    'Bengali',
    'Gujarati',
  ];

  void updateName(String name) {
    _registerModel = _registerModel.copyWith(name: name);
    notifyListeners();
  }

  void updateMobileNumber(String mobileNumber) {
    _registerModel = _registerModel.copyWith(mobileNumber: mobileNumber);
    notifyListeners();
  }

  void updateEmail(String email) {
    _registerModel = _registerModel.copyWith(email: email);
    notifyListeners();
  }

  void updateExperience(String experience) {
    _registerModel = _registerModel.copyWith(experience: experience);
    notifyListeners();
  }

  void updateLanguages(List<String> languages) {
    _registerModel = _registerModel.copyWith(languages: languages);
    notifyListeners();
  }

  void updateAddress(String address) {
    _registerModel = _registerModel.copyWith(address: address);
    notifyListeners();
  }

  void updateBio(String bio) {
    _registerModel = _registerModel.copyWith(bio: bio);
    notifyListeners();
  }

  bool _isFormValid() {
    return _registerModel.name.isNotEmpty &&
           _registerModel.mobileNumber.isNotEmpty &&
           _registerModel.email.isNotEmpty &&
           _registerModel.experience.isNotEmpty &&
           _registerModel.languages.isNotEmpty &&
           _registerModel.address.isNotEmpty;
  }

  Future<void> register() async {
    if (!_isFormValid()) return;
    
    _registerModel = _registerModel.copyWith(isLoading: true);
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 2));
    
    _registerModel = _registerModel.copyWith(isLoading: false);
    notifyListeners();
    
    // Navigate to home screen after successful registration
    RouteManager.pushNamedAndRemoveAll(Routes.home);
  }
}