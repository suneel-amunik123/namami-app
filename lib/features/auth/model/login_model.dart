class LoginModel {
  final String phoneNumber;
  final bool isLoading;
  final String? errorMessage;
  final int currentImageIndex;

  const LoginModel({
    this.phoneNumber = '',
    this.isLoading = false,
    this.errorMessage,
    this.currentImageIndex = 0,
  });

  LoginModel copyWith({
    String? phoneNumber,
    bool? isLoading,
    String? errorMessage,
    int? currentImageIndex,
  }) {
    return LoginModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      currentImageIndex: currentImageIndex ?? this.currentImageIndex,
    );
  }
}