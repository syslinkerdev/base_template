part of 'package:repo/repo.dart';

@Riverpod(keepAlive: true)
class ProductsStreamX extends _$ProductsStreamX {
  @override
  FutureOr<List<Product>> build() async {
    final repo = ref.read(dairyB2bRepositoryProvider);

    try {
      final initial = await repo.productsStream().first;
      final filtered = initial.whereType<Product>().toList().nonDeleteProducts;
      print(initial.length);
      state = AsyncValue.data(filtered);

      // print('✅ ProductsStream initial loaded: ${filtered.length} products');

      repo.productsStream().listen(
        (products) {
          state = AsyncValue.data(
              products.whereType<Product>().toList().nonDeleteProducts);
          // print('📡 ProductsStream updated: ${state.valueOrNull?.length ?? 0}');
        },
        onError: (err) {
          // print('❌ ProductsStream error: $err');
        },
      );

      return filtered;
    } catch (err) {
      // print('❌ ProductsStream initial load failed: $err');
      throw err;
    }
  }
}

@Riverpod(keepAlive: true)
class DiscountSectionsStreamX extends _$DiscountSectionsStreamX {
  @override
  FutureOr<List<DiscountSection>> build() async {
    final repo = ref.read(dairyB2bRepositoryProvider);

    try {
      final stream = repo.DiscountSectionsStream();
      final initial = await stream.first;
      final filtered = initial.whereType<DiscountSection>().toList();

      // //print(
      //     '✅ GDiscountSectionsStream initial loaded: ${filtered.length} sections');
      state = AsyncValue.data(filtered);

      stream.listen(
        (sections) {
          final filtered = sections.whereType<DiscountSection>().toList();
          state = AsyncValue.data(filtered);
        },
        onError: (err) {
          //print('❌ GDiscountSectionsStream error: $err');
        },
      );

      return filtered;
    } catch (err) {
      //print('❌ GDiscountSectionsStream initial load failed: $err');
      throw err;
    }
  }

  DiscountSection get globalDisSection => (state.value ?? []).firstWhere(
        (section) => section.id == DiscountSectionHelpers.GlobalDiscountsDocId,
        orElse: () => DiscountSection.empty(),
      );
}
