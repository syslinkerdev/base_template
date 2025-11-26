import 'package:flutter/material.dart';

enum CartMode {
  newOrder,
  edit,
  basket,
  editBasket,
}

extension CartModeApi on CartMode {
  String get name => switch (this) {
        CartMode.newOrder => 'New Order',
        CartMode.edit => 'Edit Order',
        CartMode.basket => 'Smart Basket',
        CartMode.editBasket => 'Edit Basket',
      };

  Color get color => switch (this) {
        CartMode.newOrder => const Color(0xFF50C878), // 🟩 Emerald Green
        CartMode.edit => const Color(0xFFFFBF00), // 🟧 Amber Orange
        CartMode.basket => const Color(0xFF87CEEB), // 🟦 Sky Blue
        CartMode.editBasket => const Color(0xFFD8BFD8), // 🟪 Thistle Purple
      };

  /// Button label depending on mode
  String get actionButtonLabel => switch (this) {
        CartMode.newOrder => 'Place Order',
        CartMode.edit => 'Update Order',
        CartMode.basket => 'Create Basket',
        CartMode.editBasket => 'Update Basket',
      };
}
