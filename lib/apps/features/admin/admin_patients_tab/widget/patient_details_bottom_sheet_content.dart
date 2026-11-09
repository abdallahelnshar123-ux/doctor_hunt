part of '../presentation/screens/admin_patients_tab.dart';

class _PatientDetailsBottomSheetContent extends HookWidget {
  const _PatientDetailsBottomSheetContent({
    required this.patient,
    required this.actionBloc,
    required this.patientsBloc,
  });

  final PatientEntity patient;
  final AdminPatientActionBloc actionBloc;
  final AdminPatientsBloc patientsBloc;

  @override
  Widget build(BuildContext context) {
    final isActive = useValueNotifier(!patient.disabled);

    return BlocListener<AdminPatientActionBloc, AdminPatientActionState>(
      bloc: actionBloc,
      listener: (context, state) {
        if (state is TogglePatientActiveStatusError) {
          isActive.value = !isActive.value;
          patientsBloc.add(
            AdminUpdatePatientStatusLocally(
              patientId: patient.id,
              disabled: !isActive.value,
            ),
          );
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.message,
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: patient.image != null
                      ? CachedNetworkImageProvider(patient.image!)
                      : AssetImage(AppAssets.images.fallbackUserImage.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(patient.email, style: context.regular14.textSecondary.rubik),
            const SizedBox(height: 30),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                patient.name,
                style: context.medium18.textPrimary.rubik,
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                patient.phone ?? '',
                style: context.regular14.textSecondary.rubik,
              ),
            ),
            const SizedBox(height: 30),
            AccountStatusSwitchTile(
              isActive: isActive,
              onChanged: (newValue) {
                isActive.value = newValue;
                actionBloc.add(
                  TogglePatientDisabledStatusRequested(
                    patientId: patient.id,
                    disabled: !newValue,
                  ),
                );
                patientsBloc.add(
                  AdminUpdatePatientStatusLocally(
                    patientId: patient.id,
                    disabled: !newValue,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
