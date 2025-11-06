import 'package:core/core.dart';
import 'package:flutter/material.dart';

class StatusShow extends StatelessWidget {
  const StatusShow({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
  });
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 14),
          gapW2,
          Text(
            label,
            style: TextStyles.h14Bold(context)?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
