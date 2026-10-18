import 'package:doctor_hunt/apps/core/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.appBarHeight = 80,
    this.title,
    this.backgroundColor,
    this.titleStyle,
    this.onPressed,
  });

  final double appBarHeight;
  final String? title;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? '', style: titleStyle),
      leading: BackButtonWidget(onPressed: onPressed),
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
