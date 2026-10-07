import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_hunt/apps/features/patient/settings_tab/presentation/screens/settings_tab.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kf_drawer/kf_drawer.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/dialog_utils.dart';
import '../../../../common/auth/data/models/user/my_user.dart';
import '../../../../common/auth/presentation/controller/auth_bloc.dart';
import '../../../../common/auth/presentation/controller/auth_event.dart';
import '../../../../common/auth/presentation/controller/auth_state.dart';
import '../../../../common/auth/presentation/controller/user_bloc.dart';
import '../../../appointments_tab/presentation/screens/appointments_tab.dart';
import '../../../favourite_tab/presentation/screens/favorite_tab.dart';
import '../../../home_tab/presentation/screens/home_tab.dart';

class PatientMainScreen extends HookWidget {
  const PatientMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, MyUser?>((bloc) => bloc.currentUser);

    final selectedIndex = useValueNotifier<int>(0);
    final isDrawerOpen = useValueNotifier<bool>(false);

    final tabsList = useRef([
      HomeTab(),
      FavoriteTab(),
      PatientAppointmentsTab(),
      SettingsTab(),
    ]);

    final drawerController = useMemoized(
      () => KFDrawerController(
        items: <KFDrawerItem>[
          KFDrawerItem(
            onPressed: () {
              if (selectedIndex.value == 0) return;
              selectedIndex.value = 0;
            },
            alias: t.patient_main.home,
            icon: buildDrawerIcon(iconName: AppAssets.icons.homeIcon.path),
            text: Text(
              t.patient_main.home,
              style: context.regular16.white.rubik,
            ),
            page: tabsList.value[0],
          ),
          KFDrawerItem(
            onPressed: () {
              if (selectedIndex.value == 1) return;

              selectedIndex.value = 1;
            },
            alias: t.patient_main.favourite,
            icon: buildDrawerIcon(iconName: AppAssets.icons.favouriteIcon.path),
            text: Text(
              t.patient_main.favourite,
              style: context.regular16.white.rubik,
            ),
            page: tabsList.value[1],
          ),

          KFDrawerItem(
            onPressed: () {
              if (selectedIndex.value == 2) return;

              selectedIndex.value = 2;
            },
            alias: t.patient_main.appointment,
            icon: buildDrawerIcon(
              iconName: AppAssets.icons.appointmentsIcon.path,
            ),
            text: Text(
              t.patient_main.appointment,
              style: context.regular16.white.rubik,
            ),
            page: tabsList.value[2],
          ),
          KFDrawerItem(
            onPressed: () {
              if (selectedIndex.value == 3) return;
              selectedIndex.value = 3;
            },
            alias: t.patient_main.settings,
            icon: buildDrawerIcon(iconName: AppAssets.icons.settingsIcon.path),
            text: Text(
              t.patient_main.settings,
              style: context.regular16.white.rubik,
            ),
            page: tabsList.value[3],
          ),
        ],
        initialPage: tabsList.value[0],
      ),
    );
    useEffect(() {
      return () => drawerController.dispose();
    }, [drawerController]);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutLoadingState) {
          DialogUtils.showLoading(context: context);
        } else if (state is LogoutErrorState) {
          DialogUtils.hideLoading(context: context);
          DialogUtils.showMessage(
            posActionText: t.dialog.ok,
            title: t.dialog.error,
            context: context,
            message: state.message,
          );
        }
      },
      listenWhen: (previous, current) {
        return current is LogoutLoadingState || current is LogoutErrorState;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.textSecondary,
          body: KFDrawer(
            controller: drawerController,
            drawerWidth: 0.8,
            edgeDragWidth: 50,
            footerPinned: true,
            footer: _buildLogoutButton(context),
            header: _buildHeader(context: context, user: user),
            onDrawerChanged: (value) => isDrawerOpen.value = value,
          ),
          bottomNavigationBar: _buildBottomNavBr(
            selectedIndex: selectedIndex,
            isDrawerOpen: isDrawerOpen,
            drawerController: drawerController,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({required BuildContext context, required MyUser? user}) {
    return ListTile(
      contentPadding: EdgeInsets.all(16),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: CachedNetworkImageProvider(user?.image ?? ''),
      ),
      titleTextStyle: context.medium16.white.rubik,
      subtitleTextStyle: context.regular12.white.rubik,
      title: Text(
        user?.name ?? '-',
        textAlign: .start,
        maxLines: 1,
        overflow: .ellipsis,
      ),
      subtitle: Text(user?.email ?? '-', maxLines: 1, overflow: .ellipsis),
    );
  }

  Widget _buildBottomNavBr({
    required ValueNotifier<int> selectedIndex,
    required ValueNotifier<bool> isDrawerOpen,
    required KFDrawerController drawerController,
  }) {
    return ValueListenableBuilder(
      valueListenable: isDrawerOpen,
      builder: (context, isDrawerOpenValue, child) {
        return ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, selectedIndexValue, child) {
            return AnimatedSlide(
              offset: isDrawerOpenValue ? const Offset(0, 1) : Offset.zero,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
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
                    type: .fixed,
                    elevation: 0,
                    unselectedLabelStyle: context.semiBold0,
                    selectedLabelStyle: context.semiBold0,
                    backgroundColor: AppColors.transparent,
                    currentIndex: selectedIndexValue,
                    onTap: (index) {
                      if (index == selectedIndexValue) return;

                      switch (index) {
                        case 0:
                          drawerController.selectItem(t.patient_main.home);
                          selectedIndex.value = 0;
                          break;
                        case 1:
                          drawerController.selectItem(t.patient_main.favourite);
                          selectedIndex.value = 1;
                          break;
                        case 2:
                          drawerController.selectItem(
                            t.patient_main.appointment,
                          );
                          selectedIndex.value = 2;

                          break;
                        case 3:
                          drawerController.selectItem(t.patient_main.settings);
                          selectedIndex.value = 3;
                          break;
                        default:
                          drawerController.selectItem(t.patient_main.home);
                          selectedIndex.value = 0;
                      }
                    },
                    items: [
                      buildBottomNavigationBarItem(
                        iconName: AppAssets.icons.homeIcon.path,
                        index: 0,
                        selectedIndex: selectedIndexValue,
                        context: context,
                      ),
                      buildBottomNavigationBarItem(
                        iconName: AppAssets.icons.favouriteIcon.path,
                        index: 1,
                        selectedIndex: selectedIndexValue,
                        context: context,
                      ),
                      buildBottomNavigationBarItem(
                        iconName: AppAssets.icons.appointmentsIcon.path,
                        index: 2,
                        selectedIndex: selectedIndexValue,
                        context: context,
                      ),
                      buildBottomNavigationBarItem(
                        iconName: AppAssets.icons.settingsIcon.path,
                        index: 3,
                        selectedIndex: selectedIndexValue,
                        context: context,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.logout),
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: WidgetStatePropertyAll(AppColors.transparent),
        iconColor: WidgetStatePropertyAll(AppColors.white),
        iconSize: WidgetStatePropertyAll(25),
        textStyle: WidgetStatePropertyAll(context.medium20.rubik),
        foregroundColor: WidgetStatePropertyAll(AppColors.white),
      ),

      onPressed: () {
        DialogUtils.showMessage(
          context: context,
          message: t.settings.logout_confirmation,
          title: t.settings.logout,
          posActionText: t.dialog.ok,
          posAction: () {
            context.read<AuthBloc>().add(LogoutRequested());
          },
          negActionText: t.dialog.cancel,
        );
      },
      label: Text(t.settings.logout),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
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

  Widget buildDrawerIcon({required String iconName}) {
    return SvgPicture.asset(
      iconName,
      colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
      width: 15,
    );
  }
}
