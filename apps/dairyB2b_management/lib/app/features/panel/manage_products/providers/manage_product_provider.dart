import 'package:flutter/material.dart';
import 'package:repo/repo.dart';
import 'package:uuid/uuid.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_management/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/extras/providers/discount_sections_cud.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/use_ful_funs.dart';

part 'manage_product_provider.g.dart';
part 'manage_product_provider.freezed.dart';

enum ManageProductMode { create, edit, view }

extension ManageProductModeApi on ManageProductMode {
  String get name => switch (this) {
        ManageProductMode.create => 'Create',
        ManageProductMode.edit => 'Edit',
        ManageProductMode.view => 'View',
      };

  Color get color => switch (this) {
        ManageProductMode.create => Colors.greenAccent.shade700,
        ManageProductMode.edit => Colors.amber.shade800,
        ManageProductMode.view => Colors.blueGrey.shade700,
      };

  Color get background => switch (this) {
        ManageProductMode.create => Colors.green.shade50,
        ManageProductMode.edit => Colors.amber.shade50,
        ManageProductMode.view => Colors.blueGrey.shade50,
      };
}

@riverpod
class ManageProduct extends _$ManageProduct {
  @override
  FutureOr<ManageProductState> build() {
    //print('build called...............');
    // ✅ Prevent wiping out manually set state
    return state.valueOrNull ?? ManageProductState.empty();
  }

  void updateFields({
    String? name,
    double? price,
    double? unitQty,
    int? packSize,
    double? discountValue,
    String? image,
    ProductStatus? status,
  }) {
    final current = state.value;
    final currentPro = current?.product ?? Product.empty();
    final currentDis = current?.discount ?? Discount.empty();
    if (current == null) return;

    final updatedName = name ?? currentPro.name;
    final updatedQty = unitQty ?? currentPro.unitDetails.value;

    // Generate shortForm and searchKey
    final shortForm = _generateShortForm(
      brandName: currentPro.brand.label,
      productName: updatedName,
    );

    final searchKey = _generateSearchKey(
      shortForm: shortForm,
      categoryLabel: currentPro.category.label,
      unitQty: updatedQty,
    );

    final updatedPro = currentPro.copyWith(
      name: updatedName,
      price: price ?? currentPro.price,
      unitDetails: currentPro.unitDetails.copyWith(value: updatedQty),
      packSize: packSize ?? currentPro.packSize,
      image: image ?? currentPro.image,
      status: status ?? currentPro.status,
      shortForm: shortForm,
      searchKey: searchKey,
    );

    final updatedDis = currentDis.copyWith(
      discount: discountValue ?? currentDis.discount,
    );

    proUpdate(product: updatedPro, discount: updatedDis);
  }

  Future<void> proUpdate({
    Product? product,
    Discount? discount,
    ManageProductMode? mode,
  }) async {
    final current = state.value ?? ManageProductState.empty();

    final newState = await current.copyWith(
      product: product ?? current.product,
      discount: discount ?? current.discount,
      mode: mode ?? current.mode,
    );
    //print('🔄 Calling state = AsyncValue.data(...)');
    //print('newState --- ${newState.discount?.discount}');
    state = AsyncValue.data(newState);
    //print('new AsyncData state ----  : ${state.value?.product?.name}');
  }

  Future<void> updateOptions(
      {Brand? brand,
      Category? category,
      UnitDetail? unitDetail,
      PackagingType? packaging,
      ProductType? productType}) async {
    final current = state.value ?? ManageProductState.empty();
    final isOk = await _validateStep1(brand, category, unitDetail, packaging);
    if (isOk != null) {
      throw isOk;
    }
    final product = current.product?.copyWith(
      brand: brand ?? Brand.empty(),
      category: category ?? Category.empty(),
      unitDetails: unitDetail ?? UnitDetail.empty(),
      quickAddOptions: packaging == null || packaging.isEmpty
          ? []
          : generateQuickAddOptions(packaging),
      productType: productType ?? ProductType.empty(),
    );
    final newState = current.copyWith(product: product);
    state = AsyncValue.data(newState);
  }

  Future<String?> _validateStep1(Brand? brand, Category? category,
      UnitDetail? unitDetail, PackagingType? packaging) async {
    if (brand == null || brand.isEmpty) {
      throw 'Brand is required';
    }
    if (category == null || category.isEmpty) {
      throw 'Category is required';
    }
    if (unitDetail == null || unitDetail.isEmpty) {
      throw 'Unit detail is required';
    }
    if (packaging == null || packaging.isEmpty) {
      throw 'Packaging type is required';
    }
    //print('Successfully completed validation!');
    return null;
  }

  String _generateShortForm({
    required String brandName,
    required String productName,
  }) {
    final brandInitial =
        brandName.trim().isNotEmpty ? brandName[0].toUpperCase() : '';
    final productInitials = productName
        .trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .join();
    return '$brandInitial$productInitials';
  }

  String _generateSearchKey({
    required String shortForm,
    required String categoryLabel,
    required double unitQty,
  }) {
    final catInitial =
        categoryLabel.trim().isNotEmpty ? categoryLabel[0].toUpperCase() : 'X';
    final qtyStr = unitQty.toInt().toString().padLeft(4, '0');
    return '$shortForm-$catInitial-$qtyStr';
  }

  Future<void> publish() async {
    if (state.value?.mode == ManageProductMode.edit) {
      await updateExistingProduct();
    } else {
      await publishNewProduct();
    }
  }

  Future<void> publishNewProduct() async {
    final current = state.value;
    if (current == null) throw 'Invalid state';

    final product = current.product;
    final discount = current.discount;
    final user = await getUserX();
    final now = DateTime.now();
    final String productId = const Uuid().v4();

    final error = _validateStep2(product, discount);
    if (error != null) throw error;

    final imageUrl = await uploadIfNeeded(
      ref: ref,
      imagePath: product?.image ?? '',
      storagePath: StoragePathManger.product(
        brandName: product!.brand.label.toLowerCase(),
        productName: productId,
      ),
    );

    final finalProduct = product.copyWith(
      id: productId,
      createdBy: "${user.firstName} ${user.lastName}",
      createdAt: now,
      searchKey: '${product.searchKey}-${productId.substring(0, 4)}',
      image: imageUrl ?? product.image,
    );
    final finalDiscount = await pushDiscountIfNeeded(
      product: finalProduct,
      discount: discount,
      user: user,
      now: now,
    );

    await ref.read(firestoreServiceProvider).setDocument(
          collectionPath: DbPathManager.products(),
          documentId: finalProduct.id,
          data: finalProduct.toDocument(),
        );

    state = AsyncData(current.copyWith(
      product: finalProduct,
      discount: finalDiscount,
    ));
  }

  Future<void> updateExistingProduct() async {
    final current = state.value;
    if (current == null) throw 'Invalid state';

    final product = current.product;
    final discount = current.discount;
    final user = await getUserX();

    final error = _validateStep2(product, discount);
    if (error != null) throw error;

    final now = DateTime.now();

    final imageUrl = await uploadIfNeeded(
      ref: ref,
      imagePath: product?.image ?? '',
      storagePath: StoragePathManger.product(
        brandName: product!.brand.label.toLowerCase(),
        productName: product.id,
      ),
    );

    final finalProduct = product.copyWith(
      updatedBy: "${user.firstName} ${user.lastName}",
      updatedAt: now,
      image: imageUrl ?? product.image,
      searchKey: '${product.searchKey}-${product.id.substring(0, 4)}',
    );

    final finalDiscount = await pushDiscountIfNeeded(
      product: finalProduct,
      discount: discount,
      user: user,
      now: now,
    );

    await ref.read(firestoreServiceProvider).updateDocument(
          collectionPath: DbPathManager.products(),
          documentId: finalProduct.id,
          data: finalProduct.toDocument(),
        );

    state = AsyncData(current.copyWith(
      product: finalProduct,
      discount: finalDiscount,
    ));
  }

  Future<Discount?> pushDiscountIfNeeded({
    required Product product,
    required Discount? discount,
    required UserX user,
    required DateTime now,
  }) async {
    if (discount == null) return null;

    final globalDisCud = ref.read(discountSectionsCudProvider().notifier);

    final isNew = !discount.id.containsValidValue;
    if (isNew && discount.discount == 0) {
      return discount;
    }
    if (isNew) {
      // ➕ New Discount
      final newDiscount = Discount.next(
        product,
        discount: discount.discount,
        productPath: DbPathManager.product(productId: product.id),
      ).copyWith(status: product.status);

      await globalDisCud.upsertDiscount(newDiscount);
      return newDiscount;
    } else {
      // 🛠 Existing discount: update or soft delete
      final isSoftDelete = discount.discount == 0;

      final updatedDiscount = discount.copyWith(
          status: isSoftDelete ? ProductStatus.deleted : discount.status);
      await globalDisCud.upsertDiscount(updatedDiscount);
      return updatedDiscount;
    }
  }

  Future<UserX> getUserX() async {
    final uId = ref.read(appStateXProvider).uId;

    // Step 1: Try from cache
    final cached = GlobalCacheService.instance.getUser();
    if (cached != null) {
      //print('✅ Got user from cache');
      return cached;
    }

    // Step 2: Fetch from Firestore
    final userAsync = await ref.read(fetchUserProvider(documentId: uId).future);
    final user = await userAsync;
    if (user == null) throw 'User not found in Firestore';

    // Step 3: Cache for next time (optional)
    GlobalCacheService.instance.setUser(user);
    //print('📥 Fetched user from Firestore and cached');

    return user;
  }

  String? _validateStep2(Product? product, Discount? discount) {
    if (product == null) return 'Product is empty';
    if (discount == null) return 'Discount is empty';

    if (product.name.trim().isEmpty) return 'Product name is required';
    if (product.price <= 0) return 'Price must be greater than zero';
    if (product.unitDetails.value <= 0) return 'Unit quantity must be valid';
    if (product.packSize <= 0) return 'Pack size required';
    if (!product.image.containsValidValue)
      return 'Image URL is required'; // ✅ Discount validations
    final discountValue = discount.discount;
    if (discountValue > product.price) {
      return 'Discount cannot be greater than the product price';
    }

    return null;
  }

  Future<void> clear() async {
    state = await AsyncValue.data(ManageProductState.empty());
  }

  Future<String?> deleteProAndDis() async {
    final user = await getUserX();
    final String userName = "${user.firstName} ${user.lastName}";
    final now = DateTime.now();

    final current = state.value;
    if (current == null || current.product == null) {
      return 'Invalid state or product';
    }

    final product = current.product!;
    final discount = current.discount;
    final firestore = ref.read(firestoreServiceProvider);

    try {
      // Soft delete the product
      await firestore.updateDocument(
        collectionPath: DbPathManager.products(),
        documentId: product.id,
        data: product
            .copyWith(
                status: ProductStatus.deleted,
                updatedBy: userName,
                updatedAt: now)
            .toDocument(),
      );

      // Soft delete the discount, if present
      if (discount != null && discount.id.containsValidValue) {
        await ref
            .read(discountSectionsCudProvider().notifier)
            .upsertDiscount(discount.copyWith(status: ProductStatus.deleted));
      }

      return null;
    } catch (e, _) {
      return e.toString();
    }
  }

  Future<String?> quickUpdateProAndDis({
    double? price,
    double? discountValue,
    int? packSize,
    ProductStatus? status,
  }) async {
    //print('pric -at fun--  ${price}');
    //print('dis --  ${discountValue}');
    //print('min ---  ${minBuyQty}');
    // Early validation
    final validationError = _validateQuick(
        price: price, packSize: packSize, discountValue: discountValue);
    if (validationError != null) return validationError;

    final current = state.value;
    if (current == null || current.product == null) {
      return 'Invalid state or product';
    }

    final product = current.product!;
    final discount = current.discount?.copyWith(
      discount: discountValue ?? 0,
      status: status ?? current.discount?.status ?? ProductStatus.activePublic,
    );
    final user = await getUserX();
    final now = DateTime.now();
    final firestore = ref.read(firestoreServiceProvider);

    try {
      final productUpdate = <String, dynamic>{
        if (price != null) DbStandardFields.price: price,
        if (packSize != null) DbStandardFields.packSize: packSize,
        if (status != null)
          DbStandardFields.status: ProductStatusConverter.toJson(status),
      };

      // Only update if any product field is modified
      if (productUpdate.isNotEmpty) {
        await firestore.updateDocument(
          collectionPath: DbPathManager.products(),
          documentId: product.id,
          data: productUpdate,
        );
      }

      // Handle discount updates
      await pushDiscountIfNeeded(
        product: product,
        discount: discount,
        user: user,
        now: now,
      );

      return null;
    } catch (e, _) {
      return e.toString();
    }
  }

  String? _validateQuick({
    double? price,
    int? packSize,
    double? discountValue,
  }) {
    if (price == null || price <= 0) {
      return 'Price must be greater than zero';
    }
    if (packSize == null || packSize <= 0) {
      return 'Minimum buy quantity required';
    }
    if (discountValue != null && discountValue > price) {
      return 'Discount cannot be greater than price';
    }
    return null;
  }
}

@freezed
abstract class ManageProductState with _$ManageProductState {
  const factory ManageProductState({
    Product? product,
    Discount? discount,
    required ManageProductMode mode,
  }) = _ManageProductState;

  factory ManageProductState.empty() {
    return ManageProductState(
      product: Product.empty(),
      discount: Discount.empty(),
      mode: ManageProductMode.create,
    );
  }
}
