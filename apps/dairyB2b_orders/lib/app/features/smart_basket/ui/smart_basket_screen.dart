import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:common/common.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:models/models.dart';
import 'package:dairyB2b_orders/app/features/smart_basket/providers/smart_basket_providers.dart';
import 'package:dairyB2b_orders/app/features/smart_basket/ui/widgets/smart_basket_card.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';
import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:system_assets/app_images.dart';

class SmartBasketScreen extends ConsumerWidget {
  const SmartBasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uId = ref.watch(appStateXProvider).uId;
    final clientFetcher = ref.watch(fetchUserProvider(documentId: uId));
    final smartBasketXNotifier = ref.read(smartBasketXProvider.notifier);

    return ScaffoldX(
      title: 'Smart Basket',
      wantLeading: true,
      body: clientFetcher.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('User not found'));
          }
          // ✅ Cache user globally
          GlobalCacheService.instance.setUser(user);
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RefreshIndicator(
              onRefresh: () => refresh(ref: ref, uId: uId),
              child: SpacedColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                defaultHeight: 12,
                children: [
                  ContainerX(
                    padding: const EdgeInsets.all(7),
                    margin:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                    child: SizedBox(
                      height: context.sizeOfHeight * 0.18,
                      child: Stack(
                        clipBehavior: Clip.none, // allows overflow
                        children: [
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: sysImages.smartBasket
                                .toWidget(height: context.sizeOfHeight * 0.165),
                          ),
                          Positioned.fill(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                gapH24,
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                    colors: [
                                      Color(0xFF7C4DFF), // Deep Purple
                                      Color(0xFFFF4081), // Pink
                                      Color(0xFF00BFA5), // Teal Accent
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight,
                                  ).createShader(Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height)),
                                  blendMode: BlendMode.srcIn,
                                  child: Text(
                                    'Smart Baskets (${user.smartBaskets?.length} / ${user.basketLimitNo})',
                                    style: TextStyles.h8Bold(context)?.copyWith(
                                      fontSize: context.sizeOfHeight * 0.023,
                                    ),
                                  ),
                                ),
                                gapH8,
                                Text.rich(
                                  TextSpan(
                                    text:
                                        'Keep your favorite items\ntogether to order ',
                                    style: TextStyles.h9Bold(context)?.copyWith(
                                      color: appColors.ms.textBlack50(context),
                                    ),
                                    children: [
                                      TextSpan(
                                          text: 'quickly.',
                                          style: TextStyles.h9Bold(context)
                                              ?.copyWith(
                                                  color: appColors
                                                      .cS(context)
                                                      .primaryFixedDim)),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonX.containerButton(
                    context: context,
                    label: 'Create New Smart Basket',
                    labelColor: context.colorScheme.primary,
                    labelStyle: TextStyles.h8Bold(context)
                        ?.copyWith(fontSize: context.sizeOfHeight * 0.022),
                    icon: Icons.add_rounded,
                    iconSize: context.sizeOfHeight * 0.04,
                    borderRadius: 12,
                    buttonHeight: context.sizeOfHeight * 0.07,
                    flex: MainAxisAlignment.spaceBetween,
                    loading: false,
                    noAsyncLoading: true,
                    onPressed: () async {
                      final shouldNavigate =
                          await DialogsX.askForConfirmation<bool>(
                        context,
                        content:
                            'Creating a new Smart Basket will clear your current cart. Are you sure you want to continue?',
                        cancelBtnText: 'Cancel',
                        confirmBtnText: 'Create',
                      );

                      if (shouldNavigate != null && shouldNavigate == true) {
                        // await cartNotifier
                        //     .setMode(CartMode.basket, cartItems: []);
                        await smartBasketXNotifier
                            .createNewSmartBasket(user)
                            .then(
                          (createBasketOrNot) {
                            if (createBasketOrNot) {
                              if (!context.mounted) return;
                              StatefulNavigationShell.of(context).goBranch(1);
                            } else {
                              DialogsX.showWarningDialog(context,
                                  title: 'Basket Limit Reached',
                                  content:
                                      'You have reached your limit of ${user.basketLimitNo} smart baskets.');
                            }
                          },
                        );
                      }
                    },
                  ),
                  if (user.smartBaskets == null ||
                      user.smartBaskets!.isEmpty) ...[
                    ContainerX(
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.shopping_basket_outlined,
                                size: context.sizeOfHeight * 0.1,
                                color: appColors.sc.grey650),
                            gapH20,
                            Text(
                              'No Smart Baskets Created.',
                              style: TextStyles.h8(context),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  ] else ...[
                    SimpleHeading(
                        label:
                            'Your Smart Baskets (${user.smartBaskets!.length})'),
                    DynamicList<SmartBasket>(
                      physics: NeverScrollableScrollPhysics(),
                      items: user.smartBaskets ?? [],
                      onSelect: (basket) => AppRoute.smartBasketDetails
                          .push(context, extra: basket),
                      listSeparatorBuilder: (context, index) => gapH8,
                      itemBuilder: (context, basket, isSelected) =>
                          SmartBasketCard(smartBasket: basket),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => ErrorScreen(
            error: error, onRetry: () => refresh(ref: ref, uId: uId)),
        loading: () => _buildShimmerLoading(context),
      ),
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    final heightMultipliers = [0.2, 0.08, 0.03, 0.2, 0.2, 0.2, 0.2];
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SpacedColumn(
        children: List.generate(heightMultipliers.length, (i) {
          return ShimmerX(
            width: context.sizeOfWidth,
            height: context.sizeOfHeight * heightMultipliers[i],
          );
        }),
      ),
    );
  }

  static Future<void> refresh({
    required WidgetRef ref,
    required String uId,
  }) async {
    final refreshedUser =
        await ref.refresh(fetchUserProvider(documentId: uId).future);

    if (refreshedUser != null) {
      GlobalCacheService.instance.setUser(refreshedUser);
    }
  }
}
