import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color cardBackground;
  final Color inputFill;
  final Color border;
  final Color textSecondary;
  final Color textHint;
  final Color progressBg;
  final Color progressFill;

  const AppThemeExtension({
    required this.cardBackground,
    required this.inputFill,
    required this.border,
    required this.textSecondary,
    required this.textHint,
    required this.progressBg,
    required this.progressFill,
  });

  @override
  AppThemeExtension copyWith({
    Color? cardBackground,
    Color? inputFill,
    Color? border,
    Color? textSecondary,
    Color? textHint,
    Color? progressBg,
    Color? progressFill,
  }) {
    return AppThemeExtension(
      cardBackground: cardBackground ?? this.cardBackground,
      inputFill: inputFill ?? this.inputFill,
      border: border ?? this.border,
      textSecondary: textSecondary ?? this.textSecondary,
      textHint: textHint ?? this.textHint,
      progressBg: progressBg ?? this.progressBg,
      progressFill: progressFill ?? this.progressFill,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;

    return AppThemeExtension(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      border: Color.lerp(border, other.border, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textHint: Color.lerp(textHint, other.textHint, t)!,
      progressBg: Color.lerp(progressBg, other.progressBg, t)!,
      progressFill: Color.lerp(progressFill, other.progressFill, t)!,
    );
  }
}
