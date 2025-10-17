import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class BlateAlphaField extends StatelessWidget {
  final TextEditingController controller;
  const BlateAlphaField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.blateAlphaValidator,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppStrings.blateAlpha,
        // prefixIcon: Icon(Icons.account_balance, size: 25),
      ),
    );
  }
}
