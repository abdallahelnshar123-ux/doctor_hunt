import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../generated/style_atoms.dart';
import '../../../generated/translations.g.dart';
import '../router/app_routes.dart';
import '../theme/app_colors.dart';
import '../../features/common/clinic_location_picker/data/models/location_result_model.dart';

class ClinicLocationFormTile extends StatelessWidget {
  const ClinicLocationFormTile({
    super.key,
    required this.latitudeNotifier,
    required this.longitudeNotifier,
    required this.addressNotifier,
    this.label,
    this.onLocationChanged,
  });

  final ValueNotifier<double?> latitudeNotifier;
  final ValueNotifier<double?> longitudeNotifier;
  final ValueNotifier<String?> addressNotifier;
  final String? label;
  final VoidCallback? onLocationChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: context.bold14.textTertiary.rubik,
          ),
          const SizedBox(height: 8),
        ],
        AnimatedBuilder(
          animation: Listenable.merge([
            latitudeNotifier,
            longitudeNotifier,
            addressNotifier,
          ]),
          builder: (context, _) {
            final hasLocation = latitudeNotifier.value != null &&
                longitudeNotifier.value != null;

            if (hasLocation) {
              return _buildLocationCard(context);
            }
            return _buildEmptyPickerTile(context);
          },
        ),
      ],
    );
  }

  Widget _buildLocationCard(BuildContext context) {
    final address = addressNotifier.value;
    final displayText = (address != null && address.trim().isNotEmpty)
        ? address
        : '${latitudeNotifier.value!.toStringAsFixed(4)}, ${longitudeNotifier.value!.toStringAsFixed(4)}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderMuted),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.brandPrimary20,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.location_on_rounded,
              color: AppColors.brandPrimary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.clinicLocation.title,
                  style: context.semiBold14.textPrimary.rubik,
                ),
                const SizedBox(height: 2),
                Text(
                  displayText,
                  style: context.regular12.textSecondary.rubik,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Edit Button
          IconButton(
            tooltip: t.clinicLocation.changeLocation,
            icon: const Icon(
              Icons.edit_location_alt_outlined,
              color: AppColors.brandPrimary,
              size: 22,
            ),
            onPressed: () => _openLocationPicker(context),
          ),
          // Remove Button
          IconButton(
            tooltip: t.clinicLocation.removeLocation,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.statusError,
              size: 22,
            ),
            onPressed: () => _clearLocation(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPickerTile(BuildContext context) {
    return Material(
      color: AppColors.bgSurfaceLight,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => _openLocationPicker(context),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColors.brandPrimary.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_location_alt_outlined,
                color: AppColors.brandPrimary,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                t.clinicLocation.pickLocation,
                style: context.medium14.brandPrimary.rubik,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openLocationPicker(BuildContext context) async {
    final result = await context.push<LocationResultModel>(
      ClinicLocationPickerRoute(
        initialLat: latitudeNotifier.value,
        initialLng: longitudeNotifier.value,
        initialAddress: addressNotifier.value,
      ).location,
    );

    if (result != null) {
      if (result.isCleared) {
        latitudeNotifier.value = null;
        longitudeNotifier.value = null;
        addressNotifier.value = null;
      } else if (result.hasLocation) {
        latitudeNotifier.value = result.latitude;
        longitudeNotifier.value = result.longitude;
        addressNotifier.value = result.address;
      }
      onLocationChanged?.call();
    }
  }

  void _clearLocation(BuildContext context) {
    latitudeNotifier.value = null;
    longitudeNotifier.value = null;
    addressNotifier.value = null;
    onLocationChanged?.call();
  }
}
