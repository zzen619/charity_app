import 'package:go_router/go_router.dart';
import '../../features/auth/ui/screens/login_screen.dart';
import '../../features/auth/ui/screens/register_screen.dart';
import '../../features/donations/data/models/donation_model.dart';
import '../../features/donations/ui/screens/donation_details_screen.dart';
import '../../features/donations/ui/screens/donation_list_screen.dart';
import '../../features/donations/ui/screens/impact_screen.dart';
import '../../features/home/ui/screens/home_screen.dart';
import '../../features/notifications/ui/screens/notifications_screen.dart';
import '../../features/profile/ui/screens/profile_screen.dart';
import '../../main_navigation/main_navigation_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,

  routes: [
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),

    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationScreen(child: child);
      },
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.notifications,
          builder: (context, state) => const NotificationsScreen(),
        ),
        /*GoRoute(
          path: AppRoutes.requests,
          builder: (context, state) => const RequestsScreen(),
        ),*/
        GoRoute(
          path: AppRoutes.campaigns,
          builder: (context, state) => const ImpactScreen(),
        ),
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/donations_list',
          builder: (context, state) {
            final category = state.extra as DonationCategory;

            return DonationListScreen(category: category);
          },
        ),
        GoRoute(
          path: '/donation_details',
          builder: (context, state) {
            final donation = state.extra as DonationModel;
            return DonationDetailsScreen(donation: donation);
          },
        ),
      ],
    ),
  ],
);
