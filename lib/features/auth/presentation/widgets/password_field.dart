import 'package:ala_darbak_captain/core/config/style/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final String? Function(String? value)? validator;
  const PasswordField({
    super.key,
    required this.controller,
    this.hintText,
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: widget.controller,
      obscureText: !isVisible,
      style: AppTextStyle.font16black500,
      validator: widget.validator ?? ValidationForm.passwordValidator,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: widget.hintText ?? AppStrings.password,
        prefixIcon: const Icon(Icons.lock, size: 25),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isVisible = !isVisible;
            });
          },
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            size: 25,
          ),
        ),
      ),
    );
  }
}
