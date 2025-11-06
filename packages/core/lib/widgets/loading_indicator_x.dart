import 'package:flutter/material.dart';

class LoadingIndicatorX extends StatelessWidget {
  final double height;
  final double width;
  const LoadingIndicatorX({super.key, this.height = 24, this.width = 24});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: height,
        width: width,
        child: const CircularProgressIndicator(strokeWidth: 2.2),
      ),
    );
  }
}
