import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:core/widgets/pin_put_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/providers/user_actions.dart';

class AccessCodeWidget extends StatelessWidget {
  const AccessCodeWidget({super.key, required this.user, required this.ref});

  final UserX user;
  final WidgetRef ref;
 
  @override
  Widget build(BuildContext context) {
    final currentUserUid = ref.watch(appStateXProvider).uId;
    final userActions = ref.watch(userActionsProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            userActions.isLoading ? 'Loading. . .' : 'Access Code',
            style: TextStyles.h10Bold(context),
          ),
          PinPutShow(
            obscureText: true,
            pinInputHeight: 30,
            pinInputWidth: 30,
            lastIcon: Icons.message,
            lastIconSize: 20,
            controller: TextEditingController(text: user.accessCode),
            onLastIconTap: () async {
              await ref
                  .read(userActionsProvider.notifier)
                  .updateIsGivenForAccessCode(userUid: user.uid);
              if (user.superuserUid == currentUserUid) {
                WhatsAppButton.openWhatsapp(
                    context: context, phoneNumber: user.phoneNumber, message: """
                Your secure access code is ${user.accessCode}. 
                Use it for account actions. 
                It will expire soon.
                """);
              } else {
                showMessageSnackbar(
                    context: context,
                    message:
                        "You\'re not allowed to share this client\'s access code.",
                    maxLines: 2,
                    type: SnackBarType.warning);
              }
            },
          ),
        ],
      ),
    );
  }
}
