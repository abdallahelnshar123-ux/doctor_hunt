import 'package:doctor_hunt/apps/features/admin_doctors_tab/presentation/screens/admin_doctors_tab.dart';
import 'package:doctor_hunt/apps/features/admin_settings_tab/presentation/screens/admin_settings_tab.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_scaffold.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int selectedIndex = 0;

  final List<Widget> _tabsList = const [AdminDoctorsTab(), AdminSettingsTab()];

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
                iconName: Icons.supervisor_account_outlined,
                index: 0,
                context: context,
              ),
              builtBottomNavigationBarItem(
                iconName: Icons.settings_outlined,
                index: 1,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem builtBottomNavigationBarItem({
    required IconData iconName,
    required int index,
    required BuildContext context,
  }) {
    return BottomNavigationBarItem(
      label: '',
      icon: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: index == selectedIndex
              ? AppColors.brandPrimary
              : AppColors.transparent,
          shape: .circle,
        ),
        child: Icon(

          iconName,
          color: index == selectedIndex
              ? AppColors.white
              : AppColors.textSecondary,
          size: 30,
        ),
      ),
    );
  }
}
