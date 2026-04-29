class DonationModel {
  final int id;
  final String name;
  final String title;
  final String description;
  final double raised;
  final double goal;
  final String image;

  DonationModel({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.raised,
    required this.goal,
    required this.image,
  });

  double get progress => raised / goal;

  factory DonationModel.fromJson(Map<String, dynamic> json) {
    return DonationModel(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      raised: (json['raised'] as num).toDouble(),
      goal: (json['goal'] as num).toDouble(),
      image: json['image'] ?? '',
    );
  }
}

enum DonationCategory { education, medical, orphans }

extension DonationCategoryX on DonationCategory {
  String get titleKey {
    switch (this) {
      case DonationCategory.education:
        return 'education_title';
      case DonationCategory.medical:
        return 'medical_title';
      case DonationCategory.orphans:
        return 'orphans_title';
    }
  }
}
