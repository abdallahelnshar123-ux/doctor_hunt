import 'package:doctor_hunt/apps/core/widgets/back_button_widget.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, this.appBarHeight = 80, this.title});

  final double appBarHeight;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ''),
      leading: BackButtonWidget(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
