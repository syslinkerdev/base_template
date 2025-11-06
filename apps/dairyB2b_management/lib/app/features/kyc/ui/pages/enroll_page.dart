import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/kyc/providers/kyc_provider.dart';
import 'package:core/core.dart';
import 'package:system_assets/app_images.dart';

class Enroll extends HookConsumerWidget with AttachmentSelectionMixin {
  const Enroll({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = useTextEditingController(text: '');
    final lastNameController = useTextEditingController(text: '');
    final selectedImage = useState<File?>(null);
    final adminEnrollPro = ref.watch(adminEnrollProvider);
    ref.listen(
        adminEnrollProvider, (_, next) => next.showAlertDialogOnError(context));

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: sysImages.selfie
                  .toWidget(height: context.sizeOfHeight * 0.26),
            ),
            Row(
              children: [
                CircularImageAvatar(image: selectedImage.value),
                Expanded(
                  child: SpacedColumn(
                    children: [
                      SizedBox(
                        width: context.sizeOfWidth * 0.4,
                        child: ButtonX(
                          label: 'Add profile',
                          icon: Icons.photo_camera,
                          iconFirst: true,
                          onPressed: () async {
                            final capturedFile = await captureImage();
                            if (capturedFile.isNull) return;
                            selectedImage.value = capturedFile.first;
                          },
                        ),
                      ),
                      SizedBox(
                        width: context.sizeOfWidth * 0.4,
                        child: ButtonX(
                          label: 'Preview',
                          icon: Icons.photo,
                          loading: false,
                          iconFirst: true,
                          onPressed: selectedImage.value.isNull
                              ? null
                              : () async => previewDialog.fullImage(
                                  context: context,
                                  imagePath:
                                      selectedImage.value!.path.toString(),
                                  sourceType: ImageSourceType.file),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            gapH12,
            AppTextField(
              controller: firstNameController,
              hintText: 'Enter your first name',
              title: 'First name',
            ),
            gapH12,
            AppTextField(
              controller: lastNameController,
              hintText: 'Enter your last name',
              title: 'Last name',
            ),
            Padding(
                padding: EdgeInsets.only(
                    top: context.sizeOfHeight * 0.1, left: 10, right: 10),
                child: ButtonX.primaryButton(
                  context: context,
                  label: 'Confirm',
                  loading: adminEnrollPro.isLoading,
                  onPressed: () =>
                      ref.read(adminEnrollProvider.notifier).updateUser(
                          admin: ref.read(userXHolder).copyWith(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                avatar: selectedImage.value.isNotNull
                                    ? selectedImage.value!.path.toString()
                                    : '',
                              )),
                )),
          ],
        ),
      ),
    );
  }
}
