import 'package:flutter/material.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class BlateNumberField extends StatelessWidget {
  final TextEditingController controller;
  const BlateNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.blateNumberValidator,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        hintText: AppStrings.blateNumber,
        // prefixIcon: Icon(FontAwesomeIcons.idCard, size: 25),
      ),
    );
  }
}
