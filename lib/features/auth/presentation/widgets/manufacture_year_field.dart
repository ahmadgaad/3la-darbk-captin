import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class ManufactureYearField extends StatelessWidget {
  final TextEditingController controller;
  const ManufactureYearField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.manufactureYearValidator,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        hintText: AppStrings.manufactureYear,
        prefixIcon: Icon(Icons.calendar_today, size: 25),
      ),
    );
  }
}
