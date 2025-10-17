import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class CarTypeField extends StatelessWidget {
  final TextEditingController controller;
  const CarTypeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.carTypeValidator,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppStrings.carType,
        prefixIcon: Icon(Icons.time_to_leave, size: 25),
      ),
    );
  }
}
