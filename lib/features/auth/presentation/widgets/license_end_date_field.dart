import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class LicenseEndDateField extends StatelessWidget {
  final TextEditingController controller;
  const LicenseEndDateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.dateValidator,
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        hintText: AppStrings.licenseEndDate,
        prefixIcon: Icon(Icons.date_range, size: 25),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now().add(const Duration(days: 365*100)),
        );
        if (pickedDate != null) {
          controller.text = "${pickedDate.toLocal()}".split(' ')[0];
        }
      },
    );
  }
}
