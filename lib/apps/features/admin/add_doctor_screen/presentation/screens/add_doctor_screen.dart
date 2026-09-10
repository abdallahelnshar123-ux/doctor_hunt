import 'package:doctor_hunt/apps/core/theme/app_colors.dart';
import 'package:doctor_hunt/apps/core/utils/snack_bar_utils.dart';
import 'package:doctor_hunt/apps/core/widgets/username_text_field_widget.dart';
import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/controller/doctor_bloc.dart';
import 'package:doctor_hunt/generated/translations.g.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/style_atoms.dart';
import '../../../../common/auth/presentation/widgets/custom_elevated_button.dart';
import '../widget/specialty_dropdown_widget.dart';

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
    return Scaffold(
      appBar: AppBar(title: Text(t.create_doctor.title)),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          buildUploadImage(context),
          TextButton(
            onPressed: () {
              context.read<DoctorBloc>().add(PickDoctorImageRequested());
            },
            child: Text(
              t.create_doctor.add_photo,
              style: context.medium12.brandPrimary.rubik,
            ),
          ),
          SizedBox(height: 40),

          UsernameTextFieldWidget(
            fillColor: AppColors.bgPrimary,
            hintText: t.admin.enter_name,
          ),
          SizedBox(height: 20),
          SpecialtyDropdownWidget(controller: specialtyController),
          SizedBox(height: 50),
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
    );
  }

  Widget buildUploadImage(BuildContext context) {
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(shape: .circle),
      width: 120,

      height: 120,
      alignment: .center,
      child: BlocConsumer<DoctorBloc, DoctorState>(
        listener: (context, state) {
          if (state is PickDoctorImageErrorState) {
            SnackBarUtils.showErrorSnackBar(
              context: context,
              message: state.message,
            );
          }
        },
        buildWhen: (previous, current) =>
            current is PickDoctorImageSuccessState,
        builder: (context, state) {
          if (state is PickDoctorImageSuccessState) {
            return Image.file(state.image, fit: .fitHeight);
          }
          return DottedBorder(
            options: CircularDottedBorderOptions(
              padding: EdgeInsets.all(40),
              stackFit: .loose,
              strokeCap: .round,
              dashPattern: const [10, 5],
              color: AppColors.borderMuted,
              strokeWidth: 2,
            ),

            child: Icon(
              Icons.image_outlined,
              size: 35,
              color: AppColors.textSecondary,
            ),
          );
        },
      ),
    );
  }
}
