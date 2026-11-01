part of '../screens/add_doctor_screen.dart';

class AddSpecialtyButton extends StatelessWidget {
  const AddSpecialtyButton({super.key});

  @override
  Widget build(BuildContext context) {


    return IconButton(
      onPressed: () {

        showRawDialog(context: context, builder: (context) =>const  AddSpecialtyDialog(),);
        // _buildSuccessDialog(
        //   arabicController: arabicController,
        //   context: context,
        //   englishController: englishController,
        //   formKey: formKey,
        // );
      },
      icon: Icon(Icons.add),
      visualDensity: .compact,

      iconSize: 30,
      style: IconButton.styleFrom(
        foregroundColor: AppColors.brandPrimary,
        tapTargetSize: .shrinkWrap,
        padding: EdgeInsets.zero,
      ),
    );
  }

  // Future<dynamic> _buildSuccessDialog({
  //   required BuildContext context,
  //   required GlobalKey<FormState> formKey,
  //   required TextEditingController englishController,
  //   required TextEditingController arabicController,
  // }) {
  //   return showDialog(
  //     fullscreenDialog: false,
  //
  //     context: context,
  //     builder: (context) => Container(
  //       padding: EdgeInsets.all(25),
  //       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 200),
  //       // width: double.infinity,
  //       // height: double.infinity,
  //       decoration: BoxDecoration(
  //         color: AppColors.bgPrimary,
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: BlocConsumer<SpecialtiesBloc, SpecialtiesState>(
  //         buildWhen: (previous, current) => current.failureMessage == null,
  //         builder: (context, state) {
  //           if (state.isLoading) {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //           return Material(
  //             child: Form(
  //               key: formKey,
  //               child: ListView(
  //                 children: [
  //                   _buildText(
  //                     context: context,
  //                     text: t.admin.addDoctorScreen.englishName,
  //                   ),
  //                   CustomTextFormField(
  //                     controller: englishController,
  //                     validator: (value) => Validators.required(value) ,
  //                     hintText: t.admin.addDoctorScreen.englishName,
  //                   ),
  //                   _buildText(
  //                     context: context,
  //                     text: t.admin.addDoctorScreen.arabicName,
  //                   ),
  //                   CustomTextFormField(
  //                     controller: arabicController,
  //                     validator: (value) => Validators.required(value),
  //                     hintText: t.admin.addDoctorScreen.arabicName,
  //                   ),
  //                   SizedBox(height: 30),
  //                   _buildCreateDoctorButton(
  //                     context: context,
  //                     formKey: formKey,
  //                     englishController: englishController,
  //                     arabicController: arabicController,
  //                   ),
  //                   // Container(
  //                   //   padding: EdgeInsets.all(40),
  //                   //   width: 150,
  //                   //   height: 150,
  //                   //   decoration: BoxDecoration(
  //                   //     shape: .circle,
  //                   //     color: AppColors.brandPrimary20,
  //                   //   ),
  //                   //   child: SvgPicture.asset(
  //                   //     AppAssets.icons.likeIcon.path,
  //                   //     width: double.infinity,
  //                   //   ),
  //                   // ),
  //                   // Text(
  //                   //   t.appointment.thankYou,
  //                   //   style: context.medium38.black.rubik,
  //                   //   textAlign: .center,
  //                   // ),
  //                   // FittedBox(
  //                   //   fit: .scaleDown,
  //                   //   child: Text(
  //                   //     t.appointment.success,
  //                   //     style: context.regular20.textSecondary.rubik,
  //                   //     textAlign: .center,
  //                   //   ),
  //                   // ),
  //                   // SizedBox(height: 30),
  //                   // Text(
  //                   //   "ihdi",
  //                   //   style: context.regular14.textSecondary.rubik,
  //                   //   textAlign: .center,
  //                   // ),
  //                   // SizedBox(height: 30),
  //                   // CustomElevatedButton(
  //                   //   buttonWidth: double.infinity,
  //                   //   borderRadius: 6,
  //                   //   backgroundColor: AppColors.brandPrimary,
  //                   //   onPressed: () {
  //                   //     const PatientMainRoute().go(context);
  //                   //   },
  //                   //   child: Text(
  //                   //     t.appointment.done,
  //                   //     style: context.medium18.white.rubik,
  //                   //   ),
  //                   // ),
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //         listener: (context, state) {
  //           if (state.actionSuccessMessage != null) {
  //             context.pop(context);
  //           }
  //           if (state.failureMessage != null) {
  //             SnackBarUtils.showErrorSnackBar(
  //               context: context,
  //               message: state.failureMessage?? "",
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }


}
