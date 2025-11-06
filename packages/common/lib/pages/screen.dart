import 'package:core/core.dart';
import 'package:flutter/material.dart';

class Screen extends StatelessWidget {
  final String screenName;

  const Screen({super.key, required this.screenName});

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
        title: screenName,
        body: Center(
          child: Text(
              'screenName: $screenName ${RouteX.getCurrentRoute(context)}'),
        ));
  }
}
