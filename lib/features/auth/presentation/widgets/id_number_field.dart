import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class IdNumberField extends StatelessWidget {
  final TextEditingController controller;
  const IdNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.idNumberValidator,
      inputFormatters: [LengthLimitingTextInputFormatter(10),],
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: AppStrings.idNumber,
        prefixIcon: Icon(FontAwesomeIcons.idCard, size: 25),
      ),
    );
  }
}
