import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class AdminCard extends StatelessWidget {
  const AdminCard({
    super.key,
    required this.admin,
    required this.onSelected,
    required this.isSelected,
  });

  final UserX admin;
  final Function(DataBlock3) onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(
          DataBlock3(v1: admin.phoneNumber, v2: admin.lastName, v3: admin.uid)),
      child: Card(
        color: appColors.cS(context).onPrimaryFixedVariant,
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: BorderSide(
              color: isSelected
                  ? Colors.yellow.shade500
                  : appColors.ms.black60(context),
              width: 3,
            )),
        surfaceTintColor: appColors.ms.white(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircularImageAvatar(
                image: admin.avatar,
              ),
              Text(
                admin.lastName,
                style: TextStyles.h8Bold(context)
                    ?.copyWith(color: appColors.sc.mystic),
              )
            ],
          ),
        ),
      ),
    );
  }
}
