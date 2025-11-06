import 'dart:io';

import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/product_maker_providers.dart';

class ProductMakerEditScreen<T> extends StatelessWidget {
  const ProductMakerEditScreen({super.key, required this.details});
  final T details;

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
      wantLeading: true,
      appToolbarHeight: -1,
      body: DetailsBody(initialDetails: details),
    );
  }

  static Future<void> bottomSheet<T>(BuildContext context, T details) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DetailsBottomSheetContent(details: details),
    );
  }
}

class _DetailsBottomSheetContent<T> extends StatelessWidget {
  const _DetailsBottomSheetContent({required this.details});
  final T details;

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
          child: DetailsBody(initialDetails: details),
        ),
      ],
    );
  }
}

class DetailsBody<T> extends HookConsumerWidget {
  const DetailsBody({super.key, required this.initialDetails});
  final T initialDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsState = useState<T>(initialDetails);
    Widget _buildEditor(T details) {
      if (details is Brand)
        return _BrandEditor(details, onChanged: (updated) {
          detailsState.value = updated as T;
          //print('Brand updated: ${updated.label}, image: ${updated.image}');
        });
      if (details is Category)
        return _CategoryEditor(
          details,
          onChanged: (updated) {
            detailsState.value = updated as T;
            //print(
            // 'Category updated: ${updated.label}, image: ${updated.image}');
          },
        );
      if (details is UnitDetail)
        return _UnitEditor(
          details,
          onChanged: (updated) {
            detailsState.value = updated as T;
            //print(
            // 'Unit updated: ${updated.unitShortForm}, full form: ${updated.unitFullForm}, type : ${updated.type.name}');
          },
        );
      if (details is PackagingType)
        return _PackagingEditor(
          details,
          onChanged: (updated) {
            detailsState.value = updated as T;
            //print(
            // 'Packaging updated: ${updated.label}, quantity: ${updated.quantity}');
          },
        );
      if (details is ProductType)
        return _ProductTypeEditor(
          details,
          onChanged: (updated) {
            detailsState.value = updated as T;
            //print(
            // 'Product type updated: ${updated.label}, quantity: ${updated.quantity}');
          },
        );
      return const Text('Unsupported type');
    }

    final editor = _buildEditor(detailsState.value);
    final title = getEditorTitle(initialDetails);
    final bool isNew = title.startsWith('Create');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyles.h7Bold(context)),
              ButtonX(
                label: isNew ? 'Create' : 'Update',
                icon: isNew ? Icons.add_circle_outline : Icons.save_outlined,
                iconFirst: false,
                onPressed: () async {
                  try {
                    await ref
                        .read(ProductMakerXProvider(mode: ProductMakerMode.edit)
                            .notifier)
                        .updateDetail(detailsState.value);
                    context.pop();
                  } catch (e) {
                    showMessageSnackbar(
                        context: context,
                        message: e.toString(),
                        maxLines: 2,
                        type: SnackBarType.error);
                  }
                },
              ),
            ],
          ),
          gapH8,
          editor,
        ],
      ),
    );
  }

  String getEditorTitle(T model) {
    if (model is Brand) return model.id.isEmpty ? 'Create Brand' : 'Edit Brand';
    if (model is Category)
      return model.id.isEmpty ? 'Create Category' : 'Edit Category';
    if (model is UnitDetail)
      return model.id.isEmpty ? 'Create Unit' : 'Edit Unit';
    if (model is PackagingType)
      return model.id.isEmpty ? 'Create Packaging' : 'Edit Packaging';
    if (model is ProductType)
      return model.id.isEmpty ? 'Create Type' : 'Edit Type';
    return 'Unsupported';
  }
}

class _BrandEditor extends HookWidget {
  const _BrandEditor(
    this.brand, {
    required this.onChanged,
  });

  final Brand brand;
  final void Function(Brand updated) onChanged;

  @override
  Widget build(BuildContext context) {
    final brandNameController = useTextEditingController(text: brand.label);

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: brandNameController,
          hintText: 'Enter your brand name',
          title: 'Brand Name',
          isMandatory: true,
          onChanged: (newBrandName) {
            onChanged(brand.copyWith(label: newBrandName));
          },
        ),
        ImageField(
          image: brand.image,
          title: 'Brand Image',
          onChange: (newImage) {
            if (newImage == null) {
              //print('Image cleared');
              onChanged(brand.copyWith(image: null));
            } else if (newImage is File) {
              //print('File picked: ${newImage.path}');
              onChanged(brand.copyWith(image: newImage.path));
            } else if (newImage is String) {
              //print('Image updated with URL: $newImage');
              onChanged(brand.copyWith(image: newImage));
            }
          },
        ),
      ],
    );
  }
}

class _CategoryEditor extends HookConsumerWidget {
  const _CategoryEditor(this.category, {required this.onChanged});

  final void Function(Category updated) onChanged;
  final Category category;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryNameController =
        useTextEditingController(text: category.label);

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: categoryNameController,
          hintText: 'Enter your category name',
          title: 'Category Name',
          isMandatory: true,
          onChanged: (newCategoryName) =>
              onChanged(category.copyWith(label: newCategoryName)),
        ),
        ImageField(
          image: category.image,
          title: 'Category Image',
          onChange: (newImage) {
            if (newImage == null) {
              //print('Image cleared');
              onChanged(category.copyWith(image: null));
            } else if (newImage is File) {
              //print('File picked: ${newImage.path}');
              onChanged(category.copyWith(image: newImage.path));
            } else if (newImage is String) {
              //print('Image updated with URL: $newImage');
              onChanged(category.copyWith(image: newImage));
            }
          },
        ),
      ],
    );
  }
}

class _UnitEditor extends HookConsumerWidget {
  const _UnitEditor(this.unit, {required this.onChanged});

  final void Function(UnitDetail updated) onChanged;
  final UnitDetail unit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();

    // controllers
    final shortCtrl = useTextEditingController(text: unit.unitShortForm);
    final fullCtrl = useTextEditingController(text: unit.unitFullForm);
    final baseCtrl = useTextEditingController(text: unit.displayBase);
    final factorCtrl = useTextEditingController(text: unit.factor.toString());

    // focus nodes
    final shortFocus = useFocusNode();
    final fullFocus = useFocusNode();
    final baseFocus = useFocusNode();
    final factorFocus = useFocusNode();

    // helper: scroll to focused field
    void scrollToFocused(FocusNode node) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!node.hasFocus) return;
        final ctx = node.context;
        if (ctx == null) return;
        Scrollable.ensureVisible(
          ctx,
          duration: const Duration(milliseconds: 250),
          alignment: 0.1, // 0.0 = top, 1.0 = bottom
        );
      });
    }

    // attach listeners (compact way)
    useEffect(() {
      void listener() {
        if (shortFocus.hasFocus) scrollToFocused(shortFocus);
        if (fullFocus.hasFocus) scrollToFocused(fullFocus);
        if (baseFocus.hasFocus) scrollToFocused(baseFocus);
        if (factorFocus.hasFocus) scrollToFocused(factorFocus);
      }

      for (var f in [shortFocus, fullFocus, baseFocus, factorFocus]) {
        f.addListener(listener);
      }
      return () {
        for (var f in [shortFocus, fullFocus, baseFocus, factorFocus]) {
          f.removeListener(listener);
        }
      };
    }, []);

    return Expanded(
      child: ListView(
        controller: scrollController,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        physics: const BouncingScrollPhysics(),
        children: [
          AppTextField(
            controller: shortCtrl,
            focusNode: shortFocus,
            hintText: 'Enter your unit short form name',
            title: 'Unit Short From Name',
            isMandatory: true,
            maxLength: 4,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
            ],
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            onChanged: (newUnitShortFormName) =>
                onChanged(unit.copyWith(unitShortForm: newUnitShortFormName)),
          ),
          AppTextField(
            controller: fullCtrl,
            focusNode: fullFocus,
            hintText: 'Enter your unit full form name',
            title: 'Unit Full From Name',
            isMandatory: true,
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            onChanged: (newUnitFullFormName) =>
                onChanged(unit.copyWith(unitFullForm: newUnitFullFormName)),
          ),
          AppTextField(
            controller: baseCtrl,
            focusNode: baseFocus,
            hintText: 'Enter display base (e.g., L, Kg, Piece)',
            title: 'Display Base',
            isMandatory: true,
            maxLength: 5,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))
            ],
            textInputAction: TextInputAction.next,
            textCapitalization: TextCapitalization.words,
            onChanged: (value) => onChanged(unit.copyWith(displayBase: value)),
          ),
          AppTextField(
            controller: factorCtrl,
            focusNode: factorFocus,
            hintText: 'Enter conversion factor (e.g., 0.001)',
            title: 'Factor',
            isMandatory: true,
            inputType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            ],
            onChanged: (value) {
              final parsed = double.tryParse(value) ?? 1.0;
              onChanged(unit.copyWith(factor: parsed));
            },
          ),
        ],
      ),
    );
  }
}

class _PackagingEditor extends HookConsumerWidget {
  const _PackagingEditor(this.packaging, {required this.onChanged});

  final void Function(PackagingType updated) onChanged;
  final PackagingType packaging;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final labelController = useTextEditingController(text: packaging.label);
    final quantityController =
        useTextEditingController(text: packaging.quantity.toString());

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: labelController,
          hintText: 'Enter your package name',
          title: 'Package Name',
          isMandatory: true,
          onChanged: (newPackageName) {
            //print('Package name changed: $newPackageName');
            onChanged(packaging.copyWith(label: newPackageName));
          },
        ),
        AppTextField(
          controller: quantityController,
          hintText: 'Enter your quantity per package',
          title: 'Quantity per Package',
          isMandatory: true,
          maxLength: 3,
          inputType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (newQtyStr) {
            final qty = int.tryParse(newQtyStr.trim());
            if (qty != null && qty >= 0) {
              onChanged(packaging.copyWith(quantity: qty));
            }
          },
        ),
      ],
    );
  }
}

class _ProductTypeEditor extends HookConsumerWidget {
  const _ProductTypeEditor(this.productType, {required this.onChanged});

  final void Function(ProductType updated) onChanged;
  final ProductType productType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shortCtrl = useTextEditingController(text: productType.shortForm);
    final fullCtrl = useTextEditingController(text: productType.fullForm);

    return SpacedColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: shortCtrl,
          hintText: 'Enter short form (e.g., Cup, Tub)',
          title: 'Short Form',
          isMandatory: true,
          maxLength: 5,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
          ],
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          onChanged: (value) =>
              onChanged(productType.copyWith(shortForm: value)),
        ),
        AppTextField(
          controller: fullCtrl,
          hintText: 'Enter full form (e.g., Cup, Tub)',
          title: 'Full Form',
          isMandatory: true,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          onChanged: (value) =>
              onChanged(productType.copyWith(fullForm: value)),
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
