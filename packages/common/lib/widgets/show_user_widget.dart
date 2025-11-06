import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShowUserWidget extends HookConsumerWidget {
  const ShowUserWidget({
    super.key,
    this.mode,
    required this.user,
  });
  final CartMode? mode;
  final UserX user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toShow = useState<bool>(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () => toShow.value = !toShow.value,
          child: ColorBgIconHeader(
            label: 'User Details',
            icon: Icons.person,
            color: mode?.color ?? user.role?.color ?? appColors.sc.blues,
            trailing: Icon(
              toShow.value
                  ? Icons.expand_less_rounded
                  : Icons.expand_more_rounded,
              size: context.sizeOfWidth * 0.07,
              color: appColors.ms.textBlack50(context),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: context.sizeOfWidth * 0.074),
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 160),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SizeTransition(sizeFactor: animation, child: child);
              },
              child: !toShow.value
                  ? MetaRow(
                      label: 'Name :',
                      value: '${user.firstName} ${user.lastName}')
                  : Column(
                      children: [
                        MetaRow(
                            label: 'Name :',
                            value: '${user.firstName} ${user.lastName}'),
                        MetaRow(
                          label: 'Phone :',
                          onTap: () => Clipboard.setData(ClipboardData(
                                  text: user.phoneNumber.replaceAll('+91', '')))
                              .then(
                            (_) {
                              if (context.mounted) {
                                showMessageSnackbar(
                                    context: context,
                                    message: 'Phone number copied to clipboard',
                                    maxLines: 2);
                              }
                            },
                          ),
                          value: '${user.phoneNumber.phoneNoFormat}',
                          trailing: Icon(Icons.copy, size: 18),
                        ),
                        MetaRow(
                            label: 'Role :', value: user.role?.name ?? 'N/A'),
                      ],
                    )),
        ),
      ],
    );
  }
}
