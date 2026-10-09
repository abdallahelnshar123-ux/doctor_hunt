import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/style_atoms.dart';
import '../../../generated/translations.g.dart';
import '../../features/common/auth/presentation/controller/auth/auth_bloc.dart';
import '../theme/app_colors.dart';
import '../utils/dialog_utils.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(Icons.logout),
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
        backgroundColor: WidgetStatePropertyAll(AppColors.statusErrorSurface),
        iconColor: WidgetStatePropertyAll(AppColors.statusError),
        iconSize: WidgetStatePropertyAll(20),
        textStyle: WidgetStatePropertyAll(context.semiBold14.statusError.rubik),
        foregroundColor: WidgetStatePropertyAll(AppColors.statusError),
      ),

      onPressed: () {
        DialogUtils.showMessage(
          context: context,
          message: t.settings.logout_confirmation,
          title: t.settings.logout,
          posActionText: t.dialog.ok,
          posAction: () {
            context.read<AuthBloc>().add(LogoutRequested());
          },
          negActionText: t.dialog.cancel,
        );
      },
      label: Text(t.settings.logout),
    );
  }
}
