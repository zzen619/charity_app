import 'package:flutter_bloc/flutter_bloc.dart';
import '../state/my_request_state.dart';

class MyRequestCubit extends Cubit<MyRequestState> {
  MyRequestCubit() : super(MyRequestInitial());

  void getRequests() async {
    emit(MyRequestLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));

      final mockRequests = [
        {"type": "Withdrawal Request", "date": "2026-07-08", "status": "Approved"},
        {"type": "Profile Verification", "date": "2026-07-09", "status": "Under Review"},
      ];

      emit(MyRequestLoaded(mockRequests));
    } catch (e) {
      emit(MyRequestError("Failed to load requests"));
    }
  }
}