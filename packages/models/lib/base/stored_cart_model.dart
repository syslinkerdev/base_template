import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:models/models.dart';

part 'stored_cart_model.freezed.dart';
part 'stored_cart_model.g.dart';
// If admin creates/edits for a client
// For smart basket drafts
// Order or basket ID (context decides)

@freezed
abstract class StoredCart with _$StoredCart {
  const factory StoredCart({
    required List<CartItem> items,
    required CartMode mode,
    String? editId,
    String? basketName,
    String? clientUid,
  }) = _StoredCart;

  factory StoredCart.empty() => const StoredCart(
        items: [],
        mode: CartMode.newOrder,
      );

  static const String storedCartKey = 'stored_cart';

  factory StoredCart.fromJson(Map<String, dynamic> json) =>
      _$StoredCartFromJson(json);
}
