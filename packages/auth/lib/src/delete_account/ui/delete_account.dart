import 'package:auth/auth.dart';
import 'package:flutter/gestures.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:system_assets/app_images.dart';
import 'package:flutter/material.dart';
import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:repo/repo.dart';

class DeleteAccountArgs {
  final String uId;
  final void Function(WidgetRef ref) onRecoverAccount;
  final void Function(WidgetRef ref) onCreateNewAccount;
  DeleteAccountArgs(
      {required this.uId,
      required this.onRecoverAccount,
      required this.onCreateNewAccount});
}

class DeleteAccount extends HookConsumerWidget {
  const DeleteAccount(
      {super.key,
      required this.uId,
      required this.onRecoverAccount,
      required this.onCreateNewAccount});
  final String uId;

  final void Function(WidgetRef ref) onRecoverAccount;
  final void Function(WidgetRef ref) onCreateNewAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userFetch = ref.watch(fetchDeletedUserProvider(documentId: uId));
    final deleteAccountProRead = ref.read(deleteAccountXProvider.notifier);
    final deleteAccountProWatch = ref.watch(deleteAccountXProvider);
    //print('$uId -----------this from old user doc----- DeleteAccount -------');
    //print(
    // '${ref.read(phoneNoVerifyServiceProvider).currentUser?.uid} ---------- currentUser from phoneNoVerifyServiceProvider');
    return ErrorListenerWidget(
      provider: deleteAccountXProvider,
      child: ScaffoldX(
        appToolbarHeight: 0,
        body: userFetch.when(
          data: (user) {
            final deletedByRole = user?.deletedBy ?? Role.client;
            final userRole = user?.role ?? Role.client;

            final toShowDeletedBy =
                deletedByRole == userRole ? 'You' : deletedByRole.name;

            if (user == null) {
              return const Center(child: Text('Ghost'));
            }
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  child: SpacedColumn(
                    defaultHeight: 8.0,
                    children: [
                      Text('Account Deleted - You\'re Still in Control',
                          style: TextStyles.h7Bold(context)),
                      gapH12,
                      sysImages.deleteAccount
                          .toWidget(height: context.sizeOfHeight * 0.2),
                      gapH12,

                      Text('Your account was deleted.',
                          style: TextStyles.h6Bold(context)),
                      Text(
                          'You can recover your account or start fresh with a new one.',
                          style: TextStyles.h9Gray(context),
                          textAlign: TextAlign.center),
                      Spacer(),
                      SimpleHeading(label: 'Deletion Details :'),

                      // 🧾 Metadata rows
                      MetaInfoRow(
                          label: 'Name',
                          value: '${user.firstName} ${user.lastName}'),
                      MetaInfoRow(label: 'Phone', value: user.phoneNumber),
                      MetaInfoRow(
                          label: 'Deleted At',
                          value: DFU.ddMMMyyyy(user.deletedAt ?? DFU.now())),
                      MetaInfoRow(label: 'Deleted By', value: toShowDeletedBy),
                      SimpleHeading(label: 'Choose an option below :'),
                      ButtonX.primaryButton(
                        context: context,
                        label: 'Recover Account',
                        noAsyncLoading: true,
                        onPressed: () async {
                          final confirmed = await DialogsX.askForConfirmation(
                            context,
                            title: 'Recover Account?',
                            content:
                                'Do you want to recover your deleted account?',
                            confirmBtnText: 'Recover',
                            cancelBtnText: 'Cancel',
                          );

                          if (confirmed == true) {
                            await deleteAccountProRead.recoverAccount(
                                deletedUser: user);

                            if (!deleteAccountProWatch.hasError) {
                              showMessageSnackbar(
                                context: context,
                                message: '✅ Account recovered successfully!',
                                type: SnackBarType.success,
                                maxLines: 2,
                                duration: const Duration(seconds: 2),
                              );
                              onRecoverAccount(ref);
                            } else {
                              showMessageSnackbar(
                                context: context,
                                message: deleteAccountProWatch.error.toString(),
                                maxLines: 2,
                              );
                            }
                          }
                        },
                      ),
                      ButtonX.outlineButton(
                        context: context,
                        label: 'Create New Account',
                        noAsyncLoading: true,
                        onPressed: () async {
                          final confirmed = await DialogsX.askForConfirmation(
                            context,
                            title: 'New Account?',
                            content:
                                'Are you sure you want to create a new account?\n'
                                'This will permanently delete your current account.',
                            confirmBtnText: 'Create',
                            cancelBtnText: 'Cancel',
                          );

                          if (confirmed == true) {
                            await deleteAccountProRead
                                .createNewAccount(deletedUser: user)
                                .then(
                              (value) {
                                showMessageSnackbar(
                                  context: context,
                                  message:
                                      '🔒 Account deleted. Please sign in again to create a new account.',
                                  type: SnackBarType.warning,
                                  maxLines: 2,
                                  duration: const Duration(seconds: 3),
                                );
                                onCreateNewAccount(ref);
                              },
                            );
                          }
                        },
                      ),
                      gapH4,
                      RichText(
                        text: TextSpan(
                          style: TextStyles.h14Gray(context),
                          children: [
                            const TextSpan(text: 'Need help? '),
                            TextSpan(
                              text: 'Contact support',
                              style: TextStyles.h14(context)
                                  ?.copyWith(color: appColors.sc.cerulean),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  showMessageSnackbar(
                                      context: context,
                                      maxLines: 2,
                                      message:
                                          'Please contact your admin for help regarding this.');
                                },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: ref.watch(deleteAccountXProvider).isLoading
                      ? Container(
                          key: const ValueKey('loader'),
                          width: double.infinity,
                          height: double.infinity,
                          color: appColors.ms.transparent80(context),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
              ],
            );
          },
          error: (error, stackTrace) => ErrorScreen(
              error: error, onRetry: () => refresh(ref: ref, uId: uId)),
          loading: () => const LoadingScreen(),
        ),
      ),
    );
  }

  static Future<void> refresh({
    required WidgetRef ref,
    required String uId,
  }) async =>
      await ref.refresh(fetchUserProvider(documentId: uId).future);
}

class MetaInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const MetaInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SpacedRow(
        defaultHeight: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.h14Gray(context),
          ),
          Text(
            value,
            style: TextStyles.h12(context),
          ),
        ],
      ),
    );
  }
}
