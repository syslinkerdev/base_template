// import 'package:core/core.dart';
// import 'package:flutter/material.dart';
// import 'package:system_assets/app_images.dart';

// class ComingSoon extends StatelessWidget {
//   const ComingSoon({super.key, this.wantLeading = true, this.leadingOnPressed});
//   final bool wantLeading;
//   final void Function()? leadingOnPressed;

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldX(
//       wantLeading: wantLeading,
//       leadingOnPressed: leadingOnPressed,
//       title: 'Stay Tuned!',
//       body: Center(
//         child: SpacedColumn(
//           defaultHeight: 10,
//           children: [
//             sysImages.comingSoon.toWidget(width: context.sizeOfWidth * 0.6),
//             gapH8,
//             Text(
//               'Feature Coming Soon!',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             Text(
//               'We\'re working hard to bring this feature to you.',
//               style: Theme.of(context).textTheme.bodyMedium,
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
