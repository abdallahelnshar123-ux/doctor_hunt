import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../../core/widgets/main_app_bar.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../controller/clinic_location_picker_bloc.dart';
import '../controller/clinic_location_picker_event.dart';
import '../controller/clinic_location_picker_state.dart';
import '../widget/center_marker_pin.dart';
import '../widget/location_action_buttons.dart';
import '../widget/location_confirm_sheet.dart';

class ClinicLocationPickerScreen extends HookWidget {
  const ClinicLocationPickerScreen({
    super.key,
    this.initialLat,
    this.initialLng,
    this.initialAddress,
  });

  final double? initialLat;
  final double? initialLng;
  final String? initialAddress;

  @override
  Widget build(BuildContext context) {
    final mapController = useMemoized(() => MapController());

    useEffect(() {
      context.read<ClinicLocationPickerBloc>().add(
            ClinicLocationPickerInitEvent(
              initialLat: initialLat,
              initialLng: initialLng,
              initialAddress: initialAddress,
            ),
          );
      return null;
    }, const []);

    return BlocConsumer<ClinicLocationPickerBloc, ClinicLocationPickerState>(
      listenWhen: (prev, curr) =>
          prev.confirmedResult != curr.confirmedResult ||
          prev.errorMessage != curr.errorMessage ||
          prev.animateToTarget != curr.animateToTarget,
      listener: (context, state) {
        if (state.confirmedResult != null) {
          Navigator.of(context).pop(state.confirmedResult);
          return;
        }

        if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
          SnackBarUtils.showErrorSnackBar(
            context: context,
            message: state.errorMessage!,
          );
        }

        if (state.animateToTarget != null) {
          mapController.move(state.animateToTarget!, 15.5);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              // 1. Interactive Map
              Positioned.fill(
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: state.currentCenter,
                    initialZoom: 15.0,
                    minZoom: 3.0,
                    maxZoom: 18.0,
                    onPositionChanged: (camera, hasGesture) {
                      if (hasGesture) {
                        context
                            .read<ClinicLocationPickerBloc>()
                            .add(MapCenterChangedEvent(camera.center));
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName:
                          'com.abdallahelnshar.doctor_hunt',
                      tileProvider: NetworkTileProvider(),
                      errorTileCallback: (tile, error, stackTrace) {
                        // Offline or tile load failure handled gracefully
                      },
                    ),
                  ],
                ),
              ),

              // 2. Fixed Center Pin
              const CenterMarkerPin(),

              // 3. Top App Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.white.withValues(alpha: 0.95),
                        AppColors.white.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                  child: SafeArea(
                    bottom: false,
                    child: MainAppBar(
                      title: t.clinicLocation.title,
                      backgroundColor: AppColors.transparent,
                      titleStyle: context.semiBold18.textPrimary.rubik,
                      onPressed: () => Navigator.of(context).pop(null),
                    ),
                  ),
                ),
              ),

              // 4. Action Buttons (Locate Me, Zoom, Remove)
              Positioned(
                bottom: 230,
                right: 16,
                child: LocationActionButtons(mapController: mapController),
              ),

              // 5. Bottom Confirmation Sheet
              const Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: LocationConfirmSheet(),
              ),
            ],
          ),
        );
      },
    );
  }
}
