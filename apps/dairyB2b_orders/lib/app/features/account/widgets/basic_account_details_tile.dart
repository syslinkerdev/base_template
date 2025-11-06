import 'package:flutter/material.dart';
import 'package:core/core.dart';

class BasicAccountDetailsTile extends StatelessWidget {
  final String fullName;
  final String phoneNumber;
  final void Function()? editProfileOnPress;
  const BasicAccountDetailsTile({
    super.key,
    required this.fullName,
    required this.phoneNumber,
    required this.editProfileOnPress,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(fullName, style: TextStyles.h6Bold(context)),
              IconButton(
                onPressed: editProfileOnPress,
                icon: Icon(Icons.edit,
                    color: appColors.ms.whiteSwNero(context), size: 20),
                style: IconButton.styleFrom(
                    backgroundColor:
                        appColors.cS(context).primary.withAlpha(220),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                tooltip: 'Edit Profile',
              )
            ],
          ),
          Text(phoneNumber, style: TextStyles.h10Gray(context)),
        ],
      ),
    );
  }
}
