import 'package:ala_darbak_captain/core/utils/payment/myfatoraah.dart';
import 'package:flutter/material.dart';

class Payment {
  static Future pay(context, amount) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return  PaymentPage(paymentAmount: amount,);
      },
    );
  }
}
