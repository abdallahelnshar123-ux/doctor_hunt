import 'package:doctor_hunt/apps/features/appointment_screen/presentation/widget/time_list_widget.dart';
import 'package:doctor_hunt/generated/app_assets.dart';
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _titleWidget(text: 'Available Time', context: context),
        ),
        SliverToBoxAdapter(child: TimeListWidget(list: availableTimeList)),
        SliverToBoxAdapter(
          child: _titleWidget(text: 'Reminder Me Before', context: context),
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
                          'Thank You !',
                          style: context.medium38.black.rubik,
                          textAlign: .center,
                        ),
                        FittedBox(
                          fit: .scaleDown,
                          child: Text(
                            'Your Appointment Successful',
                            style: context.regular20.textSecondary.rubik,
                            textAlign: .center,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'You booked an appointment with '
                          'Dr.Pediatrician Purpieson on February'
                          ' 21, at 02:00 PM',
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
                            'Done',
                            style: context.medium18.white.rubik,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Edit your appointment',
                            style: context.regular14.textSecondary.rubik,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Text('Confirm', style: context.medium18.white.rubik),
            ),
          ),
        ),
      ],
    );
  }

  Widget _titleWidget({required String text, required BuildContext context}) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Text(text, style: context.medium16.textTertiary.rubik),
    );
  }
}

const List<String> availableTimeList = [
  '10:00\nAm',
  '12:00\nAm',
  '02:00\nPm',
  '03:00\nPm',
  '04:00\nPm',
  '06:00\nPm',
  '07:00\nPm',
];

const List<String> reminderMinuteList = [
  '30\nMin.',
  '40\nMin.',
  '25\nMin.',
  '10\nMin.',
  '35\nMin.',
  '45\nMin.',
  '50\nMin.',
];
