import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  const NameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      controller: controller,
      validator: ValidationForm.nameValidator,
      keyboardType: TextInputType.name,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: AppStrings.name,
        prefixIcon: const Icon(Icons.person, size: 25),
      ),
    );
  }
}
