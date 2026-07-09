import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/my_activity_state.dart';

class MyActivityCubit extends Cubit<MyActivityState> {
  MyActivityCubit() : super(MyActivityInitial());

  void getActivities() async {
    emit(MyActivityLoading());
    try {
      // محاكاة جلب بيانات من السيرفر (تأخير ثانيتين)
      await Future.delayed(const Duration(seconds: 2));

      // بيانات تجريبية (بدلها لاحقاً بجلب حقيقي من الـ Repository)
      final mockActivities = [
        {"title": "Planted a Tree", "date": "2026-07-01", "status": "Completed"},
        {"title": "Blood Donation", "date": "2026-07-05", "status": "Pending"},
      ];

      emit(MyActivityLoaded(mockActivities));
    } catch (e) {
      emit(MyActivityError("Failed to load activities: ${e.toString()}"));
    }
  }
}