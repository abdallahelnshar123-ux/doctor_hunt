part of '../screens/admin_doctors_tab.dart';

class AdminAppbar extends StatelessWidget implements PreferredSizeWidget {
  const AdminAppbar({super.key, this.appBarHeight = 80 , required this.title});

  final double appBarHeight;
  final String title;

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);
    return AppBar(
      title: Text(title),
      // leading: Icon(Icons.menu, color: AppColors.brandPrimaryDark),
      actionsPadding: EdgeInsets.symmetric(horizontal: 20),
      actions: [
        IconButton(
          style: IconButton.styleFrom(),
          onPressed: () {},
          icon: Icon(Icons.notifications_none),
          color: AppColors.textSecondary,
        ),
        CircleAvatar(
          backgroundColor: AppColors.brandPrimary,
          backgroundImage: CustomCachedNetworkImage.getProvider(user?.image),
        ),
        // IconButton(
        //   onPressed: () {
        //     context.read<AuthBloc>().add(LogoutRequested());
        //   },
        //   icon: Icon(Icons.logout, color: AppColors.statusError),
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBarHeight);
}
