import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/routes/app_routes.dart';
import '../../../../core/config/style/app_color.dart';
import '../../../../core/config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../repositories/model/order_model.dart';

class OrderItem extends StatelessWidget {
  final OrderModel? orderModel;
  const OrderItem({super.key, this.orderModel});

  @override
  Widget build(BuildContext context) {
    int status = orderModel?.status ?? 0;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.desSelected, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(FontAwesomeIcons.locationDot),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 7.5.h),
                    width: 2,
                    height: 50.w,
                    color: AppColors.desSelected,
                  ),
                  const Icon(Icons.gps_not_fixed),
                ],
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pickupLocation,
                      style: AppTextStyle.font12desSelected600,
                    ),
                    7.5.verticalSpace,
                    Text(
                      orderModel?.pickupAddress ?? "",
                      style: AppTextStyle.font14black600.copyWith(height: 1.3),
                      maxLines: 1,
                    ),
                    30.verticalSpace,
                    Text(
                      AppStrings.deliveryLocation,
                      style: AppTextStyle.font12desSelected600,
                    ),
                    7.5.verticalSpace,
                    Text(
                      orderModel?.deliveryAddress ?? "",
                      style: AppTextStyle.font14black600.copyWith(height: 1.3),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Column(
                spacing: 10.h,
                children: [
                  Text(
                    '${AppStrings.orderNumber} #${orderModel?.numOrder ?? ""}',
                    style: AppTextStyle.font14black600,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoute.orderDetails,
                        arguments: orderModel?.id,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(40.h),
                    ),
                    child: Text(AppStrings.details),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color:
                status == 0
                    ? AppColors.pending
                    : status == 1
                    ? AppColors.accepted
                    : status == 2
                    ? AppColors.picked
                    : status == 3
                    ? AppColors.delivered
                    : AppColors.canceled,
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              bottomStart: Radius.circular(10),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
          child: Text(
            status == 0
                ? AppStrings.pending
                : status == 1
                ? AppStrings.accepted
                : status == 2
                ? AppStrings.picked
                : status == 3
                ? AppStrings.delivered
                : status == 4
                ? AppStrings.notApproved
                : AppStrings.canceled,
            style: AppTextStyle.font12white600,
          ),
        ),
      ],
    );
  }
}
