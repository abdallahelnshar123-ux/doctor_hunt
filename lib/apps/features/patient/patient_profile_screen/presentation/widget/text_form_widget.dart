part of '../screens/patient_profile_screen.dart';

class TextFormWidget extends StatefulWidget {
  const TextFormWidget({
    super.key,
    required this.label,
    required this.controller,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
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
        subtitle: CustomTextFormField(
          readOnly: _readOnly,
          focusNode: _focusNode,
          borderSideColor: AppColors.transparent,
          controller: widget.controller,
          validator: widget.validator,
          contentPadding: EdgeInsets.zero,
          style: context.light16.textSecondary.rubik,
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
