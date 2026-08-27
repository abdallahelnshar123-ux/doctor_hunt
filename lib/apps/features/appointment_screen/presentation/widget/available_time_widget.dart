import 'package:doctor_hunt/apps/features/appointment_screen/presentation/widget/time_list_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';

class AvailableTimeWidget extends StatelessWidget {
  const AvailableTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final availableTimeList = [
      '10:00\n${t.common.am}',
      '12:00\n${t.common.am}',
      '02:00\n${t.common.pm}',
      '03:00\n${t.common.pm}',
      '04:00\n${t.common.pm}',
      '06:00\n${t.common.pm}',
      '07:00\n${t.common.pm}',
    ];

    final reminderMinuteList = [
      '30\n${t.common.min}',
      '40\n${t.common.min}',
      '25\n${t.common.min}',
      '10\n${t.common.min}',
      '35\n${t.common.min}',
      '45\n${t.common.min}',
      '50\n${t.common.min}',
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _titleWidget(
            text: t.appointment.available_time,
            context: context,
          ),
        ),
        SliverToBoxAdapter(child: TimeListWidget(list: availableTimeList)),
        SliverToBoxAdapter(
          child: _titleWidget(
            text: t.appointment.reminder_me,
            context: context,
          ),
        ),
        SliverToBoxAdapter(child: TimeListWidget(list: reminderMinuteList)),
        SliverPadding(
          padding: EdgeInsets.all(50),
          sliver: SliverToBoxAdapter(
            child: CustomElevatedButton(
              borderRadius: 6,
              backgroundColor: AppColors.brandPrimary,
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Container(
                    padding: EdgeInsets.all(25),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 130),
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.bgPrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(40),
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: .circle,
                            color: AppColors.brandPrimary20,
                          ),
                          child: SvgPicture.asset(
                            AppAssets.icons.likeIcon.path,
                            width: double.infinity,
                          ),
                        ),
                        Text(
                          t.appointment.thank_you,
                          style: context.medium38.black.rubik,
                          textAlign: .center,
                        ),
                        FittedBox(
                          fit: .scaleDown,
                          child: Text(
                            t.appointment.success,
                            style: context.regular20.textSecondary.rubik,
                            textAlign: .center,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          t.appointment.booking_details(
                            Doctor: 'Pediatrician Purpieson',
                            Date: 'February 21',
                            Time: '02:00 ${t.common.pm}',
                          ),
                          style: context.regular14.textSecondary.rubik,
                          textAlign: .center,
                        ),
                        SizedBox(height: 30),
                        CustomElevatedButton(
                          buttonWidth: double.infinity,
                          borderRadius: 6,
                          backgroundColor: AppColors.brandPrimary,
                          onPressed: () {
                            context.pop();
                          },
                          child: Text(
                            t.appointment.done,
                            style: context.medium18.white.rubik,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            t.appointment.edit,
                            style: context.regular14.textSecondary.rubik,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text(
                t.appointment.confirm,
                style: context.medium18.white.rubik,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleWidget({required String text, required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(text, style: context.medium16.textTertiary.rubik),
    );
  }
}
