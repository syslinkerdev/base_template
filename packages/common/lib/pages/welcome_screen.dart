import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:models/models.dart';
import 'package:system_assets/app_images.dart';
import 'package:system_assets/icon_x.dart';

class WelcomeScreenArgs {
  final Role role;
  final VoidCallback onMarkAuthorized;

  WelcomeScreenArgs({
    required this.role,
    required this.onMarkAuthorized,
  });
}

class WelcomeScreen extends StatefulWidget {
  final Role role;
  final VoidCallback onMarkAuthorized;

  const WelcomeScreen(
      {super.key, required this.role, required this.onMarkAuthorized});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    Future.delayed(const Duration(seconds: 5), () {
      widget.onMarkAuthorized();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUserAdmin = widget.role == Role.admin;
    //print('iiiiiiiiiiiiiii -- $isUserAdmin --- ${widget.role}');
    final IconX logo = isUserAdmin ? sysImages.MMlogo : sysImages.MOlogo;

    return ScaffoldX(
      appToolbarHeight: 30,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isUserAdmin
                      ? 'Welcome to ${AppEnv.companyName} admin!'
                      : 'Welcome to ${AppEnv.companyName}!',
                  style: isUserAdmin
                      ? TextStyles.h7Bold(context)
                      : TextStyles.h6Bold(context),
                ),
                logo.toWidget(height: 60),
              ],
            ),
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeTransition(
                    opacity: animationController
                        .drive(CurveTween(curve: Curves.easeOut)),
                    child: SizedBox(
                      height: context.sizeOfHeight * 0.4,
                      width: context.sizeOfWidth * 0.9,
                      child: CustomPaint(
                        foregroundPainter: WelcomePaint(),
                        child: Icon(
                          Icons.done_rounded,
                          color: appColors.ms.black40(context),
                          size: context.sizeOfWidth * 0.2,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Nice of you to join us!',
                    style: TextStyles.h6Bold(context),
                  ),
                  gapH12,
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        isUserAdmin
                            ? 'Effortlessly manage your clients and milk.'
                            : 'Effortlessly manage your milk purchases with ${AppEnv.companyName}.',
                        style: TextStyles.h8Gray(context)?.copyWith(
                            color: appColors.cS(context).surfaceTint),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            gapH12,
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Features:',
                    style: TextStyles.h7Bold(context),
                  ),
                  gapH12,
                  if (!isUserAdmin) ...[
                    const _Feature(
                      icon: Icons.add_circle_outline,
                      label: 'Create daily milk order easily.',
                    ),
                    gapH4,
                    const _Feature(
                      icon: Icons.history_outlined,
                      label: 'View your complete purchase history.',
                    ),
                  ] else ...[
                    const _Feature(
                      icon: Icons.person_outline,
                      label: 'Manage your clients easily.',
                    ),
                    gapH4,
                    const _Feature(
                      icon: Icons.inventory,
                      label: 'Manage your products easily.',
                    ),
                    gapH4,
                    const _Feature(
                      icon: Icons.percent,
                      label: 'Manage clients discounts easily.',
                    ),
                  ],
                  gapH4,
                  _Feature(
                    icon: Icons.receipt_long_outlined,
                    label: isUserAdmin
                        ? 'Auto reports (PDF & Sheets).'
                        : 'Auto reports (PDF & Sheets).',
                  ),
                  gapH4,
                  const _Feature(
                    icon: Icons.cloud_outlined,
                    label: 'Access your data anytime, anywhere.',
                  ),
                  gapH4,
                  _Feature(
                    icon: Icons.call_outlined,
                    label: isUserAdmin
                        ? 'Seamless communication with clients.'
                        : 'Seamless communication with admin.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Feature({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: appColors.cS(context).surfaceTint,
        ),
        gapW4,
        Flexible(
          child: Text(
            label,
            style: TextStyles.h9Bold(context),
          ),
        ),
      ],
    );
  }
}
