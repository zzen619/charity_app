import 'package:charity_app/core/constants/app_theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(ThemeMode.light)) {
    _loadSaved();
  }

  static const _key = 'theme_mode';

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved == 'dark') {
      emit(const ThemeState(ThemeMode.dark));
    } else {
      emit(const ThemeState(ThemeMode.light));
    }
  }

  Future<void> toggle() async {
    final isDark = state.mode == ThemeMode.dark;
    final next = isDark ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeState(next));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, isDark ? 'light' : 'dark');
  }

  bool get isDark => state.mode == ThemeMode.dark;
}
