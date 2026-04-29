import '../data/models/donation_model.dart';

abstract class DonationState {}

class DonationLoading extends DonationState {}

class DonationLoaded extends DonationState {
  final List<DonationModel> items;

  DonationLoaded(this.items);
}

class DonationError extends DonationState {}
