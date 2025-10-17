import 'package:ala_darbak_captain/core/utils/heplers/saudi_number_formater.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  const PhoneNumberField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(9),
        SaudiNumberFormatter(),
      ],
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Align(
            widthFactor: 1,
            child: Text("966+", style: AppTextStyle.font16black500),
          ),
        ),
        hintText: AppStrings.phoneNumber,
        prefixIcon: const Icon(Icons.phone, size: 25),
      ),
    );
  }
}
