abstract class ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String name;
  final String image;
  final double walletBalance;
  final int totalImpact;
  final int livesTouched;
  final String? error; // ✅ إضافة

  ProfileLoaded({
    required this.name,
    required this.image,
    required this.walletBalance,
    required this.totalImpact,
    required this.livesTouched,
    this.error,
  });

  ProfileLoaded copyWith({
    String? name,
    String? image,
    double? walletBalance,
    int? totalImpact,
    int? livesTouched,
    String? error,
  }) {
    return ProfileLoaded(
      name: name ?? this.name,
      image: image ?? this.image,
      walletBalance: walletBalance ?? this.walletBalance,
      totalImpact: totalImpact ?? this.totalImpact,
      livesTouched: livesTouched ?? this.livesTouched,
      error: error,
    );
  }
}