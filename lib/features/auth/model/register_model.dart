class RegisterModel {
  final String name;
  final String mobileNumber;
  final String email;
  final String experience;
  final List<String> languages;
  final String address;
  final String bio;
  final bool isLoading;

  const RegisterModel({
    this.name = '',
    this.mobileNumber = '',
    this.email = '',
    this.experience = '',
    this.languages = const [],
    this.address = '',
    this.bio = '',
    this.isLoading = false,
  });

  RegisterModel copyWith({
    String? name,
    String? mobileNumber,
    String? email,
    String? experience,
    List<String>? languages,
    String? address,
    String? bio,
    bool? isLoading,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      experience: experience ?? this.experience,
      languages: languages ?? this.languages,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}