import 'package:charity_app/core/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_theme/theme_cubit.dart';
import '../../../../core/constants/app_theme/theme_state.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../logic/home_cubit.dart';
import '../../logic/home_state.dart';

import '../widgets/campaign_card.dart';
import '../widgets/category_tabs.dart';
import '../widgets/quick_donate_button.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/stats_card.dart';

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
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      drawerScrimColor: Colors.black.withOpacity(0.6),
      backgroundColor: cs.background,
      drawer: const AppDrawer(),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return Center(child: CircularProgressIndicator(color: cs.primary));
          }

          if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: cs.error, size: 48),
                  const SizedBox(height: 12),
                  Text(state.message, style: TextStyle(color: cs.onSurface)),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => context.read<HomeCubit>().loadHome(),
                    child: const Text('Retry'),
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
    final cs = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHeader(context, state)),

        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(color: cs.surface),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: AppSearchBar(
                    hintText: 'search_hint'.tr(),
                    onChanged: (query) =>
                        context.read<HomeCubit>().filterBySearch(query),
                  ),
                ),

                const SizedBox(height: 16),

                // 📂 Categories
                CategoryTabs(
                  categories: context
                      .read<HomeCubit>()
                      .categoriesKeys
                      .map((e) => e.tr())
                      .toList(),
                  selected: state.selectedCategory.tr(),
                  onSelect: context.read<HomeCubit>().filterByCategory,
                ),

                const SizedBox(height: 20),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.handshake_outlined,
                        color: Colors.black12,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'ATAA',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 4,
                          color: Colors.black12,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ⚡ Quick donate
                QuickDonateButton(onTap: () {}, label: 'quick_donate'.tr()),

                const SizedBox(height: 24),

                // 📌 Title row
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'recent_campaigns'.tr(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface,
                        ),
                      ),
                      Text(
                        'view_all'.tr(),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // 🏷 Campaigns
                SizedBox(
                  height: 310,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 16),
                    itemCount: state.filteredCampaigns.length,
                    itemBuilder: (context, i) {
                      final campaign = state.filteredCampaigns[i];

                      return CampaignCard(
                        title: campaign.title,
                        category: campaign.category,
                        image: campaign.imageUrl,
                        progress: campaign.progress,
                        progressPercent: campaign.progressPercent,
                        goal: campaign.formattedGoal,
                        onDonateTap: () {},
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, HomeLoaded state) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
      ),

      child: Column(
        children: [
          const SizedBox(height: 52),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Colors.blue),
                ),
                const SizedBox(width: 12),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'welcome_back'.tr(),
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 11,
                      ),
                    ),
                    const Text(
                      'Ahmed Zain El Din',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Builder(
                  builder: (ctx) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () => Scaffold.of(ctx).openDrawer(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                StatsCard(
                  label: 'volunteers'.tr(),
                  value: '${state.volunteers}',
                ),
                const SizedBox(width: 10),
                StatsCard(label: 'donors'.tr(), value: '${state.donors}'),
                const SizedBox(width: 10),
                StatsCard(
                  label: 'beneficiaries'.tr(),
                  value: '${state.beneficiaries}',
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),
        ],
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: SafeArea(
        child: Column(
          children: [
            // 🔷 Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
              color: AppColors.primary,
              child: Text(
                'app_name'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 📂 Menu Items
            _DrawerItem(
              icon: Icons.verified_user_outlined,
              title: 'transparency_file'.tr(),
              onTap: () {},
            ),

            const Divider(height: 1),

            _DrawerItem(
              icon: Icons.info_outline,
              title: 'about_association'.tr(),
              onTap: () {},
            ),

            const Divider(height: 1),

            _DrawerItem(
              icon: Icons.contact_mail_outlined,
              title: 'contact_us'.tr(),
              onTap: () {},
            ),

            const Divider(height: 1),

            const SizedBox(height: 8),

            // 🌙 Theme Toggle
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                final isDarkMode = state.mode == ThemeMode.dark;

                return SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  secondary: Icon(
                    isDarkMode
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded,
                    color: cs.primary,
                  ),
                  title: Text(
                    'dark_mode'.tr(),
                    style: TextStyle(color: cs.onSurface),
                  ),
                  value: isDarkMode,
                  activeColor: AppColors.accent,
                  onChanged: (_) => context.read<ThemeCubit>().toggle(),
                );
              },
            ),

            const Divider(height: 1),

            // 🌐 Language Switch
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.language, color: cs.primary),
              title: Text(
                'language'.tr(),
                style: TextStyle(color: cs.onSurface),
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  context.locale.languageCode.toUpperCase(),
                  style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              onTap: () {
                final current = context.locale.languageCode;
                if (current == 'ar') {
                  context.setLocale(const Locale('en'));
                } else {
                  context.setLocale(const Locale('ar'));
                }
              },
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                label: 'volunteer_with_us'.tr(),
                icon: Icons.volunteer_activism,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: cs.primary),
      title: Text(
        title,
        style: TextStyle(
          color: cs.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}
