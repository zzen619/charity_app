class CampaignModel {
  final String id;
  final String title;
  final String category;
  final String imageUrl;
  final double progress;
  final double goal;
  final double raised;

  const CampaignModel({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.progress,
    required this.goal,
    required this.raised,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    final double goal = (json['goal'] as num).toDouble();
    final double raised = (json['raised'] as num).toDouble();

    return CampaignModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      category: json['category'] as String,
      imageUrl: json['image_url'] as String,
      goal: goal,
      raised: raised,
      progress: goal > 0 ? (raised / goal).clamp(0.0, 1.0) : 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'image_url': imageUrl,
    'goal': goal,
    'raised': raised,
  };

  CampaignModel copyWith({
    String? id,
    String? title,
    String? category,
    String? imageUrl,
    double? progress,
    double? goal,
    double? raised,
  }) {
    return CampaignModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      progress: progress ?? this.progress,
      goal: goal ?? this.goal,
      raised: raised ?? this.raised,
    );
  }

  // Mock data للتطوير قبل ربط الـ API
  static List<CampaignModel> get mockList => [
    const CampaignModel(
      id: '1',
      title: 'Build a Future: Village School',
      category: 'Education',
      imageUrl: 'https://picsum.photos/400/200?random=1',
      progress: 0.75,
      goal: 50000,
      raised: 37500,
    ),
    const CampaignModel(
      id: '2',
      title: 'Help Ahmed Complete Treatment',
      category: 'Patients',
      imageUrl: 'https://picsum.photos/400/200?random=2',
      progress: 0.40,
      goal: 12000,
      raised: 4800,
    ),
    const CampaignModel(
      id: '3',
      title: 'Green City: Plant 1000 Trees',
      category: 'Environment',
      imageUrl: 'https://picsum.photos/400/200?random=3',
      progress: 0.60,
      goal: 8000,
      raised: 4800,
    ),
    const CampaignModel(
      id: '4',
      title: 'Support Orphan Care Center',
      category: 'Orphans',
      imageUrl: 'https://picsum.photos/400/200?random=4',
      progress: 0.85,
      goal: 30000,
      raised: 25500,
    ),
    const CampaignModel(
      id: '5',
      title: 'Ramadan Food Baskets',
      category: 'Orphans',
      imageUrl: 'https://picsum.photos/400/200?random=5',
      progress: 0.30,
      goal: 15000,
      raised: 4500,
    ),
  ];
}
