import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class BankNameField extends StatelessWidget {
  final TextEditingController controller;
  const BankNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.bankNameValidator,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        hintText: AppStrings.bankName,
        prefixIcon: Icon(Icons.account_balance, size: 25),
      ),
    );
  }
}
