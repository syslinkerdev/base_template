import 'package:flutter/material.dart';
import 'package:core/core.dart';

class OrderSloganFooter extends StatelessWidget {
  const OrderSloganFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order\nwith ease!',
          style:
              TextStyles.h1Gray(context)?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Crafted with 💜 in Hyderabad,India',
          style: TextStyles.h8Gray(context),
        ),
        Row(
          children: [
            Text('Orders',
                style: TextStyles.h5Gray(context)
                    ?.copyWith(fontWeight: FontWeight.bold)),
            AppVersionText()
          ],
        ),
      ],
    );
  }
}

class OrderShortSlogan extends StatelessWidget {
  const OrderShortSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Order with ease!',
      style: TextStyles.h3Gray(context)
          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 42),
    );
  }
}

class ManagementSloganFooter extends StatelessWidget {
  const ManagementSloganFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manage\nwith ease!',
          style:
              TextStyles.h1Gray(context)?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Crafted with 💼 in Hyderabad, India',
          style: TextStyles.h8Gray(context),
        ),
        Row(
          children: [
            Text('Management',
                style: TextStyles.h5Gray(context)
                    ?.copyWith(fontWeight: FontWeight.bold)),
            AppVersionText()
          ],
        ),
      ],
    );
  }
}

class ManagementShortSlogan extends StatelessWidget {
  const ManagementShortSlogan({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Manage with control!',
      style: TextStyles.h3Gray(context)
          ?.copyWith(fontWeight: FontWeight.bold, fontSize: 42),
    );
  }
}
