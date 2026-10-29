import 'package:doctor_hunt/apps/core/presentation/controller/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/common/auth/domain/entity/user/patient.dart';
import '../presentation/controller/user/user_event.dart';
import '../presentation/controller/user/user_state.dart';
import '../theme/app_colors.dart';
import '../utils/snack_bar_utils.dart';

class FavoriteButtonWidget extends StatelessWidget {
  final String doctorId;
  final double size;
  final bool readOnly;

  const FavoriteButtonWidget({
    super.key,
    required this.doctorId,
    this.size = 20,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          previous.favoriteError != current.favoriteError &&
          current.favoriteError != null,
      listener: (context, state) {
        if (state.favoriteError != null) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.favoriteError!,
          );
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
        buildWhen: (previous, current) {
          final previousPatient = previous.user is PatientEntity
              ? previous.user as PatientEntity
              : null;
          final currentPatient = current.user is PatientEntity
              ? current.user as PatientEntity
              : null;
          final prevFavs = previousPatient?.favDoctors ?? [];
          final currFavs = currentPatient?.favDoctors ?? [];
          return prevFavs.contains(doctorId) != currFavs.contains(doctorId);
        },
        builder: (context, state) {
          final patient = state.user is PatientEntity
              ? state.user as PatientEntity
              : null;
          final isFavorite = patient?.favDoctors.contains(doctorId) ?? false;

          return GestureDetector(
            onTap: readOnly == true
                ? null
                : () {
                    context.read<UserBloc>().add(
                      ToggleFavoriteDoctorEvent(doctorId),
                    );
                  },
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.badge : AppColors.textMuted,
              size: size,
            ),
          );
        },
      ),
    );
  }
}
