import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class TripDateField extends StatelessWidget {
  final TextEditingController controller;
  const TripDateField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.dateValidator,
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        hintText: AppStrings.date,
        prefixIcon: Icon(Icons.date_range, size: 25),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate:DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (pickedDate != null) {
          controller.text = "${pickedDate.toLocal()}".split(' ')[0];
        }
      },
    );
  }
}
