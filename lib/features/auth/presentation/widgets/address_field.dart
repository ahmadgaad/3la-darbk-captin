import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class AddressField extends StatelessWidget {
  final TextEditingController controller;
  const AddressField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.addressValidator,
      keyboardType: TextInputType.streetAddress,
      decoration: InputDecoration(
        hintText: AppStrings.address,
        prefixIcon: Icon(Icons.home, size: 25),
      ),
    );
  }
}
