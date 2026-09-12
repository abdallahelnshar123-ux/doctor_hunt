part of '../screens/admin_doctors_tab.dart';

class StatuesWidget extends StatelessWidget {
  const StatuesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        spacing: 12,
        children: [
          Expanded(
            child: AppContainerWithShadow(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: BlocBuilder<DoctorBloc, DoctorState>(
                buildWhen: (previous, current) =>
                    current is GetDoctorsSuccessState ||
                    current is GetDoctorsLoadingState,
                builder: (context, state) {
                  return buildListTile(
                    title: t.admin.doctors_tab.total_doctors,
                    number: state is GetDoctorsSuccessState
                        ? state.doctors.length.toString()
                        : '-',
                    context: context,
                  );
                },
              ),
            ),
          ),

          Expanded(
            child: AppContainerWithShadow(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: BlocBuilder<DoctorBloc, DoctorState>(
                buildWhen: (previous, current) =>
                    current is GetDoctorsSuccessState ||
                    current is GetDoctorsLoadingState,
                builder: (context, state) {
                  return buildListTile(
                    title: t.admin.doctors_tab.active,
                    number: state is GetDoctorsSuccessState
                        ? state.activeDoctorsCount.toString()
                        : '-',
                    context: context,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required String number,
    required BuildContext context,
  }) {
    return ListTile(
      titleTextStyle: context.regular11.textSecondary.rubik,
      subtitleTextStyle: context.bold18.textPrimary.rubik.copyWith(height: 2),
      // leading: CircleAvatar(
      //   backgroundColor: AppColors.brandPrimary20,
      //   child: Icon(Icons.person_2_outlined, color: AppColors.brandPrimaryDark),
      // ),
      title: FittedBox(
        alignment: .centerLeft,
        fit: .scaleDown,
        child: Text(title, textAlign: .start),
      ),
      subtitle: Text(number),
    );
  }
}
