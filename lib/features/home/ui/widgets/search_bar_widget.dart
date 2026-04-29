import 'package:flutter/material.dart';

import '../../../../core/constants/app_theme_extensions.dart';

class AppSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  const AppSearchBar({super.key, this.onChanged, required this.hintText});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final ext = Theme.of(context).extension<AppThemeExtension>()!;
    return Container(
      decoration: BoxDecoration(
        color: ext.inputFill,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [],
      ),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: cs.onSurface),

        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
