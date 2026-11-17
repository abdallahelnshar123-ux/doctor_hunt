import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../controller/clinic_location_picker_bloc.dart';
import '../controller/clinic_location_picker_event.dart';
import '../controller/clinic_location_picker_state.dart';

class LocationActionButtons extends StatelessWidget {
  const LocationActionButtons({
    super.key,
    required this.mapController,
  });

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClinicLocationPickerBloc, ClinicLocationPickerState>(
      buildWhen: (prev, curr) =>
          prev.isGpsLoading != curr.isGpsLoading ||
          prev.hasInitialLocation != curr.hasInitialLocation,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 10,
          children: [
            if (state.hasInitialLocation)
              _ActionButton(
                icon: Icons.delete_outline_rounded,
                iconColor: AppColors.statusError,
                onTap: () => _confirmRemoveLocation(context),
              ),
            _ActionButton(
              icon: Icons.add_rounded,
              onTap: () {
                final currentZoom = mapController.camera.zoom;
                if (currentZoom < 18) {
                  mapController.move(
                    mapController.camera.center,
                    currentZoom + 1,
                  );
                }
              },
            ),
            _ActionButton(
              icon: Icons.remove_rounded,
              onTap: () {
                final currentZoom = mapController.camera.zoom;
                if (currentZoom > 3) {
                  mapController.move(
                    mapController.camera.center,
                    currentZoom - 1,
                  );
                }
              },
            ),
            _ActionButton(
              icon: Icons.my_location_rounded,
              iconColor: AppColors.brandPrimary,
              isLoading: state.isGpsLoading,
              onTap: () {
                context
                    .read<ClinicLocationPickerBloc>()
                    .add(const LocateMeRequestedEvent());
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmRemoveLocation(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          t.clinicLocation.removeLocation,
          style: context.medium18.textPrimary.rubik,
        ),
        content: Text(
          t.clinicLocation.removeLocationConfirm,
          style: context.regular14.textSecondary.rubik,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              t.core.dialogs.cancel,
              style: context.medium14.textSecondary.rubik,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext, true);
              context
                  .read<ClinicLocationPickerBloc>()
                  .add(const RemoveLocationRequestedEvent());
            },
            child: Text(
              t.clinicLocation.removeLocation,
              style: context.medium14.statusError.rubik,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    this.iconColor,
    this.isLoading = false,
    required this.onTap,
  });

  final IconData icon;
  final Color? iconColor;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      elevation: 4,
      shadowColor: AppColors.black.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: SizedBox(
          width: 46,
          height: 46,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.2,
                      color: AppColors.brandPrimary,
                    ),
                  )
                : Icon(
                    icon,
                    size: 24,
                    color: iconColor ?? AppColors.textPrimary,
                  ),
          ),
        ),
      ),
    );
  }
}
