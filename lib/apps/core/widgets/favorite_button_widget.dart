import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/common/auth/presentation/controller/user/user_bloc.dart';
import '../../features/common/auth/presentation/controller/user/user_event.dart';
import '../../features/common/auth/presentation/controller/user/user_state.dart';
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
          final prevFavs = previous.user?.patientInfo?.favDoctors ?? [];
          final currFavs = current.user?.patientInfo?.favDoctors ?? [];
          return prevFavs.contains(doctorId) != currFavs.contains(doctorId);
        },
        builder: (context, state) {
          final isFavorite =
              state.user?.patientInfo?.favDoctors.contains(doctorId) ?? false;

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
