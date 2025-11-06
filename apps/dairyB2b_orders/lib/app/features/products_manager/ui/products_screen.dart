import 'package:core/core.dart';
import 'package:repo/repo.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_helper.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/product_list.dart';
import 'package:dairyB2b_orders/app/features/products_manager/ui/widgets/products_bottom_bar.dart';

class ProductsScreenArgs {
  final String? initBrand;
  final String? initCategory;

  ProductsScreenArgs({this.initBrand, this.initCategory});
}

class ProductsScreen extends HookConsumerWidget {
  const ProductsScreen({
    super.key,
    this.initBrand,
    this.initCategory,
  });

  final String? initBrand;
  final String? initCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productMaker = ref.watch(fetchProductMakerProvider).value;
    final brandId = useState<String?>(
      initBrand ?? productMaker?.brands.first.id,
    );
    final categoryId = useState<String?>(
      initCategory ?? productMaker?.categories.first.id,
    );

    final cartCount = CH.cartCount(ref);
    final cartLength = CH.cartList(ref).length;

    return ScaffoldX(
      title: 'Products',
      wantLeading: true,
      appToolbarHeight: -1,
      // appBarActions: const [AnyWereSearchBtn()],
      bottomNavigationBar: cartCount == 0
          ? null
          : ProductsBottomBar(
              cartLength: cartLength,
              cartCount: cartCount,
            ),
      body: Row(
        children: [
          _buildLeftPanel(context, productMaker, brandId, categoryId),
          Flexible(
            child: Column(
              children: [
                _buildTopPanel(context, productMaker, brandId, categoryId),
                Expanded(
                  child: ProductList(
                    initBrand: brandId.value,
                    initCategory: categoryId.value,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPanel(
    BuildContext context,
    ProductMaker? maker,
    ValueNotifier<String?> brandId,
    ValueNotifier<String?> categoryId,
  ) {
    final showCategories = initBrand != null;

    return _baseCard(
      context,
      shadowX: 6,
      shadowY: 2,
      child: SizedBox(
        height: context.sizeOfHeight * 0.05,
        width: context.sizeOfWidth,
        child: showCategories
            ? _buildCategorySelector(maker?.categories, categoryId)
            : _buildBrandSelector(maker?.brands, brandId),
      ),
    );
  }

  BtnList<T> _buildSelector<T>(
    List<T>? items,
    ValueNotifier<String?> selectedId,
    T Function() empty,
  ) {
    return BtnList<T>(
      data: items ?? [],
      initItem: (items ?? []).firstWhere(
        (e) => (e as dynamic).id == selectedId.value,
        orElse: () => items?.isNotEmpty == true ? items!.first : empty(),
      ),
      onSelect: (item) => selectedId.value = (item as dynamic).id,
      builder: (context, item, isSelected) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: appColors
                    .cS(context)
                    .surfaceTint
                    .withValues(alpha: isSelected ? 0.8 : 0.2),
              ),
              child: SizedBox(
                height: 16,
                width: 16,
                child: FadeInImageX(imagePath: (item as dynamic).image ?? ''),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 2, right: 6),
              child: Text(
                (item as dynamic).label,
                style: TextStyles.h15Bold(context)
                    ?.copyWith(color: appColors.cS(context).inversePrimary),
              ),
            ),
          ],
        );
      },
    );
  }

  BtnList<Brand> _buildBrandSelector(
    List<Brand>? items,
    ValueNotifier<String?> selectedId,
  ) =>
      _buildSelector<Brand>(items, selectedId, Brand.empty);

  BtnList<Category> _buildCategorySelector(
    List<Category>? items,
    ValueNotifier<String?> selectedId,
  ) =>
      _buildSelector<Category>(items, selectedId, Category.empty);

  Widget _buildLeftPanel(
    BuildContext context,
    ProductMaker? maker,
    ValueNotifier<String?> brandId,
    ValueNotifier<String?> categoryId,
  ) {
    final showBrands = initBrand != null;

    return _baseCard(
      context,
      shadowX: 2,
      shadowY: 6,
      child: SizedBox(
        height: context.sizeOfHeight,
        width: context.sizeOfWidth * 0.19,
        child: showBrands
            ? _buildBrandList(maker?.brands, context, brandId)
            : _buildCategoryList(maker?.categories, context, categoryId),
      ),
    );
  }

  DynamicList<T> _buildList<T>({
    required List<T>? items,
    required BuildContext context,
    required ValueNotifier<String?> selectedId,
    required T Function() empty,
  }) {
    return DynamicList<T>(
      items: items ?? [],
      spacing: 60,
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
      initialSelectedItem: (items ?? []).firstWhere(
        (e) => (e as dynamic).id == selectedId.value,
        orElse: () => items?.isNotEmpty == true ? items!.first : empty(),
      ),
      itemBuilder: (context, item, isSelected) {
        return ItemCard(
          noBorderAndBg: true,
          gradient: isSelected
              ? [appColors.cS(context).surfaceTint, appColors.ms.white(context)]
              : null,
          imgHeight: 40,
          imgWidth: 40,
          labelStyle: TextStyles.h15Bold(context)?.copyWith(fontSize: 9),
          item: item,
          getImage: (b) => (b as dynamic).image,
          getLabel: (b) => (b as dynamic).label,
        );
      },
      onSelect: (item) => selectedId.value = (item as dynamic).id,
    );
  }

  DynamicList<Brand> _buildBrandList(
    List<Brand>? items,
    BuildContext context,
    ValueNotifier<String?> selectedId,
  ) =>
      _buildList(
        items: items,
        context: context,
        selectedId: selectedId,
        empty: Brand.empty,
      );

  DynamicList<Category> _buildCategoryList(
    List<Category>? items,
    BuildContext context,
    ValueNotifier<String?> selectedId,
  ) =>
      _buildList(
        items: items,
        context: context,
        selectedId: selectedId,
        empty: Category.empty,
      );

  Widget _baseCard(
    BuildContext context, {
    Widget? child,
    double? shadowX,
    double? shadowY,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: appColors.ms.white(context),
        borderRadius: BorderRadius.zero,
        boxShadow: [
          if (shadowX != null || shadowY != null)
            BoxShadow(
              color: appColors.ms.black60(context).withValues(alpha: 0.1),
              offset: Offset(shadowX ?? 0, shadowY ?? 0),
              blurRadius: 6,
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.zero,
        child: child,
      ),
    );
  }
}
