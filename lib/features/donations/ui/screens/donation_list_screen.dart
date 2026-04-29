import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/donation_model.dart';
import '../../data/repositories/donation_repository.dart';
import '../../logic/donation_cubit.dart';
import '../../logic/donation_state.dart';
import '../widgets/donation_card.dart';

class DonationListScreen extends StatelessWidget {
  const DonationListScreen({super.key, required this.category});

  final DonationCategory category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          DonationCubit(DonationRepository())..loadDonations(category),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary, // لون الخلفية
          elevation: 4,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            onPressed: () {
              context.pop();
            },
          ),
          title: Text(category.titleKey.tr()),
          centerTitle: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: BlocBuilder<DonationCubit, DonationState>(
          builder: (context, state) {
            if (state is DonationLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DonationLoaded) {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return DonationCard(donation: state.items[index]);
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
