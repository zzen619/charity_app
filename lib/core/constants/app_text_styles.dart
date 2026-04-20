import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ── Header
  static const TextStyle welcomeLabel = TextStyle(
    color: Colors.white70,
    fontSize: 11,
    letterSpacing: 1,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle userName = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static const TextStyle statLabel = TextStyle(
    color: Colors.white60,
    fontSize: 10,
    letterSpacing: 0.5,
  );

  static const TextStyle statValue = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.w800,
  );

  // ── Body
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle viewAll = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle cardCategory = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  static const TextStyle progressLabel = TextStyle(
    fontSize: 12,
    color: Color(0xFF9E9E9E),
  );

  static const TextStyle progressValue = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.accentDark,
  );

  static const TextStyle goalLabel = TextStyle(
    fontSize: 10,
    color: Color(0xFF9E9E9E),
  );

  static const TextStyle goalValue = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.lightTextPrimary,
  );

  static const TextStyle donateBtn = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w800,
    color: Colors.black87,
  );

  static const TextStyle quickDonateBtn = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  static const TextStyle categoryChipSelected = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const TextStyle categoryChipUnselected = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color(0xFF9E9E9E),
  );

  static const TextStyle watermark = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: 4,
    color: Color(0xFFDDDDDD),
  );
}
