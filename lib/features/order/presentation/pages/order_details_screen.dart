import 'package:ala_darbak_captain/core/temp/app_temp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/config/style/app_color.dart';
import '../../../../core/config/style/app_text_styles.dart';
import '../../../../core/db_injection.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/widgets/app_image_view.dart';
import '../manager/order_cubit/cubit.dart';
import '../manager/order_cubit/state.dart';
import '../widgets/order_images.dart';
import '../widgets/order_locations.dart';
import '../widgets/order_track.dart';

class OrderDetailsScreen extends StatelessWidget {
  final int? id;
  const OrderDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderCubit(sl())..getOrder(id ?? 0),
      child: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          final cubit = context.read<OrderCubit>();
          final status = state.orderModel?.status ?? 0;
          final isPaid = state.orderModel?.isPaid == 1;
          final isPerson = (state.orderModel?.category?.isPerson ?? false);

          return state.orderModel == null
              ? const Center(child: CircularProgressIndicator())
              : LoadingOverlay(
                isLoading: state.loading,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(
                      '${AppStrings.orderNumber} #${state.orderModel?.numOrder ?? '0'}',
                    ),
                    centerTitle: true,
                  ),
                  body: RefreshIndicator(
                    onRefresh: () async {
                      return await cubit.getOrder(id ?? 0);
                    },
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 20,
                      ),
                      cacheExtent: 20,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 1.1,
                          child: OrderTrack(status: status),
                        ),
                        10.verticalSpace,
                        const Divider(),
                        10.verticalSpace,
                        _textBuilder(AppStrings.clientData),
                        10.verticalSpace,
                        _clientDataBuilder(state),
                        10.verticalSpace,
                        const Divider(),
                        OrderLocations(
                          orderLocationModel:
                              state.orderModel?.orderLocationModel,
                        ),
                        const Divider(),
                        if (state.orderModel?.trip != null) ...{
                          10.verticalSpaceFromWidth,
                          _textBuilder(
                            AppStrings.tripNumber,
                            '#${state.orderModel?.trip?.numTrip ?? ""}',
                          ),
                          10.verticalSpaceFromWidth,
                          _textBuilder(
                            AppStrings.startCity,
                            state.orderModel?.trip?.cityFrom?.name ?? "",
                          ),
                          10.verticalSpaceFromWidth,
                          _textBuilder(
                            AppStrings.destenationCity,
                            state.orderModel?.trip?.cityTo?.name ?? "",
                          ),
                          10.verticalSpaceFromWidth,
                          const Divider(),
                        },
                        10.verticalSpace,
                        _textBuilder(
                          AppStrings.orderCategory,
                          state.orderModel?.category?.name ?? "",
                        ),
                        10.verticalSpace,
                        if (!isPerson) ...{
                          const Divider(),
                          _textBuilder(
                            AppStrings.orderSize,
                            sizes[state.orderModel?.size ?? 0],
                          ),
                          const Divider(),
                          _textBuilder(
                            AppStrings.unitsNumber,
                            '${state.orderModel?.quantity ?? 1}',
                          ),
                        },
                        const Divider(),
                        _textBuilder(
                          AppStrings.orderPrice,
                          '${state.orderModel?.price ?? 0} ${AppStrings.currency}',
                        ),
                        const Divider(),
                        10.verticalSpace,
                        Row(
                          spacing: 5.w,
                          children: [
                            _textBuilder(
                              AppStrings.payMethod,
                              state.orderModel?.paymentMethod == "0"
                                  ? AppStrings.cash
                                  : AppStrings.online,
                            ),
                            Text(
                              isPaid ? AppStrings.paid : AppStrings.notPaid,
                              style: AppTextStyle.font14black500,
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        if ((state.orderModel?.images ?? []).isNotEmpty) ...{
                          const Divider(),
                          10.verticalSpace,
                          OrderImages(images: state.orderModel?.images ?? []),
                          10.verticalSpace,
                        },
                        const Divider(),
                        10.verticalSpace,
                        _textBuilder(
                          AppStrings.addtionalDetails,
                          state.orderModel?.note ?? "",
                        ),
                        if (!isPerson) ...{
                          10.verticalSpace,
                          const Divider(),
                          10.verticalSpace,
                          _buildRecipientInfo(state),
                        },
                      ],
                    ),
                  ),
                  bottomNavigationBar:
                      status > 2
                          ? null
                          : Padding(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              top: 16.h,
                              bottom: 30.h,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              spacing: 15.h,
                              children: [
                                if (status == 2 &&
                                    !isPaid &&
                                    state.orderModel?.paymentMethod == "0")
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.success,
                                    ),
                                    onPressed: cubit.payOrder,
                                    child: Text(AppStrings.pay),
                                  ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary,
                                  ),
                                  onPressed: () {
                                    if (status == 0) {
                                      cubit.assignOrder();
                                    }
                                    if (status == 1) {
                                      cubit.updateOrder(2);
                                    }
                                    if (status == 2) {
                                      cubit.updateOrder(3);
                                    }
                                  },
                                  child: Text(
                                    status == 0
                                        ? AppStrings.approve
                                        : status == 1
                                        ? AppStrings.orderPicked
                                        : AppStrings.orderDelivered,
                                  ),
                                ),
                                if (status == 1 ||
                                    (status == 0 &&
                                        state.orderModel?.tripId != null))
                                  ElevatedButton(
                                    onPressed: () {
                                      cubit.updateOrder(4);
                                    },
                                    child: Text(AppStrings.disApproved),
                                  ),
                              ],
                            ),
                          ),
                ),
              );
        },
      ),
    );
  }

  Widget _textBuilder(String title, [String? value]) => RichText(
    text: TextSpan(
      text: "$title :",
      style: AppTextStyle.font14black600,
      children: [
        if (value != null)
          TextSpan(
            text: '  $value',
            style: AppTextStyle.font16primary600.copyWith(height: 1.5),
          ),
      ],
    ),
  );
  Widget _buildRecipientInfo(OrderState state) {
    return Column(
      spacing: 10.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${AppStrings.recipientInfo} ",
          style: AppTextStyle.font14black600,
        ),
        _textBuilder(AppStrings.name, state.orderModel?.recipientName),

        InkWell(
          onTap: () async {
            final url = "tel:+966${state.orderModel?.recipientMobile ?? ''}";
            if (await launchUrl(Uri.parse(url))) {}
          },
          child: RichText(
            text: TextSpan(
              text: "${AppStrings.phoneNumber} :",
              style: AppTextStyle.font14black600,

              children: [
                TextSpan(
                  text: '  +966${state.orderModel?.recipientMobile ?? ''}',
                  style: AppTextStyle.font16primary600.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _clientDataBuilder(OrderState state) => Row(
    spacing: 20.w,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AppImageView(
        width: 80.w,
        height: 80.w,
        shape: BoxShape.circle,
        fit: BoxFit.cover,
        url: state.orderModel?.client?.image ?? '',
      ),
      Flexible(
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.orderModel?.client?.name ?? '',
              style: AppTextStyle.font18black600,
            ),
            InkWell(
              onTap: () async {
                final url = "tel:+966${state.orderModel?.client?.mobile ?? ''}";
                if (await launchUrl(Uri.parse(url))) {
                  print('can\'t launch $url');
                }
              },
              child: Text(
                "+966${state.orderModel?.client?.mobile ?? ''}",
                textDirection: TextDirection.ltr,
                style: AppTextStyle.font16black600.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
