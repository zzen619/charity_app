import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Primary (ثابت في الوضعين)
  static const Color primary = Color(0xFF1A5C52);
  static const Color primaryLight = Color(0xFF1E6B5E);
  static const Color primaryDark = Color(0xFF0F3D35);
  static const Color accent = Color(0xFFF2C055);
  static const Color accentDark = Color(0xFFC8960C);

  // ── Light Mode
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightInputFill = Color(0xFFF0F0F0);
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecond = Color(0xFF6B6B6B);
  static const Color lightTextHint = Color(0xFFAAAAAA);
  static const Color lightBorder = Color(0xFFE0E0E0);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightStatCard = Color(0xFF1E6B5E);

  // ── Dark Mode
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkInputFill = Color(0xFF2A2A2A);
  static const Color darkTextPrimary = Color(0xFFF5F5F5);
  static const Color darkTextSecond = Color(0xFFAAAAAA);
  static const Color darkTextHint = Color(0xFF666666);
  static const Color darkBorder = Color(0xFF333333);
  static const Color darkCardBg = Color(0xFF1E1E1E);
  static const Color darkStatCard = Color(0xFF163D36);

  // ── Status (ثابت)
  static const Color success = Color(0xFF2E7D32);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF57C00);
}
