import 'package:core/core.dart';
import 'package:flutter/material.dart';

class ScaffoldX extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? appBarActions;
  final bool wantLeading;
  final void Function()? leadingOnPressed;
  final double appToolbarHeight;
  final bool titleTextBlack;
  final bool titleCenter;
  final bool stopBottomBarHideScroll;
  final Widget? floatingActionButton;
  final Color? appBarBackgroundColor;
  final TextStyle? titleStyle;
  final Widget? bottomNavigationBar;
  final bool usePopScope;
  final bool Function()? canPop;
  final void Function(bool didPop, Object? result)? onPopInvokedWithResult;

  const ScaffoldX({
    super.key,
    required this.body,
    this.title,
    this.appBarActions,
    this.wantLeading = false,
    this.leadingOnPressed,
    this.appToolbarHeight = 40,
    this.titleTextBlack = false,
    this.titleCenter = false,
    this.stopBottomBarHideScroll = false,
    this.floatingActionButton,
    this.appBarBackgroundColor,
    this.titleStyle,
    this.bottomNavigationBar,
    this.usePopScope = false,
    this.canPop,
    this.onPopInvokedWithResult,
  });

  @override
  Widget build(BuildContext context) {
    final localNavCtr = ValueNotifier(true);

    TextStyle? getTitleStyle() {
      if (titleStyle != null) return titleStyle;

      if (titleTextBlack) {
        return TextStyles.h7Bold(context)
            ?.copyWith(color: ColorX.instance.ms.black(context));
      }
      return TextStyles.h7Gray(context);
    }

    AppBar buildAppBar() {
      return AppBar(
        centerTitle: titleCenter,
        leading: wantLeading
            ? IconButton(
                onPressed: leadingOnPressed ?? () => context.close(),
                icon: Icon(
                  titleCenter
                      ? Icons.arrow_back
                      : Icons.arrow_back_ios_new_rounded,
                  color: ColorX.instance.ms.black(context),
                ),
              )
            : null,
        backgroundColor:
            appBarBackgroundColor ?? ColorX.instance.ms.white(context),
        toolbarHeight: appToolbarHeight == -1 ? null : appToolbarHeight,
        title: title != null ? Text(title!, style: getTitleStyle()) : null,
        actions: appBarActions,
        automaticallyImplyLeading: false,
      );
    }

    Widget buildBodyWithBottomNav() {
      return Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (stopBottomBarHideScroll) return false;

              if (scrollNotification is ScrollUpdateNotification &&
                  scrollNotification.metrics.axis == Axis.vertical) {
                final isScrollingUp = scrollNotification.metrics.pixels <
                    scrollNotification.metrics.maxScrollExtent;
                localNavCtr.value = isScrollingUp;
              }
              return false;
            },
            child: SizedBox(height: context.sizeOfHeight, child: body),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: localNavCtr,
            builder: (context, isVisible, _) {
              return Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  transitionBuilder: (child, animation) => SlideTransition(
                    position: Tween<Offset>(
                            begin: const Offset(0, 1), end: Offset.zero)
                        .animate(animation),
                    child: child,
                  ),
                  child: isVisible
                      ? Container(
                          color: Theme.of(context).cardColor,
                          height: context.sizeOfHeight * 0.09,
                          width: context.sizeOfWidth,
                          padding: const EdgeInsets.all(10),
                          child: bottomNavigationBar,
                        )
                      : const SizedBox.shrink(),
                ),
              );
            },
          ),
        ],
      );
    }

    Widget scaffold = Scaffold(
      backgroundColor: ColorX.instance.ms.white(context),
      appBar: buildAppBar(),
      body: bottomNavigationBar == null ? body : buildBodyWithBottomNav(),
      floatingActionButton: floatingActionButton,
    );

    if (usePopScope) {
      scaffold = PopScope(
        canPop: canPop?.call() ?? true,
        onPopInvokedWithResult: onPopInvokedWithResult,
        child: scaffold,
      );
    }

    return scaffold;
  }
}
