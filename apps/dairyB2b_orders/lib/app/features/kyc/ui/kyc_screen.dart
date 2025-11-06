import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/app/features/kyc/ui/pages/authorize_access_code_page.dart';
import 'package:dairyB2b_orders/app/features/kyc/ui/pages/authorize_choose_admin_page.dart';
import 'package:dairyB2b_orders/app/features/kyc/ui/pages/enroll_shop_details_page.dart';
import 'package:dairyB2b_orders/app/features/kyc/ui/pages/enroll_user_details_page.dart';
import 'package:dairyB2b_orders/app/features/kyc/ui/pages/iconize_choose_avatar_page.dart';

class KycScreen extends ConsumerWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldX(
        title: 'KYC',
        body: StepperPageViewX(
            pageToStepIndex: generatePageToStepIndex([2, 2, 1]),
            offPageIndicator: true,
            labels: [
              'Authorize',
              'Enroll',
              'Iconize'
            ],
            pages: [
              AuthorizeChooseAdminPage(),
              AuthorizeAccessCodePage(),
              EnrollUserDetailsPage(),
              EnrollShopDetailsPage(),
              IconizeChooseAvatarPage(),
            ]));
  }
}
