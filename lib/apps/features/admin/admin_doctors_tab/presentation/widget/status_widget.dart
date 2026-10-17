part of '../screens/admin_doctors_tab.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key});

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
              child: buildListTile(
                title: t.admin.doctors_tab.total_doctors,
                number: context.select<AdminDoctorsBloc, String>((bloc) {
                  final currentState = bloc.state;
                  return currentState is AdminDoctorsSuccess
                      ? currentState.allDoctors.length.toString()
                      : t.admin.doctors_tab.dash;
                }),
                context: context,
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
              child: BlocBuilder<AdminDoctorsBloc, AdminDoctorsState>(
                buildWhen: (previous, current) =>
                    current is AdminDoctorsSuccess ||
                    current is AdminDoctorsLoading,
                builder: (context, state) {
                  return buildListTile(
                    title: t.admin.doctors_tab.active,
                    number: state is AdminDoctorsSuccess
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
      title: FittedBox(
        alignment: .centerLeft,
        fit: .scaleDown,
        child: Text(title, textAlign: .start),
      ),
      subtitle: Text(number),
    );
  }
}
