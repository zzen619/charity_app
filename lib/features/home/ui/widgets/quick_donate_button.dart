import 'package:flutter/material.dart';

class QuickDonateButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;

  const QuickDonateButton({super.key, this.onTap, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: cs.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.electric_bolt, color: cs.onSecondary, size: 22),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: cs.onSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
