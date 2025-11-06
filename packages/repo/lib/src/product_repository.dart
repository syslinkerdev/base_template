part of 'package:repo/repo.dart';

extension ProductRepository on DairyB2bRepository {
  Stream<List<Product>> productsStream() =>
      _service.getDocumentsStream<Product>(
        collectionPath: DbPathManager.products(),
        converter: (snapshot) {
          final raw = snapshot.data();
          // //print('🔥 Raw: $raw');
          final product = Product.fromJson(raw!);
          return product;
        },
      );

  // To fetch list of Products by ids
  Future<List<Product>> fetchProductsByIds({required List<String> ids}) async {
    final response = await _service.getDocumentsByFilter<Product>(
      collectionPath: DbPathManager.products(),
      fieldName: DbStandardFields.id,
      fieldValues: ids,
      converter: (snapshot) => Product.fromJson(snapshot.data()),
    );
    // //print('response $response');
    return response;
  }

  Stream<List<DiscountSection>> DiscountSectionsStream() =>
      _service.getDocumentsStream<DiscountSection>(
        collectionPath: DbPathManager.discountSections(),
        converter: (snapshot) {
          final raw = snapshot.data();
          // //print('🔥 Raw DiscountSection: $raw');
          final section = DiscountSection.fromJson(raw!);
          return section;
        },
      );
}
