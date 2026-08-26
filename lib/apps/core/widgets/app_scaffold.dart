import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final AlignmentDirectional persistentFooterAlignment;
  final Widget? drawer;
  final DrawerCallback? onDrawerChanged;
  final Widget? endDrawer;
  final DrawerCallback? onEndDrawerChanged;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final Color? drawerScrimColor;
  final double? drawerEdgeDragWidth;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final bool drawerBarrierDismissible;
  final BoxDecoration? persistentFooterDecoration;
  final String? restorationId;
  final bool isOnboarding;
  final int? index;

  const AppScaffold({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.drawerBarrierDismissible = true,
    this.persistentFooterDecoration,
    this.restorationId,
    this.isOnboarding = false,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar,
        body: Stack(
          children: [
            isOnboarding == true && index != null
                ? _OnboardingBackground(index!)
                : const _MainBackground(),
            if (body != null) Positioned.fill(child: body!),
          ],
        ),
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        persistentFooterButtons: persistentFooterButtons,
        persistentFooterAlignment: persistentFooterAlignment,
        drawer: drawer,
        onDrawerChanged: onDrawerChanged,
        endDrawer: endDrawer,
        onEndDrawerChanged: onEndDrawerChanged,
        bottomNavigationBar: bottomNavigationBar,
        bottomSheet: bottomSheet,

        backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        primary: primary,
        drawerDragStartBehavior: drawerDragStartBehavior,
        extendBody: extendBody,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        drawerScrimColor: drawerScrimColor,
        drawerEdgeDragWidth: drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
        restorationId: restorationId,
        drawerBarrierDismissible: drawerBarrierDismissible,
        persistentFooterDecoration: persistentFooterDecoration,
      ),
    );
  }
}

class _MainBackground extends StatelessWidget {
  const _MainBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white),

        Positioned(
          top: -600,
          right: 50,
          child: Container(
            width: 1000,
            height: 1000,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: .5,
                stops: [0, 0.8],
                colors: [AppColors.bgBlueGradient, AppColors.bgPrimary],
              ),
            ),
          ),
        ),

        Positioned(
          bottom: -650,
          left: 50,
          child: Container(
            width: 1000,
            height: 1000,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: .5,
                stops: [0, 0.8],
                colors: [AppColors.bgGreenGradient, AppColors.bgPrimary],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OnboardingBackground extends StatelessWidget {
  final int index;

  const _OnboardingBackground(this.index);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white),

        Positioned(
          top: -60,
          right: index % 2 == 0 ? 150 : null,
          left: index % 2 != 0 ? 150 : null,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.brandPrimary,
            ),
          ),
        ),

        Positioned(
          bottom: -650,
          left: 50,
          child: Container(
            width: 1000,
            height: 1000,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                radius: .5,
                stops: [0, 0.8],
                colors: [AppColors.bgGreenGradient, AppColors.bgPrimary],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
