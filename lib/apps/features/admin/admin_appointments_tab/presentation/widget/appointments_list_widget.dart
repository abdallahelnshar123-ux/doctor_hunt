part of '../screens/admin_appointments_tab.dart';

class AppointmentsListWidget extends StatelessWidget {
  const AppointmentsListWidget({
    super.key,
    required this.allAppointmentsList,
    required this.index,
  });

  final List<Appointment> allAppointmentsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    final filteredAppointments = _buildAppointmentsList(
      allAppointmentsList: allAppointmentsList,
      index: index,
    );

    if (filteredAppointments.isEmpty) {
      return MainEmptyListWidget(
        title: t.patient_appointments.no_appointments_found,
      );
    }
    return SafeArea(
      top: false,
      child: ListView.separated(
        itemBuilder: (context, index) {
          final appointment = filteredAppointments[index];
          return AdminAppointmentCard(
            key: ValueKey(appointment.id),
            appointment: appointment,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemCount: filteredAppointments.length,
        padding: const EdgeInsets.all(20),
      ),
    );
  }

  List<Appointment> _buildAppointmentsList({
    required List<Appointment> allAppointmentsList,
    required int index,
  }) {
    switch (index) {
      case 0:
        return allAppointmentsList
            .where(
              (appointment) => appointment.status == AppointmentStatus.upcoming,
            )
            .toList();

      case 1:
        return allAppointmentsList
            .where(
              (appointment) =>
                  appointment.status == AppointmentStatus.completed,
            )
            .toList();

      case 2:
        return allAppointmentsList
            .where(
              (appointment) =>
                  appointment.status == AppointmentStatus.cancelled,
            )
            .toList();
    }
    return allAppointmentsList;
  }
}
