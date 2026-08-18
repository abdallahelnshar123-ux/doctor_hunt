import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../tabs/browse_tab.dart';
import '../tabs/chat_tab.dart';
import '../tabs/favorite_tab.dart';
import '../tabs/home_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            topRight: Radius.circular(20.r),
            topLeft: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 13.h),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: AppColors.transparent,
            highlightColor: AppColors.transparent,
          ),

          child: BottomNavigationBar(
            elevation: 0,
            fixedColor: AppColors.transparent,
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
                iconName: AppAssets.bnbHomeIcon,
                index: 0,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbFavoriteIcon,
                index: 1,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbBrowseIcon,
                index: 2,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.bnbChatIcon,
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
        padding: EdgeInsets.all(14.r),
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
