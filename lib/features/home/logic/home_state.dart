import '../data/models/campaign_model.dart';

abstract class HomeState {}

// ── الحالات الأساسية
class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

// ── الحالة الرئيسية بعد تحميل البيانات
class HomeLoaded extends HomeState {
  final int volunteers;
  final int donors;
  final int beneficiaries;
  final List<CampaignModel> allCampaigns;
  final String selectedCategory;
  final String searchQuery;

  HomeLoaded({
    required this.volunteers,
    required this.donors,
    required this.beneficiaries,
    required this.allCampaigns,
    this.selectedCategory = 'All',
    this.searchQuery = '',
  });

  // الحملات بعد تطبيق الفلتر والبحث
  List<CampaignModel> get filteredCampaigns {
    List<CampaignModel> result = allCampaigns;

    // فلتر الكاتيغوري
    if (selectedCategory != 'All') {
      result = result.where((c) => c.category == selectedCategory).toList();
    }

    // فلتر البحث
    if (searchQuery.trim().isNotEmpty) {
      final q = searchQuery.toLowerCase();
      result = result
          .where(
            (c) =>
                c.title.toLowerCase().contains(q) ||
                c.category.toLowerCase().contains(q),
          )
          .toList();
    }

    return result;
  }

  HomeLoaded copyWith({
    int? volunteers,
    int? donors,
    int? beneficiaries,
    List<CampaignModel>? allCampaigns,
    String? selectedCategory,
    String? searchQuery,
  }) {
    return HomeLoaded(
      volunteers: volunteers ?? this.volunteers,
      donors: donors ?? this.donors,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      allCampaigns: allCampaigns ?? this.allCampaigns,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
