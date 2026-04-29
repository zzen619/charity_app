import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/donation_model.dart';

class DonationDetailsScreen extends StatelessWidget {
  final DonationModel donation;

  const DonationDetailsScreen({super.key, required this.donation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(donation.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// الاسم
                Text(
                  donation.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                const SizedBox(height: 8),

                /// العنوان
                Text(
                  donation.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 16),

                /// 🔥 الوصف كامل
                Text(
                  donation.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 20),

                /// زر تبرع
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Donate Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
