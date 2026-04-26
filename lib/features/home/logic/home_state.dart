import '../data/models/campaign_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

class HomeLoaded extends HomeState {
  final int volunteers;
  final int donors;
  final int beneficiaries;
  final List<CampaignModel> campaigns;
  final String selectedCategory;

  HomeLoaded({
    required this.volunteers,
    required this.donors,
    required this.beneficiaries,
    required this.campaigns,
    this.selectedCategory = 'All',
    required List<CampaignModel> filteredCampaigns,
  });

  List<CampaignModel> get filteredCampaigns {
    if (selectedCategory == 'All') return campaigns;
    return campaigns.where((c) => c.category == selectedCategory).toList();
  }

  HomeLoaded copyWith({
    int? volunteers,
    int? donors,
    int? beneficiaries,
    List<CampaignModel>? campaigns,
    List<CampaignModel>? filteredCampaigns,
    String? selectedCategory,
  }) {
    return HomeLoaded(
      volunteers: volunteers ?? this.volunteers,
      donors: donors ?? this.donors,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      campaigns: campaigns ?? this.campaigns,
      filteredCampaigns: filteredCampaigns ?? this.filteredCampaigns,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
