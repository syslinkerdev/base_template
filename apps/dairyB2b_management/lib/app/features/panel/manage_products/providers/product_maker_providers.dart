import 'package:core/core.dart';
import 'package:repo/repo.dart';
import 'package:models/models.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/use_ful_funs.dart';

part 'product_maker_providers.g.dart';
part 'product_maker_providers.freezed.dart';

enum ProductMakerMode { view, edit }

extension ProductMakerModeApi on ProductMakerMode {
  String get name => switch (this) {
        ProductMakerMode.edit => 'Edit',
        ProductMakerMode.view => 'View',
      };

  Color get color => switch (this) {
        ProductMakerMode.edit => const Color(0xFF1976D2), // Blue 700
        ProductMakerMode.view => const Color(0xFF4CAF50), // Green 500
      };
}

@riverpod
class ProductMakerX extends _$ProductMakerX {
  @override
  FutureOr<ProductMakerState> build({required ProductMakerMode mode}) =>
      init(mode: mode);

  Future<ProductMakerState> init({required ProductMakerMode mode}) async {
    final maker = await ref.watch(fetchProductMakerProvider.future);
    return ProductMakerState(
        isEdited: false, mode: mode, maker: maker ?? ProductMaker.empty());
  }

  Future<void> publish() async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.maker == null) return;
    var maker = currentState.maker!;

    try {
      // Upload brand images if needed
      final updatedBrands = await Future.wait(maker.brands.map((brand) async {
        final imageUrl = await uploadIfNeeded(
          ref: ref,
          imagePath: brand.image,
          storagePath: StoragePathManger.brand(name: brand.id),
        );
        return brand.copyWith(image: imageUrl);
      }));

      // Upload category images if needed
      final updatedCategories =
          await Future.wait(maker.categories.map((cat) async {
        final imageUrl = await uploadIfNeeded(
          ref: ref,
          imagePath: cat.image,
          storagePath: StoragePathManger.category(name: cat.id),
        );
        return cat.copyWith(image: imageUrl);
      }));

      // Rebuild updated ProductMaker
      final updatedMaker = maker.copyWith(
        brands: updatedBrands,
        categories: updatedCategories,
      );

      // Upload final to Firestore
      await ref.read(firestoreServiceProvider).updateDocument(
            collectionPath: DbPathManager.appData(),
            documentId: ProductMaker.productMakerDocId,
            data: updatedMaker.toDocument(),
          );

      state = AsyncData(currentState.copyWith(
        maker: updatedMaker,
        isEdited: false,
      ));
    } catch (e, _) {
      //debugPrint('🔥 Publish error: $e\n$st');
      rethrow;
    }
  }

  Future<void> updateDetail<T>(T updatedDetail) async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.maker == null) return;

    final maker = currentState.maker!;

    if (updatedDetail is Brand) {
      return _updateTypedDetail<Brand>(
        detail: updatedDetail,
        currentList: maker.brands,
        idGenerator: () => Brand.next(maker.brands.length).id,
        updateMaker: (newList) => maker.copyWith(brands: newList),
      );
    } else if (updatedDetail is Category) {
      return _updateTypedDetail<Category>(
        detail: updatedDetail,
        currentList: maker.categories,
        idGenerator: () => Category.next(maker.categories.length).id,
        updateMaker: (newList) => maker.copyWith(categories: newList),
      );
    } else if (updatedDetail is PackagingType) {
      return _updateTypedDetail<PackagingType>(
        detail: updatedDetail,
        currentList: maker.packagingTypes,
        idGenerator: () => PackagingType.next(maker.packagingTypes.length).id,
        updateMaker: (newList) => maker.copyWith(packagingTypes: newList),
      );
    } else if (updatedDetail is UnitDetail) {
      return _updateTypedDetail<UnitDetail>(
        detail: updatedDetail,
        currentList: maker.units,
        idGenerator: () => UnitDetail.next(maker.units.length).id,
        updateMaker: (newList) => maker.copyWith(units: newList),
      );
    } else if (updatedDetail is ProductType) {
      return _updateTypedDetail<ProductType>(
        detail: updatedDetail,
        currentList: maker.productTypes,
        idGenerator: () => ProductType.next(maker.productTypes.length).id,
        updateMaker: (newList) => maker.copyWith(productTypes: newList),
      );
    } else {
      throw UnsupportedError('Unsupported type for updateDetail: $T');
    }
  }

  Future<void> _updateTypedDetail<T extends Object>({
    required T detail,
    required List<T> currentList,
    required String Function() idGenerator,
    required ProductMaker Function(List<T>) updateMaker,
  }) async {
    final currentState = state.valueOrNull;
    if (currentState == null || currentState.maker == null) return;

    final dynamic dynamicDetail = detail;
    if (!(dynamicDetail.id as String).containsValidValue) {
      detail = dynamicDetail.copyWith(id: idGenerator()) as T;
    }

    final error = validateDetail(detail);
    if (error != null) throw error;

    final updatedList = _updateList(currentList, detail);
    state = AsyncData(currentState.copyWith(
      isEdited: true,
      maker: updateMaker(updatedList),
    ));
  }

  List<T> _updateList<T>(List<T> list, T updatedItem) {
    final index = list.indexWhere((item) {
      final dynamic itemId = (item as dynamic).id;
      final dynamic updatedId = (updatedItem as dynamic).id;
      return itemId == updatedId;
    });

    if (index == -1) return [...list, updatedItem];
    return [...list.sublist(0, index), updatedItem, ...list.sublist(index + 1)];
  }

  String? validateDetail(Object detail) {
    if (detail is Brand) return detail.validate();
    if (detail is Category) return detail.validate();
    if (detail is PackagingType) return detail.validate();
    if (detail is UnitDetail) return detail.validate();
    if (detail is ProductType) return detail.validate();
    // Add others here...
    return 'Unsupported detail type';
  }
}

@freezed
abstract class ProductMakerState with _$ProductMakerState {
  const factory ProductMakerState(
      {required bool isEdited,
      required ProductMakerMode mode,
      ProductMaker? maker}) = _ProductMakerState;

  factory ProductMakerState.empty() {
    return ProductMakerState(
        isEdited: false,
        mode: ProductMakerMode.view,
        maker: ProductMaker.empty());
  }
}
