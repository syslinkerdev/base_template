import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';

class ProductStatusWidget extends StatelessWidget {
  const ProductStatusWidget({
    super.key,
    required this.productStatus,
  });

  final ProductStatus productStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: productStatus.color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            productStatus.icon,
            color: productStatus.color,
            size: 16,
          ),
          gapW2,
          Text(
            productStatus.label,
            style: TextStyles.h12Bold(context)?.copyWith(
              color: productStatus.color,
            ),
          ),
        ],
      ),
    );
  }
}
