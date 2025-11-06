import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repo/repo.dart';

class HitQueries extends ConsumerWidget {
  final String uid;

  const HitQueries({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final currentUserUid = ref.watch(appStateXProvider).uId;
    // Use this ok
    //  ButtonX(
    //               label: 'Hit Queries',
    //               onPressed: () {
    //                 AppRoute.rules
    //                     .push(context, extra: ref.read(appStateXProvider).uId);
    //               },
    //             ),
    return ScaffoldX(
        title: 'Hit Queries',
        body: Center(
          child: SpacedColumn(children: [
            ButtonX(
              label: 'Latest Deleted Users Phone No.',
              onPressed: () => ref
                  .read(dairyB2bRepositoryProvider)
                  .fetchLatestDeletedUserByPhone('+911234567890'),
            ),
            ButtonX(
              label: 'Does Order Exist For Next Day',
              onPressed: () => ref
                  .read(dairyB2bRepositoryProvider)
                  .doesOrderExistForNextDay(uId: uid),
            ),
            ButtonX(
              label: 'Orders Last 3 days',
              onPressed: () => ref
                  .read(dairyB2bRepositoryProvider)
                  .fetchOrdersLast3days(uId: uid),
            ),
          ]),
        ));
  }
}
