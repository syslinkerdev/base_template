import 'package:flutter/material.dart';
import 'package:core/core.dart';

class SinceTile extends StatelessWidget {
  final DateTime createdDate;

  const SinceTile({
    super.key,
    required this.createdDate,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppEnv.companyName} Member Since',
            style: TextStyles.h8Bold(context),
          ),
          gapH8,
          Text(
            DateFormatUtil.moreFriendlyFormat(createdDate),
            style: TextStyles.h7Gray(context),
          ),
        ],
      ),
    );
  }
}
