part of '../screens/admin_doctors_tab.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.appBarHeight = 80});

  final double appBarHeight;

  // final String? title;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return AppBar(
      title: Text(t.admin.doctors),
      leading: Icon(Icons.menu, color: AppColors.brandPrimaryDark),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20),
      centerTitle: true,
      actions: [
        IconButton(
          style: IconButton.styleFrom(),
          onPressed: () {},
          icon: Icon(Icons.notifications_none),
          color: AppColors.textSecondary,
        ),
        CircleAvatar(
          backgroundColor: AppColors.brandPrimary,
          child: Text('A', style: context.bold14.white.rubik),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
