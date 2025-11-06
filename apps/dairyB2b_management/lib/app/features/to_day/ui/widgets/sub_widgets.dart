import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:repo/repo.dart';
import 'package:system_assets/app_images.dart';

class BrandsList extends ConsumerWidget {
  final void Function(Brand brand) onSelect;
  const BrandsList({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proMaker = ref.watch(fetchProductMakerProvider);

    return Column(
      children: [
        HeadingLineFade(label: 'COMPANIES (${proMaker.value?.brands.length})'),
        proMaker.when(
          data: (maker) => DynamicList<Brand>(
            items: maker?.brands ?? [],
            physics: const NeverScrollableScrollPhysics(),
            onSelect: (brand) async => onSelect.call(brand),
            itemBuilder: (context, brand, _) =>
                CompanyActionButton(brand: brand),
          ),
          error: (error, _) => Center(
            child: Column(
              children: [
                Icon(Icons.nearby_error_rounded,
                    size: context.sizeOfHeight * 0.1,
                    color: appColors.sc.grey650),
                gapH20,
                Text(
                  error.toString(),
                  style: TextStyles.h8(context),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          loading: () => _buildShimmerLoading(context),
        ),
      ],
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [60.0, 60.0, 60.0, 60.0];
    return SingleChildScrollView(
      child: SpacedColumn(
        children: heightMultipliers
            .map((h) => ShimmerX(width: context.sizeOfWidth, height: h))
            .toList(),
      ),
    );
  }
}

class CompanyActionButton extends StatelessWidget {
  final bool loading;
  final String? progressText;
  final Brand brand;

  const CompanyActionButton(
      {super.key,
      this.loading = false,
      this.progressText,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    final size = 40.0;
    return ContainerX(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size,
                height: size,
                child: FadeInImageX(
                    imagePath: brand.image ?? sysImages.noInternet.path,
                    height: size * 0.6,
                    width: size * 0.6),
              ),
              gapW12,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brand.label,
                    style: TextStyles.h8Gray(context)
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    progressText ?? brand.id,
                    style: TextStyles.h15Gray(context),
                  ),
                ],
              ),
            ],
          ),
          if (loading) ...[
            LoadingIndicatorX()
          ] else ...[
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: appColors.ms.textBlack50(context),
            ),
          ],
        ],
      ),
    );
  }
}

class MainOrderCard extends StatelessWidget {
  const MainOrderCard(
      {super.key,
      required this.mainOrder,
      this.doNotWantMainBillDetails = false,
      this.forActualDelivery = false});
  final MainOrder mainOrder;
  final bool doNotWantMainBillDetails;
  final bool forActualDelivery;

  @override
  Widget build(BuildContext context) {
    final icon = forActualDelivery
        ? "A-${mainOrder.deliveryDate.day}"
        : "M-${mainOrder.deliveryDate.day}";
    return Center(
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: appColors.cS(context).surfaceTint,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(icon,
                      style: TextStyles.h8Bold(context),
                      textAlign: TextAlign.center),
                ),
              ),
              gapW8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(DFU.moreFriendlyFormat(mainOrder.deliveryDate),
                        style: TextStyles.h7(context)),
                    gapH4,
                    Row(
                      children: [
                        // Text("Count : ", style: TextStyles.h12Gray(context)),
                        Icon(Icons.inventory_2_outlined,
                            size: TextStyles.h13Gray(context)?.fontSize,
                            color: appColors.ms.textBlack50(context)),
                        gapW4,
                        Text("${mainOrder.noOfProducts} Products",
                            style: TextStyles.h13Gray(context)),
                        gapW12,
                        Icon(Icons.people,
                            size: TextStyles.h13Gray(context)?.fontSize,
                            color: appColors.ms.textBlack50(context)),
                        gapW4,
                        Text("${mainOrder.noOfClients} Clients",
                            style: TextStyles.h13Gray(context)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!doNotWantMainBillDetails) ...[
            MainBillDetails(mainOrder: mainOrder),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "Created at ${DFU.moreFriendlyFormat(mainOrder.createdAt)} ${DFU.timeOnly12h(mainOrder.createdAt)}",
                style: TextStyles.h13Bold(context)
                    ?.copyWith(color: appColors.ms.textBlack50(context)),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class MainBillDetails extends StatelessWidget {
  const MainBillDetails({super.key, required this.mainOrder});
  final MainOrder mainOrder;

  @override
  Widget build(BuildContext context) {
    final total = mainOrder.overallTotal;
    final afterDis = mainOrder.overallTotalAfterDis;
    final discount = total - afterDis;
    final serviceCharges = mainOrder.serviceCharges;
    final profit = discount + serviceCharges;

    return SpacedColumn(
      children: [
        _billRow(context, 'Total', '₹${PriceTag.formatPrice(total)}'),
        _billRow(context, 'Discount', '− ₹${PriceTag.formatPrice(discount)}'),
        _billRow(
            context, 'After Discount', '₹${PriceTag.formatPrice(afterDis)}'),
        SimpleDivider(),
        _billRow(context, 'Service Charges',
            '+ ₹${PriceTag.formatPrice(serviceCharges)}'),
        _billRow(context, 'Savings', '+ ₹${PriceTag.formatPrice(discount)}'),
        _billRow(context, 'Profit', '₹${PriceTag.formatPrice(profit)}'),
      ],
    );
  }

  Row _billRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DashedUnderlineText(
          text: label,
          style: TextStyles.h13Bold(context),
        ),
        Text(
          value,
          style: TextStyles.h13Bold(context)?.copyWith(fontFamily: 'Roboto'),
        ),
      ],
    );
  }
}
