import 'package:ala_darbak_captain/core/config/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../core/config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../orders/presentation/widgets/order_item.dart';
import '../manager/trips/cubit.dart';
import '../manager/trips/state.dart';

class TripDetailsScreen extends StatefulWidget {
  final int tripId;
  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TripsCubit>().getTrip(widget.tripId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsCubit, TripsState>(
      builder: (context, state) {
        final cubit = context.read<TripsCubit>();
        final status = state.trip?.status ?? 0;
        return state.trip == null
            ? const Scaffold(body: Center(child: CircularProgressIndicator()))
            : LoadingOverlay(
              isLoading: state.loading,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: Text(
                    "${AppStrings.tripNumberOrders} #${state.trip?.numTrip ?? ""}",
                  ),
                  bottom:
                      status == 3
                          ? PreferredSize(
                            preferredSize: Size.fromHeight(50.w),
                            child: Container(
                              color: AppColors.primary,
                              padding: EdgeInsets.symmetric(vertical: 15.w),
                              alignment: Alignment.center,
                              child: Text(
                                AppStrings.canceled,
                                style: AppTextStyle.font18white600,
                              ),
                            ),
                          )
                          : null,
                ),
                body: RefreshIndicator(
                  onRefresh: () async {
                    return await cubit.getTrip(widget.tripId);
                  },
                  child:
                      state.orders.isEmpty
                          ? ListView(
                            padding: const EdgeInsets.all(20),
                            children: [
                              Center(child: Text(AppStrings.noOrders)),
                            ],
                          )
                          : ListView.separated(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              top: 24.h,
                              bottom: 80,
                            ),
                            itemBuilder:
                                (BuildContext context, int index) =>
                                    OrderItem(orderModel: state.orders[index]),
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    15.verticalSpace,
                            itemCount: state.orders.length,
                          ),
                ),
                bottomNavigationBar:
                    status == 3 || status == 2
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
                            spacing: 10.w,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondary,
                                ),
                                onPressed: () {
                                  if (status == 0) {
                                    cubit.updateTrip(1);
                                  } else if (status == 1) {
                                    cubit.updateTrip(2);
                                  }
                                },
                                child: Text(
                                  status == 0
                                      ? AppStrings.start
                                      : AppStrings.end,
                                ),
                              ),
                              if (status == 0)
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.updateTrip(3);
                                  },
                                  child: Text(AppStrings.cancel),
                                ),
                            ],
                          ),
                        ),
              ),
            );
      },
    );
  }
}
