import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants/app_theme/app_theme.dart';
import 'core/constants/app_theme/theme_cubit.dart';
import 'core/constants/app_theme/theme_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AtaaApp());
}

class AtaaApp extends StatelessWidget {
  const AtaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        //  BlocProvider(create: (_) => MainNavigationCubit()),
        //   BlocProvider(create: (_) => HomeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'ATAA',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState.mode, // ← هذا هو المفتاح
            home: const MainNavigationScreen(),
          );
        },
      ),
    );
  }
}
