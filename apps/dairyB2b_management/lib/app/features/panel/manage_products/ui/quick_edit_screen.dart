import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:models/enums/product_status.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/common/widgets/global_dis_slider.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/drop_down_x.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/widgets/mode_show_widget.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/manage_product_provider.dart';

class QuickEditScreen extends StatelessWidget {
  const QuickEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
      wantLeading: true,
      appToolbarHeight: -1,
      body: QuickEditBody(),
    );
  }

  static Future<ProductStatus?> bottomSheet(BuildContext context) {
    return showModalBottomSheet<ProductStatus>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _QuickEditBottomSheetContent(),
    );
  }
}

class _QuickEditBottomSheetContent extends StatelessWidget {
  const _QuickEditBottomSheetContent();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        const Positioned(
          top: -60,
          child: _CloseButton(),
        ),
        Container(
          width: context.sizeOfWidth,
          height: context.sizeOfHeight * 0.775,
          decoration: BoxDecoration(
            color: appColors.ms.whiteSwNero(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: QuickEditBody(),
        ),
      ],
    );
  }
}

class QuickEditBody extends HookConsumerWidget {
  const QuickEditBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //debugPrint('💥 Rebuilding widget QuickEditBody');

    final productManager = ref.watch(manageProductProvider);
    final priceCtrl = useTextEditingController();
    final priceCtrlLis = useValueListenable(priceCtrl);
    final packSizeCtrl = useTextEditingController();
    final status = useState<ProductStatus?>(null);
    final globDis = useState<double>(0);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Quick Edit', style: TextStyles.h7Bold(context)),
                    productManager.maybeWhen(
                      orElse: () => SizedBox.shrink(),
                      data: (maker) => ModeShowWidget(
                          label: maker.mode.name, color: maker.mode.color),
                    ),
                  ],
                ),
                gapH8,
                productManager.when(
                  data: (productData) {
                    final product = productData.product;
                    final discount = productData.discount;
                    useEffect(() {
                      if (product != null) {
                        priceCtrl.text = formatDouble(product.price);
                        packSizeCtrl.text = product.packSize.toString();
                        status.value = product.status;
                      }

                      if (discount != null) {
                        globDis.value = discount.discount;
                      }

                      return null;
                    }, [productData]);

                    return SpacedColumn(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextField(
                          controller: priceCtrl,
                          title: (double.tryParse(priceCtrlLis.text) ?? 0) == 0
                              ? 'Price'
                              : 'Price ${PriceTag.formatPrice(double.tryParse(priceCtrlLis.text) ?? 0)}',
                          hintText: 'e.g. 60',
                          suffixIcon: SufFixHolder(children: [
                            Text(
                              '₹',
                              style: TextStyles.h7Gray(context)
                                  ?.copyWith(fontFamily: 'Roboto'),
                            ),
                            gapW12
                          ]),
                          isMandatory: true,
                          inputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                        AppTextField(
                          controller: packSizeCtrl,
                          title: 'Pack Size',
                          hintText: 'e.g. 5',
                          isMandatory: true,
                          inputType: TextInputType.number,
                        ),
                        DropDownX<ProductStatusFilter>(
                            title: 'Status',
                            hintText: 'Choose a product status',
                            isMandatory: true,
                            items: productStatusFilters,
                            value: productStatusToFilter(
                                status.value ?? ProductStatus.deleted),
                            itemLabel: (r) => r.label,
                            onChanged: (newStatus) {
                              //print(
                              // '----newStatus----- ${newStatus?.value.name} ');
                              status.value = newStatus?.value;
                            }),
                        GlobalDisSlider(
                            disValue: globDis.value,
                            onChanged: (newDiscount) =>
                                globDis.value = newDiscount)
                      ],
                    );
                  },
                  error: (e, _) => ErrorScreen(error: e, onRetry: () {}),
                  loading: () => LoadingScreen(),
                ),
              ],
            ),
          ),
        ),
        productManager.maybeWhen(
          orElse: () => SizedBox.shrink(),
          data: (productData) {
            return Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                child: ButtonX.primaryButton(
                  context: context,
                  label: 'Publish',
                  icon: Icons.rocket_launch,
                  iconFirst: false,
                  onPressed: () async {
                    //print('pric ---  ${priceCtrl.text}');
                    //print('dis --  ${globDis.value}');
                    //print('min ---  ${minBuyQtyCtrl.text}');
                    final manager = ref.watch(manageProductProvider.notifier);
                    await manager
                        .quickUpdateProAndDis(
                            price: double.tryParse(priceCtrl.text),
                            packSize: int.tryParse(packSizeCtrl.text),
                            discountValue: globDis.value,
                            status: status.value)
                        .then(
                      (value) {
                        if (value == null) {
                          context.pop<ProductStatus?>(status.value);
                        } else {
                          showMessageSnackbar(
                              context: context,
                              message: value,
                              maxLines: 2,
                              type: SnackBarType.error);
                        }
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
        iconColor: WidgetStatePropertyAll(appColors.ms.whiteSwNero(context)),
        backgroundColor: WidgetStatePropertyAll(
          appColors.ms.neroSwWhite(context).withValues(alpha: 0.3),
        ),
      ),
      onPressed: () => context.pop(),
      icon: const Icon(Icons.close_rounded, weight: 10),
    );
  }
}
