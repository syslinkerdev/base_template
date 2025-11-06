import 'package:repo/repo.dart';
import 'package:core/core.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dairyB2b_orders/router/app_route_paths.dart';
import 'package:dairyB2b_orders/app/app_base/app_state_provider.dart';
import 'package:dairyB2b_orders/app/features/cart/providers/cart_provider.dart';
import 'package:dairyB2b_orders/app/features/home/widgets/time_remaining_widget.dart';
import 'package:dairyB2b_orders/app/features/home/widgets/brands_categories_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productMaker = ref.watch(fetchProductMakerProvider);

    ref.listen(cartProvider, (previous, next) {
      final message = next.value?.message;
      if (message != null && message.isNotEmpty) {
        DialogsX.showWarningDialog(
          context,
          title: 'Cart Reset Notice',
          content: message,
        );
        ref.read(cartProvider.notifier).clearMessage();
      }
    });

    return ScaffoldX(
      wantLeading: false,
      title: AppEnv.companyName,
      appToolbarHeight: -1,
      titleStyle: TextStyles.h5Bold(context)
          ?.copyWith(color: appColors.ms.black(context)),
      // appBarActions: [AnyWereSearchBtn()],
      body: productMaker.when(
        data: (data) {
          if (data == null) {
            return const Center(
              child: Text('null  -- empty list - Ghost'),
            );
          }
          return RefreshIndicator(
            onRefresh: () => homeRefresh(ref),
            child: SingleChildScrollView(
              child: SpacedColumn(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                crossAxisAlignment: CrossAxisAlignment.start,
                defaultHeight: 12,
                children: [
                  NextDayOrderInfo(),
                  TimeRemaining(),
                  BrandsCategoriesWidget(productMaker: data),
                  HeadingLineFade(label: 'ORDER CONTROL CENTER'),
                  NextDayOrder(
                    uId: ref.read(appStateXProvider).uId,
                    onPress: (isTodaysOrderExist) {
                      if (isTodaysOrderExist) {
                        AppRoute.historyDetail
                            .push(context, extra: DFU.nextDay());
                      } else {
                        return;
                      }
                    },
                  ),
                  SmartBasketButton(),
                  OrderSloganFooter(),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) =>
            ErrorScreen(error: error, onRetry: () => homeRefresh(ref)),
        loading: () => const LoadingScreen(),
      ),
    );
  }
}

Future<void> homeRefresh(WidgetRef ref) async {
  await Future.wait([
    ref.refresh(orderRulesStreamProvider.future),
    ref.refresh(
        doesOrderExistForNextDayProvider(uId: ref.watch(appStateXProvider).uId)
            .future),
    ref.refresh(fetchProductMakerProvider.future),
  ]);
}

class SmartBasketButton extends StatelessWidget {
  const SmartBasketButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRoute.smartBasket.push(context),
      child: ContainerX(
          margin: EdgeInsets.only(bottom: 4),
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColorBgIcon(
                      icon: Icons.shopping_basket_rounded,
                      color: appColors.cS(context).primary),
                  gapW12,
                  Text('SMART BASKET',
                      style: TextStyles.h8Gray(context)
                          ?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: appColors.ms.textBlack50(context))
            ],
          )),
    );
  }
}
