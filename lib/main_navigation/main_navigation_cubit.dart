import 'package:flutter_bloc/flutter_bloc.dart';

part 'main_navigation_state.dart';

class MainNavigationCubit extends Cubit<MainNavigationState> {
  MainNavigationCubit() : super(const MainNavigationState());

  void changeTab(int index) {
    emit(MainNavigationState(currentIndex: index));
  }
}
