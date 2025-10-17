import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class BankNumberField extends StatelessWidget {
  final TextEditingController controller;
  const BankNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.bankNumberValidator,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppStrings.bankNumber,
        prefixIcon: Icon(Icons.credit_card, size: 25),
      ),
    );
  }
}
