import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AvatarsList extends HookConsumerWidget {
  const AvatarsList({
    super.key,
    this.titleAlignment = Alignment.topLeft,
    this.title,
    this.titleStyle,
    this.action,
    this.onChange,
    this.initialAvatarImage,
    this.size = MainAxisSize.max,
    this.isDialog = false,
  });

  final String? title;
  final AlignmentGeometry titleAlignment;
  final TextStyle? titleStyle;
  final List<Widget>? Function(Avatar)? action;
  final Function(Avatar avatar)? onChange;
  final MainAxisSize size;
  final String? initialAvatarImage;
  final bool isDialog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAvatar = useState<Avatar>(Avatar.empty());
    final avatars = ref.watch(fetchAvatarsListProvider);
    final TextStyle? textStyle = titleStyle ??
        TextStyles.h3(context)?.copyWith(
          color: appColors.ms.black60(context),
          fontStyle: FontStyle.italic,
        );

    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: avatars.when(
        skipLoadingOnRefresh: false,
        data: (data) {
          // Set the initial avatar if it's provided
          if (initialAvatarImage != null &&
              selectedAvatar.value == Avatar.empty()) {
            final initialAvatar = data.firstWhere(
              (avatar) => avatar.image == initialAvatarImage,
              orElse: () => Avatar.empty(),
            );
            selectedAvatar.value = initialAvatar;
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
            child: Column(
              mainAxisSize: size,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null) ...[
                  Align(
                    alignment: titleAlignment,
                    child: Text(title!, style: textStyle),
                  ),
                ],
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: context.sizeOfWidth * 0.03,
                    mainAxisSpacing: context.sizeOfHeight * 0.02,
                  ),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final avatar = data[index];
                    return AvatarCard(
                      avatar: avatar,
                      isSelected: selectedAvatar.value.id == avatar.id,
                      onSelected: (Avatar avatarX) {
                        selectedAvatar.value = avatarX;
                        if (onChange != null) {
                          onChange!(avatarX);
                        }
                      },
                    );
                  },
                ),
                if (action != null) ...?action!(selectedAvatar.value),
              ],
            ),
          );
        },
        loading: () => isDialog
            ? const LoadingScreen(isDialog: true)
            : const LoadingScreen(),
        error: (error, stackTrace) => isDialog
            ? ErrorScreen(
                error: error,
                onRetry: () => _refresh(ref),
                isDialog: true,
              )
            : ErrorScreen(error: error, onRetry: () => _refresh(ref)),
      ),
    );
  }

  static Future<void> _refresh(WidgetRef ref) =>
      ref.refresh(fetchAvatarsListProvider.future);

  static Future<void> showDialog(
    BuildContext context, {
    String? title,
    AlignmentGeometry titleAlignment = Alignment.topCenter,
    TextStyle? titleStyle,
    String? initialAvatarImage,
    List<Widget>? Function(Avatar)? action,
    Function(Avatar)? onChange,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (context, _, __) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: AvatarsList(
            title: title,
            titleAlignment: titleAlignment,
            titleStyle: titleStyle,
            initialAvatarImage: initialAvatarImage,
            size: MainAxisSize.min,
            isDialog: true,
            action: action,
            onChange: (p0) {
              context.exit();
              if (onChange != null) {
                onChange(p0);
              }
            },
          ),
        );
      },
    );
  }

  // example of dialog
  // AvatarsList.showDialog(
  //                 context,
  //                 title: 'Avatars',
  //                 onChange: (p0) {
  //                   //print(p0);
  //                 },
  //                 initialAvatarImage: avatar.image,
  //               );
}
