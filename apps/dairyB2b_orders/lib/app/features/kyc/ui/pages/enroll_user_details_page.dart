import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/kyc/providers/kyc_provider.dart';
import 'package:core/core.dart';
import 'package:system_assets/app_images.dart';

class EnrollUserDetailsPage extends HookConsumerWidget with CommonValidator {
  const EnrollUserDetailsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kyc = ref.watch(kycProvider);
    final firstNameController = useTextEditingController(text: '');
    final lastNameController = useTextEditingController(text: '');
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'User details . . .',
                style: TextStyles.h5Bold(context)
                    ?.copyWith(color: appColors.ms.black60(context)),
              ),
            ),
            SizedBox(
              height: context.sizeOfHeight * 0.26,
              width: context.sizeOfWidth,
              child: sysImages.userEnroll.toWidget(),
            ),
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
                  top: context.sizeOfHeight * 0.2, left: 10, right: 10),
              child: ButtonX.primaryButton(
                context: context,
                label: 'continue',
                loading: kyc.isLoading,
                onPressed: () => submitUserDetails(
                    context: context,
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    updateUserDetails: () async {
                      await ref.read(kycProvider.notifier).atConfirmUserDetails(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                          );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
