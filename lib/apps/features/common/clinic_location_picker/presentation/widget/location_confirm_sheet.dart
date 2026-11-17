import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../auth/presentation/widgets/custom_elevated_button.dart';
import '../controller/clinic_location_picker_bloc.dart';
import '../controller/clinic_location_picker_event.dart';
import '../controller/clinic_location_picker_state.dart';

class LocationConfirmSheet extends HookWidget {
  const LocationConfirmSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final addressController = useTextEditingController();
    final isEditing = useState<bool>(false);

    return BlocConsumer<ClinicLocationPickerBloc, ClinicLocationPickerState>(
      listenWhen: (prev, curr) => prev.address != curr.address,
      listener: (context, state) {
        if (!isEditing.value) {
          addressController.text = state.address;
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: AppColors.borderMuted,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Location Details Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.brandPrimary20,
                        shape: BoxShape.circle,
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
                        children: [
                          Text(
                            t.clinicLocation.title,
                            style: context.semiBold16.textPrimary.rubik,
                          ),
                          const SizedBox(height: 4),
                          if (state.isAddressLoading)
                            Row(
                              children: [
                                const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.brandPrimary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  t.clinicLocation.addressLoading,
                                  style: context.regular12.textSecondary.rubik,
                                ),
                              ],
                            )
                          else if (isEditing.value)
                            TextField(
                              controller: addressController,
                              autofocus: true,
                              style: context.regular14.textPrimary.rubik,
                              decoration: InputDecoration(
                                hintText: t.clinicLocation.clinicAddressHint,
                                hintStyle: context.regular12.textCaption.rubik,
                                isDense: true,
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.brandPrimary,
                                  ),
                                ),
                              ),
                              onChanged: (text) {
                                context
                                    .read<ClinicLocationPickerBloc>()
                                    .add(AddressChangedEvent(text));
                              },
                            )
                          else
                            Text(
                              state.address.isNotEmpty
                                  ? state.address
                                  : t.clinicLocation.addressFailed,
                              style: context.regular14.textSecondary.rubik,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isEditing.value
                            ? Icons.check_circle_outline_rounded
                            : Icons.edit_outlined,
                        color: AppColors.brandPrimary,
                        size: 22,
                      ),
                      onPressed: () {
                        if (isEditing.value) {
                          context.read<ClinicLocationPickerBloc>().add(
                                AddressChangedEvent(addressController.text),
                              );
                        }
                        isEditing.value = !isEditing.value;
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // Confirm button
                CustomElevatedButton(
                  backgroundColor: AppColors.brandPrimary,
                  buttonWidth: double.infinity,
                  onPressed: () {
                    // Update address from controller if modified
                    if (addressController.text.trim().isNotEmpty) {
                      context.read<ClinicLocationPickerBloc>().add(
                            AddressChangedEvent(addressController.text.trim()),
                          );
                    }
                    context.read<ClinicLocationPickerBloc>().add(
                          const ConfirmLocationRequestedEvent(),
                        );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        t.clinicLocation.confirmLocation,
                        style: context.semiBold16.white.rubik,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
