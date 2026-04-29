import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/donation_model.dart';
import '../data/repositories/donation_repository.dart';
import 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationCubit(this.repo) : super(DonationLoading());
  final DonationRepository repo;

  void loadDonations(DonationCategory category) async {
    emit(DonationLoading());

    try {
      final data = await repo.getDonations(category);
      emit(DonationLoaded(data));
    } catch (e) {
      emit(DonationError());
    }
  }
}
