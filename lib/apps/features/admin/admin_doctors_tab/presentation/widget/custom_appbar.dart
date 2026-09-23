part of '../screens/admin_doctors_tab.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key, this.appBarHeight = 80});

  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    final user = context.select<AuthBloc, MyUser?>((bloc) {
      final authState = bloc.state;
      return authState is UserAuthenticatedState ? authState.currentUser : null;
    });
    return AppBar(
      title: Text(t.admin.main.doctors),
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
          child: Text(
            user?.name[0].toUpperCase() ?? '',
            style: context.bold16.white.rubik,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
