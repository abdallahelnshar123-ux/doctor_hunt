import 'dart:io';

import 'package:cupertino_onboarding/cupertino_onboarding.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/doctor_availability.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/slot_duration.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/working_days.dart';
import 'package:doctor_hunt/apps/core/data/models/doctor/working_hour.dart';
import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:doctor_hunt/apps/core/router/app_routes.dart';
import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/dialog_utils.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/app_user.dart';
import 'package:doctor_hunt/apps/features/common/auth/domain/entity/user/doctor.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_onboarding_screen/controller/doctor_onboarding_bloc.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_onboarding_screen/controller/doctor_onboarding_state.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_onboarding_screen/widget/doctor_onboarding_availability_tab.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_onboarding_screen/widget/doctor_onboarding_profile_tab.dart';
import 'package:doctor_hunt/apps/features/doctor/doctor_onboarding_screen/widget/doctor_onboarding_success_tab.dart';
import 'package:doctor_hunt/generated/style_atoms.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../controller/doctor_onboarding_event.dart';
import '../widget/doctor_onboarding_welcome_tab.dart';

class DoctorOnboardingScreen extends HookWidget {
  const DoctorOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select<UserBloc, AppUserEntity?>(
      (bloc) => bloc.currentUser,
    );
    final doctor = user is DoctorEntity ? user : null;

    final pageController = usePageController();
    final currentPage = useState(0);

    useEffect(() {
      void listener() {
        final page = pageController.page?.round();
        if (page != null && page != currentPage.value) {
          currentPage.value = page;
        }
      }

      pageController.addListener(listener);
      return () => pageController.removeListener(listener);
    }, [pageController]);

    // Profile state
    final profileFormKey = useMemoized(() => GlobalKey<FormState>());
    final phoneController = useTextEditingController(text: doctor?.phone ?? '');
    final feeController = useTextEditingController(
      text: doctor?.consultationFee != null
          ? doctor!.consultationFee.toString()
          : '',
    );
    final selectedImage = useRef<File?>(null);

    // Availability state
    final workingDays = useValueNotifier<List<WorkingDay>>(
      doctor?.availability?.workingDays ?? [],
    );
    final startTime = useRef(
      doctor?.availability?.startTime ?? WorkingHour.values.first,
    );
    final endTime = useRef(
      doctor?.availability?.endTime ?? WorkingHour.values.first,
    );
    final slotDuration = useRef(
      doctor?.availability?.slotDuration ?? SlotDuration.values.first,
    );

    void goToNextPage() {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    void handleContinue() {
      final page = currentPage.value;

      if (page == 0) {
        goToNextPage();
      } else if (page == 1) {
        // Validate profile form
        if (!profileFormKey.currentState!.validate()) {
          return;
        }

        final hasImage =
            selectedImage.value != null ||
            (doctor?.image != null && doctor!.image!.trim().isNotEmpty);
        if (!hasImage) {
          SnackBarUtils.showInfoSnackBar(
            context: context,
            message: t.doctor.onboarding.photoRequired,
          );
          return;
        }

        goToNextPage();
      } else if (page == 2) {
        // Validate working days
        if (workingDays.value.isEmpty) {
          SnackBarUtils.showInfoSnackBar(
            context: context,
            message: t.doctor.onboarding.selectAtLeastOneDay,
          );
          return;
        }

        if (startTime.value == endTime.value) {
          SnackBarUtils.showInfoSnackBar(
            context: context,
            message: t
                .doctor
                .availability
                .startTimeAndEndtimeMustBeDifferent,
          );
          return;
        }

        final fee = double.tryParse(feeController.text.trim()) ?? 0.0;
        final availability = DoctorAvailability(
          workingDays: workingDays.value,
          startTime: startTime.value,
          endTime: endTime.value,
          slotDuration: slotDuration.value,
        );

        context.read<DoctorOnboardingBloc>().add(
          SaveDoctorOnboardingRequested(
            image: selectedImage.value,
            phone: phoneController.text.trim(),
            consultationFee: fee,
            availability: availability,
          ),
        );
      }
    }

    return BlocListener<DoctorOnboardingBloc, DoctorOnboardingState>(
      listener: (context, state) {
        if (state is DoctorOnboardingLoading) {
          DialogUtils.showLoading(context: context);
        } else if (state is DoctorOnboardingError) {
          DialogUtils.hideLoading(context: context);
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        } else if (state is DoctorOnboardingSuccess) {
          DialogUtils.hideLoading(context: context);
          goToNextPage();
        }
      },
      child: AppScaffold(
        resizeToAvoidBottomInset: false,
        body: CupertinoOnboarding(
          backgroundColor: AppColors.transparent,
          controller: pageController,
          bottomButtonColor: AppColors.brandPrimary,
          bottomButtonChild: Text(
            currentPage.value < 2
                ? t.doctor.onboarding.continueBtn
                : (currentPage.value == 2
                      ? t.doctor.onboarding.saveAndContinue
                      : t.doctor.onboarding.finish),
            style: context.semiBold16.white.rubik,
          ),
          onPressed: handleContinue,
          onPressedOnLastPage: () {
            const DoctorMainRoute().go(context);
          },
          // scrollPhysics: NeverScrollableScrollPhysics(),
          bottomButtonPadding: EdgeInsets.all(20),
          pages: [
            const DoctorOnboardingWelcomeTab(),
            DoctorOnboardingProfileTab(
              formKey: profileFormKey,
              phoneController: phoneController,
              feeController: feeController,
              selectedImage: selectedImage,
              initialImageUrl: doctor?.image,
            ),
            DoctorOnboardingAvailabilityTab(
              workingDays: workingDays,
              startTime: startTime,
              endTime: endTime,
              slotDuration: slotDuration,
            ),
            const DoctorOnboardingSuccessTab(),
          ],
        ),
      ),
    );
  }
}
