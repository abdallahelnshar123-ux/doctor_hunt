import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../../../generated/translations.g.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/snack_bar_utils.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../../../../common/specialties/presentation/controller/specialties_bloc.dart';
import '../../../../common/specialties/presentation/controller/specialties_event.dart';
import '../../../../common/specialties/presentation/controller/specialties_state.dart';

class AddSpecialtyDialog extends HookWidget {
  const AddSpecialtyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final englishController = useTextEditingController();
    final arabicController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());
    return  Material(
      color: AppColors.transparent,
      child: Container(
          padding: EdgeInsets.all(25),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 200),
          // width: double.infinity,
          // height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bgPrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: BlocConsumer<SpecialtiesBloc, SpecialtiesState>(
            buildWhen: (previous, current) => current.failureMessage == null,
            builder: (context, state) {
              if (state.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    _buildText(
                      context: context,
                      text: t.admin.addDoctorScreen.englishName,
                    ),
                    CustomTextFormField(
                      controller: englishController,
                      validator: (value) => Validators.required(value) ,
                      hintText: t.admin.addDoctorScreen.englishName,
                    ),
                    _buildText(
                      context: context,
                      text: t.admin.addDoctorScreen.arabicName,
                    ),
                    CustomTextFormField(
                      controller: arabicController,
                      validator: (value) => Validators.required(value),
                      hintText: t.admin.addDoctorScreen.arabicName,
                    ),
                    SizedBox(height: 30),
                    _buildCreateDoctorButton(
                      context: context,
                      formKey: formKey,
                      englishController: englishController,
                      arabicController: arabicController,
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(40),
                    //   width: 150,
                    //   height: 150,
                    //   decoration: BoxDecoration(
                    //     shape: .circle,
                    //     color: AppColors.brandPrimary20,
                    //   ),
                    //   child: SvgPicture.asset(
                    //     AppAssets.icons.likeIcon.path,
                    //     width: double.infinity,
                    //   ),
                    // ),
                    // Text(
                    //   t.appointment.thankYou,
                    //   style: context.medium38.black.rubik,
                    //   textAlign: .center,
                    // ),
                    // FittedBox(
                    //   fit: .scaleDown,
                    //   child: Text(
                    //     t.appointment.success,
                    //     style: context.regular20.textSecondary.rubik,
                    //     textAlign: .center,
                    //   ),
                    // ),
                    // SizedBox(height: 30),
                    // Text(
                    //   "ihdi",
                    //   style: context.regular14.textSecondary.rubik,
                    //   textAlign: .center,
                    // ),
                    // SizedBox(height: 30),
                    // CustomElevatedButton(
                    //   buttonWidth: double.infinity,
                    //   borderRadius: 6,
                    //   backgroundColor: AppColors.brandPrimary,
                    //   onPressed: () {
                    //     const PatientMainRoute().go(context);
                    //   },
                    //   child: Text(
                    //     t.appointment.done,
                    //     style: context.medium18.white.rubik,
                    //   ),
                    // ),
                  ],
                ),
              );
            },
            listener: (context, state) {
              if (state.actionSuccessMessage != null) {
                context.pop(context);
              }
              if (state.failureMessage != null) {
                SnackBarUtils.showErrorSnackBar(
                  context: context,
                  message: state.failureMessage?? "",
                );
              }
            },
          ),

      ),
    );
  }


  Widget _buildText({required BuildContext context, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: context.medium14.textTertiary.rubik),
    );
  }

  Widget _buildCreateDoctorButton({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController englishController,
    required TextEditingController arabicController,
  }) {
    return CustomElevatedButton(
      backgroundColor: AppColors.brandPrimary,
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        debugPrint('===============================');
        debugPrint(englishController.text);
        debugPrint('===============================');
        if (formKey.currentState!.validate()) {
          context.read<SpecialtiesBloc>().add(
            AddSpecialtyEvent(
              en: englishController.text,
              ar: arabicController.text,
            ),
          );
        }
      },
      child: Text(
        t.admin.addDoctorScreen.addSpecialty,
        style: context.medium18.white.rubik,
      ),
    );
  }
}
