import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../generated/style_atoms.dart';
import '../../../../generated/translations.g.dart';
import '../../../features/common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../theme/app_colors.dart';
import '../../utils/map_launcher_utils.dart';
import '../app_container_with_shadow.dart';

class ClinicLocationPreviewCard extends StatelessWidget {
  const ClinicLocationPreviewCard({
    super.key,
    required this.latitude,
    required this.longitude,
    this.clinicAddress,
    this.doctorName,
  });

  final double? latitude;
  final double? longitude;
  final String? clinicAddress;
  final String? doctorName;

  @override
  Widget build(BuildContext context) {
    final hasLocation = latitude != null && longitude != null;

    return AppContainerWithShadow(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasLocation
          ? _buildActiveLocationView(context)
          : _buildEmptyLocationView(context),
    );
  }

  Widget _buildActiveLocationView(BuildContext context) {
    final point = LatLng(latitude!, longitude!);
    final addressText = (clinicAddress != null && clinicAddress!.trim().isNotEmpty)
        ? clinicAddress!
        : '${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Non-interactive Mini Map
        GestureDetector(
          onTap: () => _openExternalMap(context),
          child: SizedBox(
            height: 170,
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    initialCenter: point,
                    initialZoom: 15.0,
                    interactionOptions: const InteractionOptions(
                      flags: InteractiveFlag.none,
                    ),
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName:
                          'com.abdallahelnshar.doctor_hunt',
                      tileProvider: NetworkTileProvider(),
                      errorTileCallback: (tile, error, stackTrace) {},
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: point,
                          width: 40,
                          height: 40,
                          alignment: Alignment.topCenter,
                          child: const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.brandPrimary,
                            size: 38,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Tap overlay hint
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.open_in_new_rounded,
                          size: 14,
                          color: AppColors.brandPrimary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          t.clinicLocation.getDirections,
                          style: context.regular12.brandPrimary.rubik,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // 2. Address & Action Section
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary20,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.location_on_rounded,
                      color: AppColors.brandPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.clinicLocation.title,
                          style: context.semiBold14.textPrimary.rubik,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          addressText,
                          style: context.regular12.textSecondary.rubik,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomElevatedButton(
                backgroundColor: AppColors.brandPrimary,
                borderRadius: 10,
                paddingVertical: 12,
                onPressed: () => _openExternalMap(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.directions_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      t.clinicLocation.getDirections,
                      style: context.semiBold14.white.rubik,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyLocationView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.bgSurfaceLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.location_off_outlined,
              color: AppColors.textSecondary,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            t.clinicLocation.locationNotSet,
            style: context.regular14.textSecondary.rubik,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _openExternalMap(BuildContext context) {
    if (latitude != null && longitude != null) {
      MapLauncherUtils.launchCoordinates(
        latitude: latitude!,
        longitude: longitude!,
        title: doctorName,
      );
    }
  }
}
