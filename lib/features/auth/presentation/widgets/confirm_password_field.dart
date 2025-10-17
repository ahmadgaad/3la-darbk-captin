import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController password;
  const ConfirmPasswordField({super.key, required this.controller,required this.password});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
            controller: controller,
           
            validator: (v)=>ValidationForm.confirmPasswordValidator(v,password.text),
        obscureText: true,
             keyboardType: TextInputType.visiblePassword,
             decoration: InputDecoration(
                hintText: AppStrings.confirmPassword,
                     prefixIcon: Icon(Icons.lock, size: 25),
             ),
            );
  }
}
