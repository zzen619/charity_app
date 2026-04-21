import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/campaign_model.dart';
import '../../../core/constants/app_strings.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final List<String> categories = [
    AppStrings.catAll,
    AppStrings.catPatients,
    AppStrings.catEducation,
    AppStrings.catEnvironment,
    AppStrings.catOrphans,
  ];

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      emit(
        HomeLoaded(
          volunteers: 12,
          donors: 176,
          beneficiaries: 495,
          allCampaigns: CampaignModel.mockList,
        ),
      );
    } catch (e) {
      emit(HomeError(AppStrings.errorLoad));
    }
  }

  void filterByCategory(String category) {
    final current = state;
    if (current is HomeLoaded) {
      emit(current.copyWith(selectedCategory: category));
    }
  }

  void search(String query) {
    final current = state;
    if (current is HomeLoaded) {
      emit(current.copyWith(searchQuery: query));
    }
  }

  Future<void> refresh() => loadHome();
}
