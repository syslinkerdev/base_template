import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/panel/clients_and_admins/ui/clients_and_admins_view.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/product_maker_screen.dart';
import 'package:dairyB2b_management/router/app_route_paths.dart';
import 'package:dairyB2b_management/app/features/panel/common/common_area.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/ui/view_products.dart';
import 'package:dairyB2b_management/app/features/panel/manage_products/providers/product_maker_providers.dart';

class Panel extends ConsumerWidget {
  const Panel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldX(
      wantLeading: false,
      title: '${AppEnv.companyName} - Panel',
      appToolbarHeight: -1,
      titleStyle: TextStyles.h5Bold(context)
          ?.copyWith(color: appColors.ms.black(context)),
      body: RefreshIndicator(
        onRefresh: () async => _refresh(ref),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SpacedColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            defaultHeight: 0,
            children: [
              HeadingLineFade(label: '🗂️ Manage Products'),
              PanelButtonGrid(buttons: productButtons),
              HeadingLineFade(label: '👥 Clients & Admins'),
              PanelButtonGrid(buttons: userAndAdminsButtons),
              HeadingLineFade(label: '📊 Order Reports'),
              PanelButtonGrid(buttons: orderReportsButtons),
              HeadingLineFade(label: '🧩 Extras'),
              PanelButtonGrid(buttons: extrasButtons),
              ManagementShortSlogan()
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> _refresh(WidgetRef ref) async {
    return;
  }
}

class PanelButtonGrid extends StatelessWidget {
  final List<PanelButtonData> buttons;

  const PanelButtonGrid({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicList<PanelButtonData>(
      isGridView: true,
      items: buttons,
      gridCrossAxisCount: 4,
      spacing: 4,
      onSelect: (buttonData) => buttonData.onTap?.call(context),
      itemBuilder: (context, buttonData, isSelected) {
        return SpacedColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ContainerX(
              width: 45,
              height: 45,
              margin: EdgeInsetsGeometry.zero,
              padding: EdgeInsetsGeometry.zero,
              child: Center(
                child: Icon(
                  buttonData.icon,
                  size: 28,
                  color: buttonData.color ?? Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            Text(
              buttonData.label,
              textAlign: TextAlign.center,
              style: TextStyles.h15Bold(context),
            )
          ],
        );
      },
    );
  }
}

class PanelButtonData {
  final String label;
  final IconData icon;
  final Color? color;
  final String? description;
  final void Function(BuildContext context)? onTap;

  const PanelButtonData(
      {required this.label,
      required this.icon,
      this.description,
      this.onTap,
      this.color});
}

final List<PanelButtonData> productButtons = [
  PanelButtonData(
    label: 'Create',
    icon: Icons.add_box_rounded,
    color: Colors.green.shade700, // Positive, fresh
    description: 'Add a new product',
    onTap: (context) => AppRoute.productMaker.push(context,
        extra: ProductMakerScreenArgs(mode: ProductMakerMode.view)),
  ),
  PanelButtonData(
    label: 'Edit',
    icon: Icons.edit_square,
    color: Colors.blue.shade700, // Info, safe to modify
    description: 'Modify product details',
    onTap: (context) => AppRoute.viewProducts
        .push(context, extra: ViewProductsArgs(mode: ProductsViewMode.edit)),
  ),
  PanelButtonData(
    label: 'View',
    icon: Icons.view_list_rounded,
    color: Colors.teal.shade700, // Neutral, calm to read
    description: 'See all products',
    onTap: (context) => AppRoute.viewProducts.push(context),
  ),
  PanelButtonData(
    label: 'Product Maker',
    icon: Icons.category_rounded,
    color: Colors.purple.shade700,
    description: 'Edit brands, categories & packaging types.',
    onTap: (context) => AppRoute.productMaker.push(context,
        extra: ProductMakerScreenArgs(mode: ProductMakerMode.edit)),
  ),
//  Mass Update = Modify many at once
// Bulk edit prices, visibility, discount %, stock, etc.

// You show a filtered product list with checkboxes, and apply one change to many.

// Useful for admin cases like:

// "Make these 10 products private"

// "Add 10% discount to this category"

// "Archive all out-of-stock products"

// Mass update is not product editing. It's product patching.
  // PanelButtonData(
  //   label: 'Mass\nUpdate',
  //   icon: Icons.auto_fix_high_rounded,
  //   color: Colors.orange.shade700,
  //   description: 'Batch update prices, discounts, or visibility',
  //   onTap: (context) {},
  // ),
  // IN next version ok..

  // PanelButtonData(
  //   label: 'Bulk Import',
  //   icon: Icons.file_upload_rounded,
  //   color: Colors.deepPurple.shade600,
  //   description: 'Upload multiple products from Excel or CSV',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Export List',
  //   icon: Icons.file_download_rounded,
  //   color: Colors.teal.shade600,
  //   description: 'Download full product catalog',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Clone',
  //   icon: Icons.copy_rounded,
  //   color: Colors.indigo.shade600,
  //   description: 'Duplicate product details for quick new product setup',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Drafts',
  //   icon: Icons.insert_drive_file_rounded,
  //   color: Colors.grey.shade700,
  //   description: 'Manage incomplete or pending products',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Changes Log',
  //   icon: Icons.history_rounded,
  //   color: Colors.brown.shade600,
  //   description: 'Track changes made to products',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Feature',
  //   icon: Icons.star_rate_rounded,
  //   color: Colors.amber.shade700,
  //   description: 'Mark products as featured or special',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Tags',
  //   icon: Icons.label_rounded,
  //   color: Colors.pink.shade400,
  //   description: 'Add tags for easier search/filter',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Supplier',
  //   icon: Icons.store_mall_directory_rounded,
  //   color: Colors.blueGrey.shade600,
  //   description: 'Manage supplier info linked to product',
  //   onTap: (context) {},
  // ),
];

final List<PanelButtonData> userAndAdminsButtons = [
  PanelButtonData(
    label: 'Clients',
    icon: Icons.people_alt_rounded,
    color: Colors.blue.shade700,
    description: 'View & manage all clients',
    onTap: (context) => AppRoute.clientsAndAdminsView.push(context),
  ),
  PanelButtonData(
    label: 'Admins',
    icon: Icons.manage_accounts_rounded,
    color: Colors.cyan.shade700,
    description: 'Manage admin accounts',
    onTap: (context) => AppRoute.adminsView.push(context),
  ),
  PanelButtonData(
    label: 'Pending KYC',
    icon: Icons.pending_actions_rounded,
    color: Colors.orange.shade700,
    description: 'Clients with incomplete verification',
    onTap: (context) => AppRoute.clientsAndAdminsView
        .push(context, extra: ClientsAndAdminsViewArgs(initPendingKyc: true)),
  ),
  // PanelButtonData(
  //   label: 'Blocked Users',
  //   icon: Icons.block_rounded,
  //   color: Colors.red.shade600,
  //   description: 'Suspended or spam accounts',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Invite User',
  //   icon: Icons.person_add_alt_1_rounded,
  //   color: Colors.green.shade600,
  //   description: 'Send invite to new user or admin',
  //   onTap: (context) {},
  // ),
];
final List<PanelButtonData> orderReportsButtons = [
  PanelButtonData(
    label: 'Master Orders',
    icon: Icons.all_inbox_rounded,
    color: Colors.teal.shade700,
    description: 'View full history of master supplier orders',
    onTap: (context) => AppRoute.masterOrdersHistory.push(context),
  ),
  PanelButtonData(
    label: 'User Orders',
    icon: Icons.list_alt_rounded,
    color: Colors.lime.shade700,
    description: 'Browse all user order history',
    onTap: (context) => AppRoute.userOrdersHistory.push(context),
  ),
  PanelButtonData(
    label: 'Actual Deliveries',
    icon: Icons.local_shipping_outlined,
    color: Colors.brown.shade600,
    description: 'View full history of actual deliveries',
    onTap: (context) => AppRoute.masterOrdersHistory.push(context, extra: true),
  ),

  // PanelButtonData(
  //   label: 'Combined View',
  //   icon: Icons.library_books_rounded,
  //   color: Colors.blueGrey.shade700,
  //   description: 'View main & client orders side by side',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Invoices',
  //   icon: Icons.picture_as_pdf_rounded,
  //   color: Colors.red.shade700,
  //   description: 'Generate and download order invoices',
  //   onTap: (context) {},
  // ),
];
final List<PanelButtonData> extrasButtons = [
  // . -> Discount Sections page -> name of section page -> delete, edit
  // section_builder.dart use to edit,create page ok.
  PanelButtonData(
    label: 'Discount Sections',
    icon: Icons.percent_rounded,
    color: Colors.green.shade700,
    description: 'Manage supplier-wide discounts',
    onTap: (context) => AppRoute.discountSections.push(context),
  ),
  PanelButtonData(
    label: 'Logs',
    icon: Icons.history_edu_rounded,
    color: Colors.indigoAccent.shade100,
    description: 'See system activity records',
    onTap: (context) => AppRoute.logs.push(context),
  ),
  // PanelButtonData(
  //   label: 'Section Builder',
  //   icon: Icons.discount,
  //   color: Colors.redAccent,
  //   description: 'Create or update DiscountSections directly',
  //   onTap: (context) => AppRoute.discountSections.push(context),
  // ),
  // PanelButtonData(
  //   label: 'Company Info',
  //   icon: Icons.info_rounded,
  //   color: Colors.blueGrey.shade600,
  //   description: 'Company details & config',
  //   onTap: (context) {},
  // ),
  // PanelButtonData(
  //   label: 'Permissions',
  //   icon: Icons.shield_rounded,
  //   color: Colors.orange.shade800,
  //   description: 'Manage admin roles & security',
  //   onTap: (context) {},
  // ),
];
