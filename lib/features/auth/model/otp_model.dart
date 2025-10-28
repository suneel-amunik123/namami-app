class OtpModel {
  final String otp;
  final bool isLoading;
  final String? errorMessage;
  final int resendTimer;
  final bool canResend;

  const OtpModel({
    this.otp = '',
    this.isLoading = false,
    this.errorMessage,
    this.resendTimer = 60,
    this.canResend = false,
  });

  OtpModel copyWith({
    String? otp,
    bool? isLoading,
    String? errorMessage,
    int? resendTimer,
    bool? canResend,
  }) {
    return OtpModel(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      resendTimer: resendTimer ?? this.resendTimer,
      canResend: canResend ?? this.canResend,
    );
  }
}