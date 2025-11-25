import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Reusable widget to run a function once when the widget is mounted.
class RunOnce extends HookWidget {
  final Future<void> Function() onRun;
  final Widget child;

  const RunOnce({super.key, required this.onRun, required this.child});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      // Run the function once after first build
      onRun();
      return null;
    }, []); // empty dependencies = run once

    return child;
  }
}
