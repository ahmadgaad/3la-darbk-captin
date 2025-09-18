import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/heplers/validation_form.dart';

class OrderPriceField extends StatelessWidget {
  final TextEditingController controller;
  const OrderPriceField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: ValidationForm.orderPriceValidator,
     inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _CustomMinValueFormatter(minValue: 0), // Enforce minimum value
      ],
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: AppStrings.orderPrice,
        prefixIcon: Icon(Icons.price_change, size: 25),
      ),
    );
  }
}

class _CustomMinValueFormatter extends TextInputFormatter {
  final int minValue;

  _CustomMinValueFormatter({required this.minValue});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return TextEditingValue(text: minValue.toString());
    }
    final int? newNumber = int.tryParse(newValue.text);
    if (newNumber == null || newNumber < minValue) {
      return oldValue; // Revert to the old value if invalid
    }
    return newValue; // Accept the new value if valid
  }
}
