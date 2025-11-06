import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';

part 'client_order_lookup_provider.g.dart';

@riverpod
class ClientOrderLookup extends _$ClientOrderLookup {
  @override
  FutureOr<ClientOrderLookupState> build() =>
      const ClientOrderLookupState.initial();

  /// Validates, then checks client & order.
  Future<void> checkClientOrderFlow(String rawPhoneNumber) async {
    state = const AsyncValue.loading();

    try {
      if (rawPhoneNumber.isEmpty) {
        throw 'Phone number cannot be empty. Please enter a valid phone number.';
      }
      // 👉 Clean: remove +91, spaces, dashes etc.
      final phoneNumber = rawPhoneNumber
          .replaceAll('+91', '')
          .replaceAll(RegExp(r'\s+'), '')
          .replaceAll('-', '');

      final phoneRegex = RegExp(r'^\d{10}$');
      if (!phoneRegex.hasMatch(phoneNumber)) {
        throw 'Invalid phone number. Please enter a valid 10-digit number.';
      }

      final repo = ref.read(dairyB2bRepositoryProvider);

      final user = await repo.fetchUserByComparisonPhone(
        phoneNumber: '+91$phoneNumber',
      );
      if (user == null) {
        throw '❌ No client found with this phone number.';
      }

      final selfUid = ref.read(appStateXProvider).uId;

      if (user.uid != selfUid && user.role == Role.admin) {
        throw '⚠️ This phone number belongs to another admin.\nYou should not create or edit orders for admin accounts.';
      }

      if (user.role == Role.appManagement) {
        throw '⚠️ This phone number belongs to an App Management account.\nYou should not create or edit orders for management accounts.';
      }

      // Cache the user for further operations
      GlobalCacheService.instance.setClient(user);
      final order =
          await repo.fetchSingleOrder(uId: user.uid, day: DateTime.now());

      state = AsyncValue.data(
        ClientOrderLookupState(
          foundUser: true,
          clientUid: user.uid,
          foundOrder: order == null ? false : true,
          editId: order?.orderId ?? '',
          cartItems: order?.orderedProducts ?? [],
          message: successMessage(user, order),
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  String successMessage(UserX? user, OrderX? order) {
    final adminUid = ref.read(appStateXProvider).uId;

    if (user?.uid == adminUid) {
      return '👀 We see you searched your own number.\nNo worries, carry on!';
    }

    if (order == null) {
      return '✅ Client found. No order for today.\nYou can create a new order.';
    } else {
      return '✅ Client found & order exists for today.\nYou can manage this order.';
    }
  }

  Future<void> deleteOrder() async {
    // Put state in loading first
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final currentState = state.value;

      // Double-check safety
      if (currentState == null) {
        throw 'No client/order loaded.';
      }

      if (!currentState.foundUser || !currentState.foundOrder) {
        throw '❌ Cannot delete: no order found for the selected client.';
      }

      if (currentState.editId.isEmpty) {
        throw '❌ Cannot delete: order ID is missing.';
      }

      // Delete the document from Firestore
      await ref.read(firestoreServiceProvider).deleteDocument(
            collectionPath: DbPathManager.orders(),
            documentId: currentState.editId,
          );

      // Return a fresh state
      return const ClientOrderLookupState.initial();
    });
  }
}

class ClientOrderLookupState {
  final bool foundUser;
  final bool foundOrder;
  final String clientUid;
  final String message;
  final String editId;
  final List<CartItem> cartItems;

  const ClientOrderLookupState({
    this.foundUser = false,
    this.foundOrder = false,
    this.clientUid = '',
    this.message = '',
    this.editId = '',
    this.cartItems = const [],
  });

  const ClientOrderLookupState.initial() : this();
}
