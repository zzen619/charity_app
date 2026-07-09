import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/my_impact_state.dart';

class MyImpactCubit extends Cubit<MyImpactState> {
  MyImpactCubit() : super(MyImpactInitial());

  void getImpactData() async {
    emit(MyImpactLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      final mockImpacts = [
        {"title": "Clean Water Project", "amount": "\$100", "date": "2026-06-15"},
        {"title": "Food Basket", "amount": "\$50", "date": "2026-06-20"},
      ];

      emit(MyImpactLoaded(mockImpacts));
    } catch (e) {
      emit(MyImpactError("Failed to load impact data"));
    }
  }
}