import 'dart:io';

import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/account/providers/account_provider.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';

class EditAccount extends HookConsumerWidget
    with CommonValidator, AttachmentSelectionMixin {
  const EditAccount({
    super.key,
    required this.profile,
  });

  final Map<String, dynamic> profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //print('profile ${profile['role']}');
    final firstNameController =
        useTextEditingController(text: profile['fName'] ?? '');
    final lastNameController =
        useTextEditingController(text: profile['lName'] ?? '');
    final avatar = useState<String>(profile['avatar'] ?? '');
    final avatarOfAdminToShow = useState<File?>(null);
    final buttonLoading = useState<bool>(false);

    ref.listen(accountProvider, (_, next) {
      //print('from accountProvider');
      next.showAlertDialogOnError(context);
    });

    return ScaffoldX(
      titleCenter: true,
      wantLeading: true,
      title: 'Edit Profile',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SpacedColumn(
                  children: [
                    CircularImageAvatar(
                      image: profile['role'] != Role.client &&
                              avatarOfAdminToShow.value.isNotNull
                          ? avatarOfAdminToShow.value
                          : avatar.value,
                      modeEdit: true,
                      onTap: () async {
                        //print('object');
                        if (profile['role'] != Role.client) {
                          //print('(profile[role] != Role.client)');
                          final capturedFile = await captureImage();
                          if (capturedFile.isNull) return;
                          avatarOfAdminToShow.value = capturedFile.first;
                          avatar.value = capturedFile.first.path.toString();
                        } else {
                          AvatarsList.showDialog(
                            context,
                            title: 'Select Avatar',
                            initialAvatarImage: avatar.value,
                            onChange: (selectedAvatar) {
                              return avatar.value = selectedAvatar.image;
                            },
                          );
                        }
                      },
                    ),
                    AppTextField(
                      controller: firstNameController,
                      hintText: 'Enter your first name',
                      title: 'First name',
                    ),
                    AppTextField(
                      controller: lastNameController,
                      hintText: 'Enter your last name',
                      title: 'Last name',
                    ),
                    AppTextField(
                      initialValue: profile['phone'] ?? '',
                      title: 'Phone Number',
                      readOnly: true,
                      onTap: () => showMessageSnackbar(
                        context: context,
                        maxLines: 2,
                        message:
                            'For security reasons, the phone number can\'t be edited.',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonX.primaryButton(
              context: context,
              label: 'Save',
              loading:
                  buttonLoading.value || ref.watch(accountProvider).isLoading,
              onPressed: () async {
                if (profile['role'] != Role.client &&
                    profile['avatar'] != avatar.value) {
                  buttonLoading.value = true;
                  if (!(await isValidProfilePhoto(avatar.value))) {
                    DialogsX.showErrorDialog(context,
                        content: 'Invalid photo, Provide selfie!',
                        title: 'Invalid photo');
                    buttonLoading.value = false;
                    return;
                  }
                }
                _submitUserDetails(
                  context: context,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  avatar: avatar.value,
                  hPin: profile['hPin'] ?? '',
                  uId: profile['uid'],
                  ref: ref,
                ).then(
                  (_) => buttonLoading.value = false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitUserDetails({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String avatar, // new local file path
    required String hPin,
    required String uId,
    required WidgetRef ref,
  }) async {
    await context.unfocusKeyboard();

    if (!context.mounted) return;

    try {
      String finalAdminAvatar =
          profile['role'] != Role.client ? profile['avatar'] ?? '' : avatar;

      // ✅ Only if not client && avatar changed
      if (profile['role'] != Role.client && profile['avatar'] != avatar) {
        final ext = StringUtils.extractExtensionFromUrl(profile['avatar']);
        // 1️⃣ Delete old
        await ref.read(firestoreServiceProvider).deleteImage(
            storagePath: '${StoragePathManger.avatar(name: uId)}.$ext');

        // 2️⃣ Upload new
        finalAdminAvatar = await ref.read(firestoreServiceProvider).uploadImage(
            imageFile: File(avatar),
            destinationStoragePath: StoragePathManger.avatar(name: uId));
      }
      //print('finalAdminAvatar : $finalAdminAvatar ------ ');

      // 3️⃣ Confirm PIN & update
      await submitUserDetails(
        firstName: firstName,
        lastName: lastName,
        context: context,
        updateUserDetails: () async {
          final shouldUpdate =
              await AppRoute.confirmPin.push(context, extra: hPin);

          if (shouldUpdate != true) return;

          await ref.read(accountProvider.notifier).updateAccount(
                firstName: firstName,
                lastName: lastName,
                avatar: finalAdminAvatar,
                uid: uId,
              );

          ref.invalidate(fetchUserProvider(documentId: uId));

          if (!context.mounted) return;

          showMessageSnackbar(
            context: context,
            message: '✅ Your profile has been updated!',
            maxLines: 2,
          );

          StatefulNavigationShell.of(context)
              .goBranch(3, initialLocation: true);
        },
      );
    } catch (e, _) {
      //print('❌ Error in _submitUserDetails: $e\n$st');

      if (!context.mounted) return;

      showMessageSnackbar(
        context: context,
        message: '❌ Failed to update profile: ${e.toString()}',
        maxLines: 3,
      );
    }
  }
}
