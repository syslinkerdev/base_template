import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';

class AvatarCard extends StatelessWidget {
  const AvatarCard({
    super.key,
    required this.avatar,
    required this.onSelected,
    required this.isSelected,
  });

  final Avatar avatar;
  final Function(Avatar) onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelected(Avatar(id: avatar.id, image: avatar.image)),
      child: Card(
        color: appColors.cS(context).onPrimaryFixedVariant,
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
            child: FadeInImageX(imagePath: avatar.image, aniImage: true)),
      ),
    );
  }
}
