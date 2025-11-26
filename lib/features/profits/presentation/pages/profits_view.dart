import 'package:ala_darbak_captain/core/config/style/app_color.dart';
import 'package:ala_darbak_captain/core/widgets/app_toaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/style/app_theme.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/utils/payment/payment_dialog.dart';
import '../../manager/cubit.dart';
import 'profit_details_view.dart';

class ProfitsView extends StatelessWidget {
  const ProfitsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CommissionCubit>();
    final commission = cubit.state.commission;
    return Theme(
      data: profitTheme,
      child: DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings.myProfit),
          ),
          body: const ProfitDetailsView(),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing: 15.w,
              children: [
                if ((double.tryParse((commission?.currentCommission ?? "0")) ??
                        0) !=
                    0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Payment.pay(
                          context,
                          num.tryParse(commission?.currentCommission ?? "0"),
                        ).then((value) {
                          if (value is bool) {
                            if (value) {
                              print("Payment Success");
                              cubit.payCommission(
                                commission?.currentCommission ?? "0",
                              );
                              AppToaster.show(
                                "Payment Success",
                                isError: false,
                              );
                            } else {
                              print("Payment Failed");
                              AppToaster.show("Payment Failed");
                            }
                          }
                        });
                      },
                      child: Text(AppStrings.payAppProfit),
                    ),
                  ),
                if ((double.tryParse(
                          (commission?.avaliablewithdrawprofit ?? "0"),
                        ) ??
                        0) !=
                    0)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                      ),
                      onPressed: () {
                        cubit.withDrawProfits(
                          (commission?.avaliablewithdrawprofit ?? "0"),
                        );
                      },
                      child: Text(AppStrings.withDrawProfits),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
