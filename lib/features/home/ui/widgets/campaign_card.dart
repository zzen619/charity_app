import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/campaign_model.dart';

class CampaignCard extends StatelessWidget {
  final CampaignModel campaign;
  final VoidCallback? onDonateTap;

  const CampaignCard({super.key, required this.campaign, this.onDonateTap});

  String _formatAmount(double amount) {
    return '\$${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkCardBg : AppColors.lightCardBg;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image + Category Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  campaign.imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 150,
                    color: isDark
                        ? AppColors.darkInputFill
                        : AppColors.lightInputFill,
                    child: Icon(
                      Icons.image_outlined,
                      color: isDark
                          ? AppColors.darkTextHint
                          : AppColors.lightTextHint,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    campaign.category.toUpperCase(),
                    style: AppTextStyles.cardCategory,
                  ),
                ),
              ),
            ],
          ),

          // ── Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  campaign.title,
                  style: AppTextStyles.cardTitle.copyWith(color: textColor),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                // Progress label row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.progress,
                      style: AppTextStyles.progressLabel.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecond
                            : const Color(0xFF9E9E9E),
                      ),
                    ),
                    Text(
                      '${(campaign.progress * 100).toInt()}%',
                      style: AppTextStyles.progressValue,
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: campaign.progress,
                    backgroundColor: isDark
                        ? AppColors.darkBorder
                        : AppColors.progressBg,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.progressFill,
                    ),
                    minHeight: 6,
                  ),
                ),

                const SizedBox(height: 12),

                // Goal + Donate Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.goal,
                          style: AppTextStyles.goalLabel.copyWith(
                            color: isDark
                                ? AppColors.darkTextHint
                                : const Color(0xFF9E9E9E),
                          ),
                        ),
                        Text(
                          _formatAmount(campaign.goal),
                          style: AppTextStyles.goalValue.copyWith(
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: onDonateTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          AppStrings.donateNow,
                          style: AppTextStyles.donateBtn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
