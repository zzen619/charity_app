import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../core/constants/app_theme/theme_cubit.dart';
import '../core/constants/app_theme/theme_state.dart';
import '../features/home/ui/screens/home_screen.dart';
import 'main_navigation_cubit.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    Placeholder(), // NotificationsScreen()
    Placeholder(), // RequestsHubScreen()
    Placeholder(), // DonationsScreen()
    Placeholder(), // ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      builder: (context, navState) {
        return Scaffold(
          drawer: _AppDrawer(),
          body: IndexedStack(index: navState.currentIndex, children: _screens),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: Navigate to submit request screen
            },
            backgroundColor: AppColors.accent,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.add, color: Colors.black87, size: 28),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: _BottomNavBar(
            currentIndex: navState.currentIndex,
            onTap: context.read<MainNavigationCubit>().changeTab,
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════
//  Bottom Nav Bar
// ══════════════════════════════════════
class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      elevation: 12,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              label: 'HOME',
              index: 0,
              current: currentIndex,
              onTap: onTap,
            ),
            _NavItem(
              icon: Icons.notifications_rounded,
              label: 'ALERTS',
              index: 1,
              current: currentIndex,
              onTap: onTap,
            ),
            const SizedBox(width: 48),
            _NavItem(
              icon: Icons.volunteer_activism_rounded,
              label: 'IMPACT',
              index: 3,
              current: currentIndex,
              onTap: onTap,
            ),
            _NavItem(
              icon: Icons.person_rounded,
              label: 'PROFILE',
              index: 4,
              current: currentIndex,
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isActive = index == current;
    final color = isActive ? cs.primary : cs.onSurface.withOpacity(0.35);

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isActive ? cs.primary.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════
//  App Drawer
// ══════════════════════════════════════
class _AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 36),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Marwa Alsaour',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'marwa@email.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Menu Items
            _DrawerItem(
              icon: Icons.home_rounded,
              label: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _DrawerItem(
              icon: Icons.info_outline_rounded,
              label: 'About ATAA',
              onTap: () {},
            ),
            _DrawerItem(
              icon: Icons.contact_support_outlined,
              label: 'Contact Us',
              onTap: () {},
            ),
            _DrawerItem(
              icon: Icons.privacy_tip_outlined,
              label: 'Privacy Policy',
              onTap: () {},
            ),

            const Divider(indent: 16, endIndent: 16),

            // Theme Toggle
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                final isDarkMode = themeState.mode == ThemeMode.dark;
                return SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  secondary: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      isDarkMode
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      key: ValueKey(isDarkMode),
                      color: cs.primary,
                    ),
                  ),
                  title: Text(
                    isDarkMode ? 'Light Mode' : 'Dark Mode',
                    style: TextStyle(
                      color: cs.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  value: isDarkMode,
                  activeColor: AppColors.accent,
                  onChanged: (_) => context.read<ThemeCubit>().toggle(),
                );
              },
            ),

            // Language Toggle
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              leading: Icon(Icons.language_rounded, color: cs.primary),
              title: Text(
                'Language',
                style: TextStyle(
                  color: cs.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
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
                  'EN',
                  style: TextStyle(
                    color: cs.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              onTap: () {
                // TODO: implement locale cubit
              },
            ),

            const Spacer(),

            // Logout
            Padding(
              padding: const EdgeInsets.all(16),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: cs.error.withOpacity(0.3)),
                ),
                leading: Icon(Icons.logout_rounded, color: cs.error),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: cs.error,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
  final String label;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: cs.primary, size: 22),
      title: Text(
        label,
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
