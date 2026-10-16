import 'package:doctor_hunt/apps/core/widgets/app_container_with_shadow.dart';
import 'package:doctor_hunt/apps/core/widgets/appointment_review_read_only_widget.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/features/patient/appointments_tab/data/models/appointment/appointment.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_scaffold.dart';
import '../../../../../core/widgets/custom_cached_network_image.dart';

class PatientAppointmentDetailsScreen extends StatelessWidget {
  const PatientAppointmentDetailsScreen({super.key, required this.appointment});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: AppScaffold(
        body: Column(
          children: [
            MainAppBar(title: t.admin.appointment_details.title),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(20),
                children: [
                  _buildText(
                    context: context,
                    text: t.admin.appointment_details.doctor,
                  ),
                  _buildPatientCard(
                    title: appointment.doctor.name,
                    subtitle: appointment.doctor.specialty.name,
                    image: appointment.doctor.imageUrl,
                    context: context,
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      _buildText(
                        context: context,
                        text: t.admin.appointment_details.appointment,
                      ),
                      _buildStatusChip(context: context),
                    ],
                  ),
                  AppContainerWithShadow(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Wrap(
                      spacing: 30,
                      runSpacing: 15,
                      children: [
                        _buildDetailsListTile(
                          icon: Icons.calendar_month_outlined,
                          title: t.admin.appointments_tab.date,
                          subtitle: DateFormat(
                            'dd MMM yyyy',
                          ).format(appointment.sessionTime),
                          context: context,
                        ),
                        _buildDetailsListTile(
                          icon: Icons.access_time,
                          title: t.admin.appointments_tab.time,
                          subtitle: DateFormat(
                            'hh:mm a',
                          ).format(appointment.sessionTime),
                          context: context,
                        ),
                        _buildDetailsListTile(
                          icon: Icons.payments_outlined,
                          title: t.admin.appointments_tab.fee,
                          subtitle: t.patient_appointments.fee_value(
                            Fee: appointment.fee.toString(),
                          ),
                          context: context,
                        ),
                      ],
                    ),
                  ),SizedBox(height: 20),
                  ?appointment.review != null
                      ? AppointmentReviewReadOnlyWidget(
                          review: appointment.review!,
                        )
                      : null,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsListTile({
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

  Widget _buildPatientCard({
    required String title,
    required String subtitle,
    required String? image,
    required BuildContext context,
  }) {
    return AppContainerWithShadow(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        spacing: 15,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                fit: .cover,
                image: CustomCachedNetworkImage.getProvider(image),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Text(
                  title,
                  style: context.medium14.textTertiary.rubik,
                  overflow: .ellipsis,
                ),
                Text(
                  subtitle,
                  style: context.regular12.textCaption.rubik,
                  overflow: .ellipsis,
                ),
                Text(
                  appointment.doctor.specialty.name,
                  style: context.light10.textSecondary.rubik,
                  overflow: .ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip({required BuildContext context}) {
    return Chip(
      padding: EdgeInsets.all(5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      side: BorderSide(width: 0, color: AppColors.transparent),
      backgroundColor: appointment.status != AppointmentStatus.cancelled
          ? AppColors.brandPrimary20
          : AppColors.statusErrorSurface,
      avatarBoxConstraints: .tightFor(width: 15),
      avatar: Icon(
        Icons.circle,
        size: 10,
        color: appointment.status != AppointmentStatus.cancelled
            ? AppColors.brandPrimaryDark
            : AppColors.statusError,
      ),
      label: Text(
        appointment.status.name,
        style: appointment.status != AppointmentStatus.cancelled
            ? context.medium9.brandPrimaryDark.rubik
            : context.regular9.statusError.rubik,
      ),
    );
  }

  Widget _buildText({required BuildContext context, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Text(text, style: context.bold14.textTertiary.rubik),
    );
  }
}
