import 'package:flutter/material.dart';

enum CartMode {
  newOrder,
  edit,
  basket,
  editBasket,
  // forClient, // Admin placing for client
  // editClient, // Admin editing for client
}

extension CartModeApi on CartMode {
  String get name => switch (this) {
        CartMode.newOrder => 'New Order',
        CartMode.edit => 'Edit Order',
        CartMode.basket => 'Smart Basket',
        CartMode.editBasket => 'Edit Basket',
        // CartMode.forClient => 'For Client',
        // CartMode.editClient => 'Edit Client',
      };

  Color get color => switch (this) {
        CartMode.newOrder => const Color(0xFF50C878), // 🟩 Emerald Green
        CartMode.edit => const Color(0xFFFFBF00), // 🟧 Amber Orange
        CartMode.basket => const Color(0xFF87CEEB), // 🟦 Sky Blue
        CartMode.editBasket => const Color(0xFFD8BFD8), // 🟪 Thistle Purple
        // CartMode.forClient => const Color(0xFFA7F2E0), // 🟦 Pale Aqua
        // CartMode.editClient => const Color(0xFFE3C6A8), // 🟫 Light Sand
      };

  /// Button label depending on mode
  String get actionButtonLabel => switch (this) {
        CartMode.newOrder => 'Place Order',
        CartMode.edit => 'Update Order',
        CartMode.basket => 'Create Basket',
        CartMode.editBasket => 'Update Basket',
        // CartMode.forClient => 'Order for Client',
        // CartMode.editClient => 'Edit for Client',
      };
}
