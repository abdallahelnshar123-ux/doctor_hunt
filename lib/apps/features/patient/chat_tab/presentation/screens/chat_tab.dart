import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_bloc.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTab extends StatelessWidget {
  const ChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          context.read<AuthBloc>().add(LogoutRequested());
        },
        icon: Icon(Icons.logout, color: AppColors.statusError, size: 40),
      ),
    );
  }
}
