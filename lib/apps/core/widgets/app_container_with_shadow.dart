import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppContainerWithShadow extends StatelessWidget {
  final Widget? child;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Decoration? decoration;
  final Decoration? foregroundDecoration;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;
  final bool isAntiAlias;

  const AppContainerWithShadow({
    super.key,
    this.child,
    this.alignment,
    this.padding,
    this.color,
    this.decoration,
    this.foregroundDecoration,
    this.width,
    this.height,
    this.constraints,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.clipBehavior = Clip.none,
    this.isAntiAlias = true,
  }) : assert(
         decoration == null || color == null,
         'Cannot provide both a color and a decoration\n'
         'To provide both, use "decoration: BoxDecoration(color: color)".',
       );

  @override
  Widget build(BuildContext context) {
    final List<BoxShadow> defaultShadow = [
      BoxShadow(
        color: AppColors.black.withAlpha(20),
        blurRadius: 25,
        spreadRadius: 0.5,
        offset: const Offset(0, 0),
      ),
    ];

    Decoration? effectiveDecoration;
    if (decoration != null) {
      if (decoration is BoxDecoration) {
        effectiveDecoration = (decoration as BoxDecoration).copyWith(
          boxShadow: (decoration as BoxDecoration).boxShadow ?? defaultShadow,
        );
      } else {
        effectiveDecoration = decoration;
      }
    } else {
      effectiveDecoration = BoxDecoration(
        color: color,
        boxShadow: defaultShadow,
      );
    }

    return Container(
      color: color,
      isAntiAlias: isAntiAlias,
      key: key,
      alignment: alignment,
      padding: padding,
      decoration: effectiveDecoration,
      foregroundDecoration: foregroundDecoration,
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      transform: transform,
      transformAlignment: transformAlignment,
      clipBehavior: clipBehavior,
      child: child,
    );
  }
}
