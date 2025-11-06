import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discount_sections_cud.g.dart';

@riverpod
class DiscountSectionsCud extends _$DiscountSectionsCud {
  late final FirestoreService service;
  late final String _docPath;

  @override
  void build({String? docPath}) {
    service = ref.read(firestoreServiceProvider);
    _docPath = docPath ??
        DbPathManager.discountSection(
          sectionId: DiscountSectionHelpers.GlobalDiscountsDocId,
        );
  }

  // Discount CUD

  /// ➕ Add or update a Discount entry
  Future<void> upsertDiscount(Discount discount) async {
    final docId = _docPath.split('/').last;
    final doc = await service.getDocument(
      collectionPath: DbPathManager.discountSections(),
      documentId: docId,
      converter: (snapshot) {
        final data = snapshot.data();
        if (data != null) {
          return DiscountSection.fromJson(data);
        } else {
          return null;
        }
      },
    );
    if (doc == null) {
      final section = DiscountSection(
          id: docId.snakeCase,
          name: docId.toTitleCase,
          status: docId == DiscountSectionHelpers.GlobalDiscountsDocId
              ? DiscountSectionStatus.base
              : DiscountSectionStatus.custom,
          productDiscounts: {discount.id: discount},
          meta: MetaDataX(createdBy: 'System', createdAt: DFU.now()));

      await service.setDocument(
        collectionPath: DbPathManager.discountSections(),
        documentId: docId,
        data: section.toDocument(),
      );
    } else {
      await service.updateDocumentFields(documentPath: _docPath, data: {
        DbStandardFields.productDiscounts: {discount.id: discount.toDocument()},
        'meta': {
          DbStandardFields.updatedAt: DFU.now(),
          DbStandardFields.updatedBy: 'System'
        }
      });
    }
  }

  /// 🔁 Replace the entire discounts map
  Future<void> setAllDiscounts(Map<String, Discount> discountsMap) {
    return service.updateDocumentFields(
      documentPath: _docPath,
      data: {
        DbStandardFields.productDiscounts:
            discountsMap.map((key, value) => MapEntry(key, value.toDocument())),
      },
    );
  }

  // Discount Section CUD
  Future<void> upsertDiscountSection(DiscountSection section) async {
    await service.setDocument(
        collectionPath: DbPathManager.discountSections(),
        documentId: section.id,
        data: section.toDocument());
  }

  Future<void> deleteDiscountSection(String sectionId) async {
    await service.deleteDocument(
        collectionPath: DbPathManager.discountSections(),
        documentId: sectionId);
  }
}
