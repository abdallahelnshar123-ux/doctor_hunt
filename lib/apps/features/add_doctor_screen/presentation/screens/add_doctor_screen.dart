import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/widgets/app_scaffold.dart';
import 'package:doctor_hunt/apps/core/widgets/main_app_bar.dart';
import 'package:doctor_hunt/apps/core/widgets/username_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/add_doctor_screen/presentation/widget/specialty_dropdown_widget.dart';
import 'package:doctor_hunt/apps/features/auth/presentation/widgets/custom_elevated_button.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/style_atoms.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  State<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      body: Column(
        children: [
          MainAppBar(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                UsernameTextFieldWidget(
                  fillColor: AppColors.bgPrimary,
                  hintText: t.admin.enter_name,
                ),
                SizedBox(height: 20),
                SpecialtyDropdownWidget(controller: specialtyController),
                SizedBox(height: 50),
                buildUploadImage(context),
                SizedBox(height: 50),

                CustomElevatedButton(
                  backgroundColor: AppColors.brandPrimary,
                  onPressed: () {},
                  child: Text(
                    t.admin.create_doctor,
                    style: context.medium18.white.rubik,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildUploadImage(BuildContext context) {
    final t = Translations.of(context);
    return GestureDetector(
      onTap: () {},
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          stackFit: .loose,
          radius: Radius.circular(12),
          strokeCap: .round,
          dashPattern: const [8, 4],
          color: AppColors.borderDefault,
          strokeWidth: 2,
        ),

        child: Container(
          height: 250,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: AppColors.bgPrimary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            spacing: 5,
            mainAxisAlignment: .center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: 40,
                color: AppColors.textSecondary,
              ),
              SizedBox(height: 5),
              Text(
                t.admin.upload_image,
                style: context.medium14.textTertiary.rubik,
              ),
              Text(
                t.admin.tap_to_pick,
                style: context.regular12.textSecondary.rubik,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
