abstract class MyRequestState {}

class MyRequestInitial extends MyRequestState {}

class MyRequestLoading extends MyRequestState {}

class MyRequestLoaded extends MyRequestState {
  final List<dynamic> requests;
  MyRequestLoaded(this.requests);
}

class MyRequestError extends MyRequestState {
  final String errorMessage;
  MyRequestError(this.errorMessage);
}