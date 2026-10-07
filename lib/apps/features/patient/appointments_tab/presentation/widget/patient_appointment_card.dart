import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/app_assets.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';

class PatientAppointmentCard extends StatelessWidget {
  const PatientAppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        spacing: 10,
        crossAxisAlignment: .start,
        children: [
          ///doctor details
          Row(
            spacing: 15,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: .cover,
                    image: AssetImage(AppAssets.images.testDoctorImage.path),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: .spaceBetween,
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      crossAxisAlignment: .center,
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: 'test\n',
                            style: context.medium18.textTertiary.rubik,
                            children: [
                              TextSpan(
                                text: 'test',
                                style: context.light14.textSecondary.rubik,
                              ),
                            ],
                          ),
                          overflow: .ellipsis,
                        ),
                        Chip(
                          padding: EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(
                            width: 0,
                            color: AppColors.transparent,
                          ),
                          backgroundColor: AppColors.black,

                          // doctor.active
                          //     ? AppColors.brandPrimary20
                          //     : AppColors.statusErrorSurface,
                          avatarBoxConstraints: .tightFor(width: 15),
                          avatar: Icon(
                            Icons.circle,
                            size: 10,
                            color: AppColors.black,

                            // doctor.active
                            //     ? AppColors.brandPrimaryDark
                            //     : AppColors.statusError,
                          ),
                          label: Text(
                            t.patient_appointments.upcoming,
                            style: context.regular10.statusError.rubik,

                            // doctor.active
                            //     ? context.medium10.brandPrimaryDark.rubik
                            //     : context.regular10.statusError.rubik,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(color: AppColors.textSecondary, thickness: 0.2),

          /// appointment details
          Wrap(
            spacing: 30,
            runSpacing: 15,
            children: [
              _buildListTile(
                icon: Icons.calendar_month_outlined,
                title: t.patient_appointments.appointment_date,
                subtitle: "12/12/2023",
                context: context,
              ),
              _buildListTile(
                icon: Icons.access_time,
                title: t.patient_appointments.appointment_time,
                subtitle: '12:00',
                context: context,
              ),
              _buildListTile(
                icon: Icons.payments_outlined,
                title: t.patient_appointments.consultation_fee,
                subtitle: '12:00',
                context: context,
              ),
            ],
          ),

          /// buttons
          Row(
            spacing: 10,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  paddingVertical: 10,
                  borderRadius: 8,
                  backgroundColor: AppColors.white,
                  onPressed: () {},
                  borderSideColor: AppColors.brandPrimary,
                  child: FittedBox(
                    fit: .scaleDown,
                    child: Text(
                      t.patient_appointments.view_details,
                      style: context.medium11.brandPrimary.rubik,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: CustomElevatedButton(
                  paddingVertical: 10,
                  borderRadius: 8,
                  backgroundColor: AppColors.statusErrorSurface,
                  onPressed: () {},
                  borderSideColor: AppColors.statusError,
                  child: FittedBox(
                    fit: .scaleDown,
                    child: Text(
                      t.patient_appointments.cancel_appointment,
                      style: context.medium11.statusError.rubik,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required BuildContext context,
  }) {
    return Row(
      spacing: 10,
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      children: [
        Container(
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.brandPrimary8,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.brandPrimary),
        ),
        Text.rich(
          TextSpan(
            text: '$title \n',
            style: context.regular9.textSecondary.rubik,
            children: [
              TextSpan(
                text: subtitle,
                style: context.medium11.textTertiary.rubik,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildOutlinedButton({
  //   required Color backgroundColor,
  //   required VoidCallback onPressed,
  //   required String text,
  //   required BuildContext context,
  //   required TextStyle textStyle,
  //   required Color color,
  // }) {
  //   return CustomElevatedButton(
  //     backgroundColor: backgroundColor,
  //     onPressed: onPressed,
  //     borderSideColor: color,
  //     child: Text(text, style: textStyle),
  //   );
  // }
}

/*

AppContainerWithShadow(
      width: double.infinity,
      height: 120,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.white,
      ),
      child: Row(
        spacing: 15,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxHeight,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: .cover,
                  image: doctor.imageUrl != null && doctor.imageUrl!.isNotEmpty
                      ? CachedNetworkImageProvider(doctor.imageUrl!)
                      : AssetImage(AppAssets.images.testDoctorImage.path)
                            as ImageProvider,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Row(
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '${doctor.name}\n',
                        style: context.medium18.textTertiary.rubik,
                        children: [
                          TextSpan(
                            text: doctor.specialty.name,
                            style: context.light14.textSecondary.rubik,
                          ),
                        ],
                      ),
                      overflow: .ellipsis,
                    ),
                    FavoriteButtonWidget(doctorId: doctor.id, size: 25),
                  ],
                ),
                Row(
                  spacing: 6,
                  crossAxisAlignment: .center,
                  children: List.generate(
                    5,
                    (index) => SvgPicture.asset(
                      AppAssets.icons.starIconRated.path,
                      width: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

 */
