import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_management/app/features/adjustment/ui/widgets/product_list.dart';
import 'package:repo/repo.dart';

void prosBottomSheetNav(BuildContext context) {
  ProductsScreen.bottomSheet(context);
}

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
      title: 'Products',
      wantLeading: true,
      appToolbarHeight: -1,
      body: ProductsBody(),
    );
  }

  static Future<void> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ProductBottomSheetContent(),
    );
  }
}

class _ProductBottomSheetContent extends StatelessWidget {
  const _ProductBottomSheetContent();

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
            color: appColors.ms.white(context),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: ProductsBody(),
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

class ProductsBody extends HookConsumerWidget {
  const ProductsBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productMakerAsync = ref.watch(fetchProductMakerProvider);

    return Column(
      children: [
        // 🔹 Header
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          alignment: Alignment.centerLeft,
          child: Text('Products', style: TextStyles.h7Bold(context)),
        ),

        // 🔹 Main Content
        Expanded(
          child: productMakerAsync.when(
            loading: () => LoadingScreen(),
            error: (e, s) => Center(
              child: Text(
                'Error loading products\n$e',
                style: TextStyles.h7(context),
                textAlign: TextAlign.center,
              ),
            ),
            data: (productMakerData) {
              if (productMakerData == null ||
                  productMakerData.brands.isEmpty ||
                  productMakerData.categories.isEmpty) {
                return Center(
                  child: Text(
                    'No Brands or Categories Found',
                    style: TextStyles.h7(context),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              // ✅ Initialize states safely after data load
              final brandId =
                  useState<String?>(productMakerData.brands.first.id);
              final categoryId =
                  useState<String?>(productMakerData.categories.first.id);

              // 🔹 Main Row Layout
              return Row(
                children: [
                  _buildLeftPanel(context, productMakerData, brandId),
                  Flexible(
                    child: Column(
                      children: [
                        _buildTopPanel(context, productMakerData, categoryId),
                        Expanded(
                          child: ProductList(
                              initBrand: brandId.value,
                              initCategory: categoryId.value),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopPanel(
    BuildContext context,
    ProductMaker? maker,
    ValueNotifier<String?> categoryId,
  ) {
    return SizedBox(
        height: 42,
        width: context.sizeOfWidth,
        child: _buildCategorySelector(maker?.categories, categoryId));
  }

  BtnList<Category> _buildCategorySelector(
    List<Category>? items,
    ValueNotifier<String?> selectedId,
  ) =>
      BtnList<Category>(
        data: items ?? [],
        initItem: (items ?? []).firstWhere(
          (e) => e.id == selectedId.value,
          orElse: () =>
              items?.isNotEmpty == true ? items!.first : Category.empty(),
        ),
        onSelect: (item) => selectedId.value = item.id,
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
                      .withValues(alpha: isSelected ? 0.6 : 0.2),
                ),
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: FadeInImageX(imagePath: item.image ?? ''),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 2, right: 6),
                child: Text(
                  item.label,
                  style: TextStyles.h15Bold(context)
                      ?.copyWith(color: appColors.cS(context).surfaceTint),
                ),
              ),
            ],
          );
        },
      );

  Widget _buildLeftPanel(
    BuildContext context,
    ProductMaker? maker,
    ValueNotifier<String?> brandId,
  ) {
    return SizedBox(
        height: context.sizeOfHeight,
        width: 76,
        child: _buildBrandList(maker?.brands, context, brandId));
  }

  DynamicList<Brand> _buildBrandList(
    List<Brand>? items,
    BuildContext context,
    ValueNotifier<String?> selectedId,
  ) =>
      DynamicList<Brand>(
        items: items ?? [],
        spacing: 60,
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6.0),
        initialSelectedItem: (items ?? []).firstWhere(
          (e) => e.id == selectedId.value,
          orElse: () =>
              items?.isNotEmpty == true ? items!.first : Brand.empty(),
        ),
        itemBuilder: (context, item, isSelected) {
          return ItemCard(
            noBorderAndBg: true,
            gradient: isSelected
                ? [
                    appColors.cS(context).surfaceTint,
                    appColors.ms.white(context)
                  ]
                : null,
            imgHeight: 40,
            imgWidth: 40,
            labelStyle: TextStyles.h15Bold(context)?.copyWith(fontSize: 9),
            item: item,
            getImage: (b) => b.image!,
            getLabel: (b) => b.label,
          );
        },
        onSelect: (item) => selectedId.value = item.id,
      );
}
