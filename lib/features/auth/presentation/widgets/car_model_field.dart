import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class CarModeField extends StatelessWidget {
  final TextEditingController controller;
  const CarModeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.carModelValidator,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppStrings.carModel,
        prefixIcon: Icon(Icons.time_to_leave, size: 25),
      ),
    );
  }
}
