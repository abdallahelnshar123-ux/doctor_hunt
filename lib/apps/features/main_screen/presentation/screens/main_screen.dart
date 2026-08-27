import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../browse_tab/presentation/screens/browse_tab.dart';
import '../../../chat_tab/presentation/screens/chat_tab.dart';
import '../../../favourite_tab/presentation/screens/favorite_tab.dart';
import '../../../home_tab/presentation/screens/home_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> _tabsList = const [
    HomeTab(),
    FavoriteTab(),
    BrowseTab(),
    ChatTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: _tabsList[selectedIndex],
      bottomNavigationBar: Container(
        width: double.infinity,
        clipBehavior: .antiAlias,
        decoration: BoxDecoration(
          color: AppColors.bgPrimary,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 13),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
            canvasColor: AppColors.bgPrimary,
          ),

          child: BottomNavigationBar(
            elevation: 0,
            unselectedLabelStyle: TextStyle(fontSize: 0),
            selectedLabelStyle: TextStyle(fontSize: 0),
            backgroundColor: AppColors.transparent,
            onTap: (index) {
              setState(() {
                if (selectedIndex != index) {
                  selectedIndex = index;
                }
              });
            },
            items: [
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbHomeIcon.path,
                index: 0,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbFavoriteIcon.path,
                index: 1,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbBrowseIcon.path,
                index: 2,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbChatIcon.path,
                index: 3,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required String iconName,
    required int index,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: index == selectedIndex
              ? AppColors.brandPrimary
              : AppColors.transparent,
          shape: .circle,
        ),
        child: SvgPicture.asset(
          iconName,
          colorFilter: ColorFilter.mode(
            index == selectedIndex ? AppColors.bgPrimary : AppColors.textMuted,
            BlendMode.srcIn,
          ),
          width: 24,
        ),
      ),
    );
  }
}
