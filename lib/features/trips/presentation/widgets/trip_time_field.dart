import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class TripTimeField extends StatelessWidget {
  final TextEditingController controller;
  const TripTimeField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.timeValidator,
      keyboardType: TextInputType.datetime,
      decoration: const InputDecoration(
        hintText: AppStrings.time,
        prefixIcon: Icon(Icons.timer_outlined, size: 25),
      ),
      readOnly: true,
      onTap: () async {
     TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          controller.text = pickedTime.format(context);
        }
      },
    );
  }
}
