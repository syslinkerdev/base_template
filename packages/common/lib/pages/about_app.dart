import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:system_assets/app_images.dart';
import 'package:repo/repo.dart';

class AboutApp extends ConsumerWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appManagerDataAsy = ref.watch(
        fetchAppManagementProvider(documentId: DbPathManager.appManagement()));
    return ScaffoldX(
      title: "About ${AppEnv.companyName} ${AppEnv.appName}",
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SpacedColumn(
          defaultHeight: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: sysImages.MOlogo.toWidget(
                    width: context.sizeOfWidth * 0.3)),
            Center(
              child: Text(
                "${AppEnv.companyName} ${AppEnv.appName}",
                style: TextStyles.h5Bold(context),
              ),
            ),
            Center(
              child: Text("Simplifying Milk Distribution",
                  style: TextStyles.h7Gray(context)),
            ),
            gapH12,
            Text(
              "About this App",
              style: TextStyles.h7Bold(context),
            ),
            Text(
              "${AppEnv.companyName} ${AppEnv.appName} helps milk distributors and clients manage daily orders with ease. "
              "From placing orders to tracking discounts and reports, everything is streamlined "
              "to save time and reduce errors.",
              style: TextStyles.h7Gray(context),
            ),
            Text(
              "Key Features",
              style: TextStyles.h7Bold(context),
            ),
            Column(
              children: [
                _featureTile(context, Icons.shopping_basket_outlined,
                    "Quick Order Placement"),
                _featureTile(context, Icons.discount_outlined,
                    "Manage Discounts & Offers"),
                _featureTile(context, Icons.history, "View History & Reports"),
                _featureTile(context, Icons.admin_panel_settings_outlined,
                    "Easy Admin Management"),
              ],
            ),
            Text(
              "Who Built This?",
              style: TextStyles.h7Bold(context),
            ),
            Text(
              "${AppEnv.companyName} ${AppEnv.appName} was crafted by a small independent team passionate about building "
              "custom apps for real-world businesses. Every feature is designed with care, keeping "
              "distributors and shop owners in mind.",
              style: TextStyles.h7Gray(context),
            ),
            Text(
              "Want Something Similar?",
              style: TextStyles.h7Bold(context),
            ),
            Text(
              "We create apps that solve real business needs.\n${AppEnv.systemName} is one example, yours can be next.",
              style: TextStyles.h7Gray(context),
            ),
            gapH2,
            appManagerDataAsy.when(
              data: (appManagerData) {
                return Center(
                  child: ButtonX.containerButton(
                    context: context,
                    label: 'Get in Touch',
                    labelColor: appColors.ms.textBlack80(context),
                    flex: MainAxisAlignment.spaceBetween,
                    icon: Icons.message,
                    iconSize: context.sizeOfWidth * 0.05,
                    noAsyncLoading: true,
                    onPressed: () => WhatsAppButton.openWhatsapp(
                        context: context,
                        phoneNumber: appManagerData?.phoneNumber ?? '',
                        message:
                            """Hello, I\'d like to discuss building an app for my business."""),
                  ),
                );
              },
              error: (_, __) => Text("Contact option unavailable",
                  style: TextStyles.h7Gray(context)),
              loading: () => ShimmerX(width: context.sizeOfWidth, height: 51),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureTile(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon,
              color: appColors.cS(context).primaryFixedDim,
              size: TextStyles.h7Gray(context)?.fontSize),
          gapW8,
          Expanded(
            child: Text(text, style: TextStyles.h7Gray(context)),
          ),
        ],
      ),
    );
  }
}
