abstract class MyImpactState {}

class MyImpactInitial extends MyImpactState {}

class MyImpactLoading extends MyImpactState {}

class MyImpactLoaded extends MyImpactState {
  final List<dynamic> impacts;
  MyImpactLoaded(this.impacts);
}

class MyImpactError extends MyImpactState {
  final String errorMessage;
  MyImpactError(this.errorMessage);
}