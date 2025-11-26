import 'package:ala_darbak_captain/core/config/style/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController password;
  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: AppTextStyle.font16black500,
      validator:
          (v) => ValidationForm.confirmPasswordValidator(v, password.text),
      obscureText: true,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: AppStrings.confirmPassword,
        prefixIcon: const Icon(Icons.lock, size: 25),
      ),
    );
  }
}
