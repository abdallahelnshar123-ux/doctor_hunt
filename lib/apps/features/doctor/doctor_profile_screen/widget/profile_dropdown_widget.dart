import 'package:doctor_hunt/apps/features/admin/add_doctor_screen/presentation/widget/specialty_dropdown_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../generated/style_atoms.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_container_with_shadow.dart';
import '../../../common/specialties/data/models/specialty_model.dart';

class ProfileDropdownWidget extends StatefulWidget {
  const ProfileDropdownWidget({
    super.key,
    required this.label,
    this.validator,
    this.hintText,
    required this.initialSpeciality,
    required this.selectedSpeciality,
  });

  final String label;
  final String? Function(String?)? validator;
  final String? hintText;
  final ValueNotifier<SpecialtyModel> selectedSpeciality;
  final String? initialSpeciality;

  @override
  State<ProfileDropdownWidget> createState() => _ProfileDropdownWidgetState();
}

class _ProfileDropdownWidgetState extends State<ProfileDropdownWidget> {
  bool _readOnly = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainerWithShadow(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.white,
      ),
      child: ListTile(
        title: Text(widget.label),
        titleTextStyle: context.medium10.brandPrimary.rubik,
        subtitle: SpecialtyDropdownWidget(
          readOnly: _readOnly,
          isProfile: true,
          selectedSpecialty: (value) => widget.selectedSpeciality.value = value,
          initialSelection: widget.initialSpeciality,
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              _readOnly = !_readOnly;
              if (!_readOnly) {
                _focusNode.requestFocus();
              } else {
                _focusNode.unfocus();
              }
            });
          },
          icon: Icon(
            _readOnly ? Icons.edit : Icons.check,
            color: AppColors.textSecondary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }
}
