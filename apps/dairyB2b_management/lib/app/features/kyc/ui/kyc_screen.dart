import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_management/app/features/kyc/ui/pages/authorize_page.dart';
import 'package:dairyB2b_management/app/features/kyc/ui/pages/creating_profile_page.dart';
import 'package:dairyB2b_management/app/features/kyc/ui/pages/enroll_page.dart';

class KycScreen extends ConsumerWidget {
  const KycScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScaffoldX(
        title: 'KYC',
        body: StepperPageViewX(
            pageToStepIndex: generatePageToStepIndex([1, 1, 1]),
            offPageIndicator: true,
            labels: [
              'Creating Profile',
              'Authorize',
              'Enroll',
            ],
            pages: [
              CreatingProfile(),
              Authorize(),
              Enroll(),
            ]));
  }
}