import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_theme/app_theme.dart';
import 'core/constants/app_theme/theme_cubit.dart';
import 'core/constants/app_theme/theme_state.dart';
import 'features/home/logic/home_cubit.dart';
import 'main_navigation/main_navigation_cubit.dart';
import 'main_navigation/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // تحميل الثيم المحفوظ قبل تشغيل التطبيق
  final prefs = await SharedPreferences.getInstance();
  final savedTheme = prefs.getString('theme_mode');
  final initialMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', // مجلد ملفات الترجمة
      fallbackLocale: const Locale('en'),
      child: AtaaApp(initialThemeMode: initialMode),
    ),
  );
}

class AtaaApp extends StatelessWidget {
  final ThemeMode initialThemeMode;
  const AtaaApp({super.key, required this.initialThemeMode});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit(initialMode: initialThemeMode)),
        BlocProvider(create: (_) => MainNavigationCubit()),
        BlocProvider(create: (_) => HomeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'ATAA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState?.mode,

            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,

            home: const MainNavigationScreen(),
          );
        },
      ),
    );
  }
}
