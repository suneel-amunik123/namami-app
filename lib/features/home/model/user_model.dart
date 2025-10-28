class UserModel {
  final String name;
  final String email;
  final String mobileNumber;
  final String experience;
  final List<String> languages;
  final String address;
  final String bio;
  final double rating;
  final int totalBookings;
  final double totalEarnings;
  final double monthlyEarnings;

  const UserModel({
    this.name = '',
    this.email = '',
    this.mobileNumber = '',
    this.experience = '',
    this.languages = const [],
    this.address = '',
    this.bio = '',
    this.rating = 0.0,
    this.totalBookings = 0,
    this.totalEarnings = 0.0,
    this.monthlyEarnings = 0.0,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? mobileNumber,
    String? experience,
    List<String>? languages,
    String? address,
    String? bio,
    double? rating,
    int? totalBookings,
    double? totalEarnings,
    double? monthlyEarnings,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      experience: experience ?? this.experience,
      languages: languages ?? this.languages,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      rating: rating ?? this.rating,
      totalBookings: totalBookings ?? this.totalBookings,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      monthlyEarnings: monthlyEarnings ?? this.monthlyEarnings,
    );
  }
}