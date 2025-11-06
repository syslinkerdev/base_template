import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:core/core.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_helper.dart';
import 'package:dairyB2b_management/app/features/adjustment/providers/adjustment_provider.dart';

class QuickAddSection extends StatelessWidget {
  final Product product;
  final bool fromPsv;

  const QuickAddSection(
      {super.key, required this.product, this.fromPsv = false});

  @override
  Widget build(BuildContext context) {
    return ContainerX(
      margin: EdgeInsetsGeometry.only(bottom: 4),
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleHeading(label: 'Quick Add Options'),
          QuickAddOptions(
              quickAddOptions: product.quickAddOptions,
              productId: product.id,
              fromPsv: fromPsv),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info,
                  color: appColors.cS(context).primaryFixedDim, size: 18),
              Text(
                '${product.quickAddOptions.first.label} equal to ${product.quickAddOptions.first.quantity}',
                style: TextStyles.h12Bold(context)
                    ?.copyWith(color: appColors.cS(context).inversePrimary),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class QuickAddOptions extends HookConsumerWidget {
  const QuickAddOptions(
      {super.key,
      required this.quickAddOptions,
      required this.productId,
      required this.fromPsv});

  final List<PackagingType> quickAddOptions;
  final String productId;
  final bool fromPsv;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPackagingType = useState<PackagingType?>(null);
    final cartItems = AH.finalCartList(ref);
    final adjustmentRead = ref.read(adjustmentProvider.notifier);
    final productInCart = cartItems.any((item) => item.id == productId);
    if (!productInCart) {
      selectedPackagingType.value = null;
    }
    return DynamicList<PackagingType>(
      key: ValueKey(!productInCart),
      padding: EdgeInsets.zero,
      items: quickAddOptions,
      initialSelectedItem: productInCart ? selectedPackagingType.value : null,
      isGridView: true,
      gridCrossAxisCount: 3,
      gridChildAspectRatio: 3,
      spacing: 5,
      onSelect: (item) async => await _handleItemSelection(
          adjustmentRead, item, selectedPackagingType, fromPsv),
      itemBuilder: (context, item, isSelected) =>
          PackagingTypeItem(item: item, isSelected: isSelected),
    );
  }

  Future<void> _handleItemSelection(
      Adjustment adjustmentRead,
      PackagingType item,
      ValueNotifier<PackagingType?> selectedPackagingType,
      bool formPsv) async {
    if (item == selectedPackagingType.value) {
      adjustmentRead.removeItem(productId);
      selectedPackagingType.value = null;
    } else {
      await adjustmentRead.addItem(productId, item.quantity,
          clearAndUpdate: true);
      selectedPackagingType.value = item;
    }
  }
}

class PackagingTypeItem extends StatelessWidget {
  final PackagingType item;
  final bool isSelected;

  const PackagingTypeItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
          color: appColors
              .cS(context)
              .surfaceTint
              .withValues(alpha: isSelected ? 1 : 0.5),
          width: isSelected ? 2 : 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _PackageIcon(isSelected: isSelected),
          gapW4,
          Expanded(
            child: Text(
              _truncatedName(item.label),
              style: _nameTextStyle(context, item.label.length),
            ),
          ),
        ],
      ),
    );
  }

  String _truncatedName(String name) =>
      name.length > 7 ? '${name.substring(0, 7)}..' : name;

  TextStyle? _nameTextStyle(BuildContext context, int nameLength) =>
      (nameLength > 7 ? TextStyles.h11Bold : TextStyles.h9Bold)
          .call(context)
          ?.copyWith(color: appColors.cS(context).inversePrimary);
}

class _PackageIcon extends StatelessWidget {
  final bool isSelected;

  const _PackageIcon({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: appColors
            .cS(context)
            .surfaceTint
            .withValues(alpha: isSelected ? 0.8 : 0.2),
      ),
      child: Icon(
        Icons.border_all,
        size: 21,
        color: appColors.ms.black80(context),
      ),
    );
  }
}
