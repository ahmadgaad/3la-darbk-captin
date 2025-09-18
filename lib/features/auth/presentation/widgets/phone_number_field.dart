import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/style/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  const PhoneNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
            controller: controller,
            validator: ValidationForm.phoneValidator,
            keyboardType: TextInputType.phone,
            inputFormatters: [LengthLimitingTextInputFormatter(11)],
            decoration: InputDecoration(
              suffixIcon: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Align(
                widthFactor: 1,
                child: Text(
                  "966+",
                  style: AppTextStyle.font16black500,
                ),
              ),
            ),
              hintText: AppStrings.phoneNumber,
              prefixIcon: const Icon(Icons.phone, size: 25),
            ),
          );
  }
}
