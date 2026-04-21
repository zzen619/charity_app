import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';
import '../widgets/quick_donate_button.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/urgent_campaigns_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }
          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => context.read<HomeCubit>().loadHome(),
                    child: const Text(AppStrings.retryBtn),
                  ),
                ],
              ),
            );
          }
          if (state is HomeLoaded) {
            return _buildBody(context, state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeLoaded state) {
    final cubit = context.read<HomeCubit>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomScrollView(
      slivers: [
        // ── Teal Header
        SliverToBoxAdapter(
          child: Container(
            color: AppColors.primary,
            child: Column(
              children: [
                const SizedBox(height: 52),

                // Top bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.network(
                            'https://i.pravatar.cc/150?img=3',
                            fit: BoxFit.cover,
                            width: 52,
                            height: 52,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.person,
                              color: AppColors.primary,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.welcomeBack,
                            style: AppTextStyles.welcomeLabel,
                          ),
                          Text(
                            AppStrings.userName,
                            style: AppTextStyles.userName,
                          ),
                        ],
                      ),
                      const Spacer(),
                      Builder(
                        builder: (ctx) => IconButton(
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () => Scaffold.of(ctx).openDrawer(),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Stats
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _StatCard(
                        label: AppStrings.volunteers,
                        value: '${state.volunteers}',
                      ),
                      const SizedBox(width: 10),
                      _StatCard(
                        label: AppStrings.donors,
                        value: '${state.donors}',
                      ),
                      const SizedBox(width: 10),
                      _StatCard(
                        label: AppStrings.beneficiaries,
                        value: '${state.beneficiaries}',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),
              ],
            ),
          ),
        ),

        // ── Body
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                SearchBarWidget(onChanged: cubit.search),

                const SizedBox(height: 16),

                _CategoryFilter(
                  categories: cubit.categories,
                  selected: state.selectedCategory,
                  onSelect: cubit.filterByCategory,
                  isDark: isDark,
                ),

                const SizedBox(height: 20),

                // Watermark
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.handshake_outlined,
                        color: isDark
                            ? Colors.white12
                            : const Color(0xFFDDDDDD),
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.appName,
                        style: AppTextStyles.watermark.copyWith(
                          color: isDark
                              ? Colors.white12
                              : const Color(0xFFDDDDDD),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                QuickDonateButton(onTap: () {}),

                const SizedBox(height: 12),

                _DonationCategoriesButton(onTap: () {}),

                const SizedBox(height: 24),

                // ✅ filteredCampaigns وليس campaigns
                UrgentCampaignsList(
                  campaigns: state.filteredCampaigns,
                  selectedCategory: state.selectedCategory,
                  onViewAll: () {},
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Stat Card
class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.statLabel),
            const SizedBox(height: 4),
            Text(value, style: AppTextStyles.statValue),
          ],
        ),
      ),
    );
  }
}

// ── Category Filter
class _CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final ValueChanged<String> onSelect;
  final bool isDark;

  const _CategoryFilter({
    required this.categories,
    required this.selected,
    required this.onSelect,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final cat = categories[i];
          final isSelected = cat == selected;

          return GestureDetector(
            onTap: () => onSelect(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : (isDark ? AppColors.darkSurface : Colors.white),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ),
              ),
              child: Text(
                cat,
                style: isSelected
                    ? AppTextStyles.categoryChipSelected
                    : AppTextStyles.categoryChipUnselected.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecond
                            : AppColors.lightTextSecond,
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Donation Categories Button
class _DonationCategoriesButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _DonationCategoriesButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.primary, width: 1.5),
          ),
          child: const Center(
            child: Text(
              AppStrings.donationCategories,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
