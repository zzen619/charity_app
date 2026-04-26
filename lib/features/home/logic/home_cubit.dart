import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/campaign_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<String> get categoriesKeys => [
    'categories.all',
    'categories.patients',
    'categories.education',
    'categories.environment',
    'categories.orphans',
  ];
  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final campaigns = CampaignModel.mockList;

      emit(
        HomeLoaded(
          volunteers: 12,
          donors: 176,
          beneficiaries: 495,
          campaigns: campaigns,
          selectedCategory: 'categories.all',
          filteredCampaigns: campaigns,
        ),
      );
    } catch (e) {
      emit(HomeError('Failed to load home data'));
    }
  }

  void filterBySearch(String query) {
    if (state is HomeLoaded) {
      final current = state as HomeLoaded;
      final filtered = query.isEmpty
          ? current.campaigns
          : current.campaigns
                .where(
                  (c) => c.title.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();

      emit(current.copyWith(filteredCampaigns: filtered));
    }
  }

  void filterByCategory(String category) {
    final current = state;
    if (current is HomeLoaded) {
      emit(current.copyWith(selectedCategory: category));
    }
  }

  Future<void> refresh() => loadHome();
}
