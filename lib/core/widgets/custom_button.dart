import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum ButtonVariant { filled, outlined }

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  

  // ✨ أضفناهم
  final Color? backgroundColor;
  final Color? textColor;
  final double height;

  const CustomButton({
    super.key,
    required this.label,
    this.onTap,
    this.variant = ButtonVariant.filled,
    this.icon,
    this.isLoading = false,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.height = 48, // 👈 default height
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = variant == ButtonVariant.filled;

    final bg =Color(0xFF1E6B5E);
  

    final fgColor =
        textColor ??
        (isFilled
            ? AppColors.lightTextHint
            : Theme.of(context).colorScheme.primary);

    final border = isFilled
        ? null
        : Border.all(color: Theme.of(context).colorScheme.primary, width: 1.5);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: AnimatedOpacity(
        opacity: onTap == null ? 0.5 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: width ?? double.infinity,
          height: height, // 👈 مهم
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(50),
            border: border,
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: fgColor,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: fgColor, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        label,
                        style: TextStyle(
                          color: fgColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
