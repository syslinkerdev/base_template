import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A class that provides various page transition effects for navigation.
class AppTransitions {
  /// Slide transition from the left.
  ///
  /// This transition animates the page from the left side of the screen
  /// into its final position.
  static Page<void> left(ValueKey<String> key, {required Widget page}) {
    return CustomTransitionPage<void>(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0); // From left side (off-screen)
        const end = Offset.zero; // On-screen
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  /// Slide transition from the right.
  ///
  /// This transition animates the page from the right side of the screen
  /// into its final position.
  static Page<void> right(ValueKey<String> key, {required Widget page}) {
    return CustomTransitionPage<void>(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // From right side (off-screen)
        const end = Offset.zero; // On-screen
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  /// Slide transition from the top.
  ///
  /// This transition animates the page from the top of the screen
  /// into its final position.
  static Page<void> top(ValueKey<String> key, {required Widget page}) {
    return CustomTransitionPage<void>(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0); // From top side (off-screen)
        const end = Offset.zero; // On-screen
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  /// Slide transition from the bottom.
  ///
  /// This transition animates the page from the bottom of the screen
  /// into its final position.
  static Page<void> bottom(ValueKey<String> key, {required Widget page}) {
    return CustomTransitionPage<void>(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // From bottom side (off-screen)
        const end = Offset.zero; // On-screen
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  /// Fade transition.
  ///
  /// This transition animates the page by fading it in and out.
  /// The page will gradually appear on the screen.
  static Page<void> fade(ValueKey<String> key, {required Widget page}) {
    return CustomTransitionPage<void>(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );
        return FadeTransition(opacity: fadeAnimation, child: child);
      },
    );
  }

  /// Scale transition (zoom-in effect).
  ///
  /// This transition animates the page by scaling it from a small size
  /// to its final size, creating a zoom-in effect.
  static Page<void> scale(ValueKey<String> key, {required Widget page}) {
    return CustomTransitionPage<void>(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );
        return ScaleTransition(scale: scaleAnimation, child: child);
      },
    );
  }

  /// Rotate transition (spin effect).
  ///
  /// This transition animates the page by rotating it from 0 to 360 degrees.
  /// The page will spin into view.
  static Page<void> rotate(ValueKey<String> key, {required Widget page}) {
    return CustomTransitionPage<void>(
      key: key,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var rotateAnimation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );
        return RotationTransition(turns: rotateAnimation, child: child);
      },
    );
  }
}
