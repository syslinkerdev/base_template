import 'package:auth/src/delete_account/providers/delete_account_provider.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:system_assets/app_images.dart';

class SoftDeleteArgs {
  final UserX user;
  final void Function(WidgetRef ref) afterSoftDeleteProcess;
  SoftDeleteArgs({required this.user, required this.afterSoftDeleteProcess});
}

class SoftDelete extends HookConsumerWidget {
  const SoftDelete(
      {super.key, required this.user, required this.afterSoftDeleteProcess});
  final UserX user;
  final void Function(WidgetRef ref) afterSoftDeleteProcess;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteAccountProRead = ref.read(deleteAccountXProvider.notifier);

    // 🟡 Run soft delete automatically
    useEffect(() {
      Future.microtask(() async {
        await deleteAccountProRead.softDeleteUser(
          user: user,
          phoneNumber: user.phoneNumber,
          afterSoftDeleteProcess: () {
            //print('codeSent -----useEffect ');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                showMessageSnackbar(
                  context: context,
                  message: 'Account deleted successfully!',
                  type: SnackBarType.success,
                  duration: const Duration(seconds: 2),
                );
                afterSoftDeleteProcess(ref);
              }
            });
          },
        );
      });
      return null;
    }, []);

    return ErrorListenerWidget(
      provider: deleteAccountXProvider,
      child: ScaffoldX(
        appToolbarHeight: 0,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
          child: SpacedColumn(
            defaultHeight: 16,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Backing up securely...',
                  style: TextStyles.h6Bold(context),
                ),
              ),
              Spacer(),
              sysImages.processing
                  .toWidget(height: context.sizeOfHeight * 0.28),
              Spacer(),
              Text(
                ref.watch(softDeleteProcessMessageHolder),
                style: TextStyles.h7Bold(context),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              Text(
                'Please don\'t close or remove the app during this process.\n'
                'We\'ll take care of everything in a few seconds.',
                style: TextStyles.h8Gray(context),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              LoadingIndicatorX(),
              Text(
                'We\'re securely processing your account.\nThis won\'t take long.',
                style: TextStyles.h10Gray(context),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
