import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/campaign_model.dart';
import 'campaign_card.dart';

class UrgentCampaignsList extends StatelessWidget {
  final List<CampaignModel> campaigns;
  final String selectedCategory;
  final VoidCallback? onViewAll;

  const UrgentCampaignsList({
    super.key,
    required this.campaigns,
    required this.selectedCategory,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.recentCampaigns,
                style: AppTextStyles.sectionTitle.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              GestureDetector(
                onTap: onViewAll,
                child: const Text(
                  AppStrings.viewAll,
                  style: AppTextStyles.viewAll,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 310,
          child: campaigns.isEmpty
              ? Center(
                  child: Text(
                    AppStrings.noResults,
                    style: TextStyle(
                      color: isDark
                          ? AppColors.darkTextSecond
                          : AppColors.lightTextSecond,
                    ),
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16),
                  itemCount: campaigns.length,
                  itemBuilder: (context, index) {
                    return CampaignCard(campaign: campaigns[index]);
                  },
                ),
        ),
      ],
    );
  }
}
