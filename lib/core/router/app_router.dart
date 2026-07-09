import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Auth
import '../../features/auth/logic/login_cubit.dart';
import '../../features/auth/ui/screens/login_screen.dart';

// Home
import '../../features/home/ui/screens/home_screen.dart';

// Profile & Cubits
import '../../features/profile/ui/screens/profile_screen.dart';
import '../../features/profile/ui/screens/edit_profile_screen.dart';
import '../../features/profile/ui/screens/my_activity_screen.dart';
import '../../features/profile/ui/screens/my_impact_screen.dart';
import '../../features/profile/ui/screens/my_request_screen.dart';

import '../../features/profile/logic/cubit/profile_cubit.dart';
import '../../features/profile/logic/cubit/my_activity_cubit.dart';
import '../../features/profile/logic/cubit/my_impact_cubit.dart';
import '../../features/profile/logic/cubit/my_request_cubit.dart';

// Notifications & Donations
import '../../features/notifications/ui/screens/notifications_screen.dart';
import '../../features/donations/ui/screens/impact_screen.dart';

import '../../main_navigation/main_navigation_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.profile,

  routes: [

    /// 🔐 LOGIN
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (_) => LoginCubit(),
        child: const LoginScreen(),
      ),
    ),

    /// 🧭 MAIN NAVIGATION (ShellRoute)
    ShellRoute(
      builder: (context, state, child) {
        return MainNavigationScreen(child: child);
      },
      routes: [

        /// 🏠 HOME
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),

        /// 👤 PROFILE & SUB-ROUTES
        GoRoute(
          path: AppRoutes.profile,
          builder: (context, state) => BlocProvider(
            create: (_) => ProfileCubit()..getProfile(),
            child: const ProfileScreen(),
          ),
          routes: [
            /// 🏃‍♂️ MY ACTIVITIES
            GoRoute(
              path: AppRoutes.myActivities,
              builder: (context, state) => BlocProvider(
                create: (_) => MyActivityCubit()..getActivities(),
                child: const MyActivityScreen(),
              ),
            ),

            /// 💖 MY DONATIONS / IMPACT
            GoRoute(
              path: AppRoutes.myImpact,
              builder: (context, state) => BlocProvider(
                create: (_) => MyImpactCubit()..getImpactData(),
                child: const MyImpactScreen(),
              ),
            ),

            /// ✏️ EDIT PROFILE
            GoRoute(
              path: AppRoutes.editProfile,
              builder: (context, state) {
                final extra = state.extra as Map<String, dynamic>?;
                return EditProfileScreen(
                  initialName: extra?['name'] as String?,
                  initialImage: extra?['image'] as String?,
                );
              },
            ),

            /// 📝 MY REQUESTS
            GoRoute(
              path: AppRoutes.myRequests,
              builder: (context, state) => BlocProvider(
                create: (_) => MyRequestCubit()..getRequests(),
                child: const MyRequestScreen(),
              ),
            ),
          ],
        ),

        /// 🔔 NOTIFICATIONS
        GoRoute(
          path: AppRoutes.notifications,
          builder: (context, state) => const NotificationsScreen(),
        ),

        /// 📊 IMPACT
        GoRoute(
          path: AppRoutes.campaigns,
          builder: (context, state) => const ImpactScreen(),
        ),
      ],
    ),
  ],
);