abstract class MyActivityState {}

class MyActivityInitial extends MyActivityState {}

class MyActivityLoading extends MyActivityState {}

class MyActivityLoaded extends MyActivityState {
  // هون بنمرر قائمة البيانات اللي انجلبت عشان نعرضها بالـ UI
  final List<dynamic> activities;
  MyActivityLoaded(this.activities);
}

class MyActivityError extends MyActivityState {
  final String errorMessage;
  MyActivityError(this.errorMessage);
}