import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/campaign_model.dart';
import '../../../core/constants/app_strings.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  // قائمة الكاتيغوري من AppStrings
  final List<String> categories = [
    AppStrings.catAll,
    AppStrings.catPatients,
    AppStrings.catEducation,
    AppStrings.catEnvironment,
    AppStrings.catOrphans,
  ];

  // ── تحميل البيانات
  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      // TODO: استبدل بـ API call حقيقي من HomeRepository
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

  // ── فلتر الكاتيغوري
  void filterByCategory(String category) {
    final current = state;
    if (current is HomeLoaded) {
      emit(current.copyWith(selectedCategory: category));
    }
  }

  // ── البحث
  void search(String query) {
    final current = state;
    if (current is HomeLoaded) {
      emit(current.copyWith(searchQuery: query));
    }
  }

  // ── إعادة تعيين الفلتر
  void resetFilter() {
    final current = state;
    if (current is HomeLoaded) {
      emit(
        current.copyWith(selectedCategory: AppStrings.catAll, searchQuery: ''),
      );
    }
  }

  // ── Refresh
  Future<void> refresh() => loadHome();
}
