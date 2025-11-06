import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/kyc/providers/kyc_provider.dart';
import 'package:core/core.dart';
import 'package:system_assets/app_images.dart';

class EnrollShopDetailsPage extends HookConsumerWidget with CommonValidator {
  const EnrollShopDetailsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kyc = ref.watch(kycProvider);
    final shopNameController = useTextEditingController(text: '');

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Shop details . . .',
                style: TextStyles.h5Bold(context)
                    ?.copyWith(color: appColors.ms.black60(context)),
              ),
            ),
            SizedBox(
              height: context.sizeOfHeight * 0.26,
              width: context.sizeOfWidth,
              child: sysImages.shopEnroll.toWidget(),
            ),
            AppTextField(
              controller: shopNameController,
              hintText: 'Enter your shop name',
              title: 'Shop name',
            ),
            AppAddressField(
              action: ({address}) {
                //print(address);
                return [
                  Padding(
                    padding: EdgeInsets.only(
                        top: context.sizeOfHeight * 0.08, left: 10, right: 10),
                    child: ButtonX.primaryButton(
                      context: context,
                      label: 'continue',
                      loading: kyc.isLoading,
                      onPressed: () => submitShopDetails(
                        context: context,
                        shopName: shopNameController.text,
                        address: address,
                        updateShopDetails: () =>
                            ref.read(kycProvider.notifier).atConfirmShopDetails(
                                  shopName: shopNameController.text,
                                  stateName: address!.stateName,
                                  city: address.city,
                                  locality: address.locality,
                                  pinCode: address.pinCode,
                                  street: address.street,
                                  buildingNumber: address.buildingNumber,
                                ),
                      ),
                    ),
                  )
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
