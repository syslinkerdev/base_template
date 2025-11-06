import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/kyc/kyc_validator.dart';
import 'package:dairyB2b_orders/app/features/kyc/providers/kyc_provider.dart';
import 'package:dairyB2b_orders/app/features/kyc/ui/widgets/admin_card.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';

class AuthorizeChooseAdminPage extends HookConsumerWidget with KycValidator {
  const AuthorizeChooseAdminPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admins = ref.watch(fetchAdminsAndSuperAdminsListProvider);
    final kyc = ref.watch(kycProvider);
    final selectedAdmin = useState<DataBlock3>(DataBlock3.empty());
    return admins.when(
      skipLoadingOnRefresh: false,
      data: (adminList) {
        if (adminList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off_outlined,
                    size: context.sizeOfHeight * 0.12,
                    color: appColors.sc.grey650),
                gapH20,
                Text(
                  'No admins available at the moment!',
                  style: TextStyles.h7(context),
                  textAlign: TextAlign.center,
                ),
                gapH8,
                Text(
                  'Please try again later or contact support.',
                  style: TextStyles.h9Gray(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                    ),
                    itemCount: adminList.length,
                    itemBuilder: (context, index) {
                      final admin = adminList[index];
                      return AdminCard(
                        admin: admin,
                        isSelected: selectedAdmin.value.v1 == admin.phoneNumber,
                        onSelected: (DataBlock3 shortAdmin) {
                          //print(admin);
                          //print(shortAdmin);
                          //print('Selected admin: ${shortAdmin.v2}');
                          //print('admin.phoneNumber: ${admin.phoneNumber}');
                          selectedAdmin.value = shortAdmin;
                        },
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Please choose an admin.',
                    textAlign: TextAlign.center,
                    style: TextStyles.h4Bold(context),
                  ),
                  Text(
                    'Note: You need to get an access code from the chosen admin.',
                    textAlign: TextAlign.center,
                    style: TextStyles.h8Gray(context),
                  ),
                  ButtonX.primaryButton(
                    context: context,
                    label: 'Confirm',
                    loading: kyc.isLoading,
                    onPressed: () => toConfirmAdmin(
                        admin: selectedAdmin.value,
                        context: context,
                        afterConfirmAdmin: () => ref
                            .read(kycProvider.notifier)
                            .atConfirmAdmin(admin: selectedAdmin.value)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        color: appColors.ms.textBlack50(context),
                        size: 16,
                      ),
                      gapW4,
                      Text(
                        'Most people finish this step under 3 minutes.',
                        textAlign: TextAlign.center,
                        style: TextStyles.h10Gray(context),
                      ),
                    ],
                  )
                ],
              ))
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => ErrorScreen(
          error: error,
          onRetry: () =>
              ref.refresh(fetchAdminsAndSuperAdminsListProvider.future)),
    );
  }
}
