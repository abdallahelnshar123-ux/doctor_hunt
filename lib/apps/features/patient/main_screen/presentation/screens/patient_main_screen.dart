import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../browse_tab/presentation/screens/browse_tab.dart';
import '../../../booking_tab/presentation/screens/chat_tab.dart';
import '../../../favourite_tab/presentation/screens/favorite_tab.dart';
import '../../../home_tab/presentation/screens/home_tab.dart';

class PatientMainScreen extends HookWidget {
  const PatientMainScreen({super.key});

  static const List<Widget> _tabsList = [
    HomeTab(),
    FavoriteTab(),
    BrowseTab(),
    BookingTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return AppScaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true,
      body: _tabsList[selectedIndex.value],
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
            unselectedLabelStyle: context.semiBold0,
            selectedLabelStyle: context.semiBold0,
            backgroundColor: AppColors.transparent,
            onTap: (index) {
              if (selectedIndex.value != index) {
                selectedIndex.value = index;
              }
            },
            items: [
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbHomeIcon.path,
                index: 0,
                selectedIndex: selectedIndex.value,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbFavoriteIcon.path,
                index: 1,
                selectedIndex: selectedIndex.value,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbBrowseIcon.path,
                index: 2,
                selectedIndex: selectedIndex.value,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: AppAssets.icons.bnbChatIcon.path,
                index: 3,
                selectedIndex: selectedIndex.value,
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
    required int selectedIndex,
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
