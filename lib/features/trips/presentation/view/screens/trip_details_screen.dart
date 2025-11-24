import 'package:ala_darbak_captain/core/config/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/style/app_text_styles.dart';
import '../../../../../core/utils/app_utils/app_strings.dart';
import '../../../../orders/presentation/widgets/order_item.dart';
import '../../view_model/trips/cubit.dart';
import '../../view_model/trips/state.dart';

class TripDetailsScreen extends StatefulWidget {
  final int tripId;
  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int? _previousTripId;
  bool _ordersLoaded = false;
  DateTime? _tripLoadedTime;

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
        final isLoadingTrip = state.trip == null && !state.error;

        // Track if orders are loading (trip just loaded but orders not yet fetched)
        final currentTripId = state.trip?.id;
        if (currentTripId != null && currentTripId != _previousTripId) {
          _previousTripId = currentTripId;
          _ordersLoaded = false;
          _tripLoadedTime = DateTime.now();
        }
        if (state.orders.isNotEmpty) {
          _ordersLoaded = true;
        }
        // If trip loaded more than 2 seconds ago and orders are still empty, assume they're actually empty
        if (_tripLoadedTime != null &&
            DateTime.now().difference(_tripLoadedTime!).inSeconds > 2 &&
            state.orders.isEmpty) {
          _ordersLoaded = true;
        }
        final isLoadingOrders =
            state.trip != null &&
            !_ordersLoaded &&
            state.orders.isEmpty &&
            !state.error;

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              state.trip != null
                  ? "${AppStrings.tripNumberOrders} #${state.trip?.numTrip ?? ""}"
                  : AppStrings.tripNumberOrders,
            ),
            bottom:
                state.trip != null && status == 3
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
          body: _buildBody(state, cubit, isLoadingTrip, isLoadingOrders),
          bottomNavigationBar:
              state.trip != null && (status != 3 && status != 2)
                  ? Padding(
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
                            status == 0 ? AppStrings.start : AppStrings.end,
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
                  )
                  : null,
        );
      },
    );
  }

  Widget _buildBody(
    TripsState state,
    TripsCubit cubit,
    bool isLoadingTrip,
    bool isLoadingOrders,
  ) {
    // Handle error state
    if (state.error && state.trip == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64.w, color: AppColors.primary),
              20.verticalSpace,
              Text(
                AppStrings.somethingWentWrong,
                style: AppTextStyle.font18black600,
                textAlign: TextAlign.center,
              ),
              10.verticalSpace,
              Text(
                AppStrings.tryAgainLater,
                style: AppTextStyle.font14black500,
                textAlign: TextAlign.center,
              ),
              30.verticalSpace,
              ElevatedButton(
                onPressed: () {
                  cubit.getTrip(widget.tripId);
                },
                child: Text(AppStrings.retry),
              ),
            ],
          ),
        ),
      );
    }

    // Handle loading state (initial trip load)
    if (isLoadingTrip) {
      return const Center(child: CircularProgressIndicator());
    }

    // Handle success state with trip data
    return RefreshIndicator(
      onRefresh: () async {
        _ordersLoaded = false;
        _tripLoadedTime = null;
        return await cubit.getTrip(widget.tripId);
      },
      child: _buildOrdersList(state, isLoadingOrders),
    );
  }

  Widget _buildOrdersList(TripsState state, bool isLoadingOrders) {
    // Show loading while orders are being fetched
    if (isLoadingOrders) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            20.verticalSpace,
            Text(AppStrings.loadingOrders, style: AppTextStyle.font14black500),
          ],
        ),
      );
    }

    // Show orders list or empty message
    if (state.orders.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Center(child: Text(AppStrings.noOrders)),
          ),
        ],
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 24.h, bottom: 80),
      itemBuilder:
          (context, index) => OrderItem(orderModel: state.orders[index]),
      separatorBuilder: (context, index) => 15.verticalSpace,
      itemCount: state.orders.length,
    );
  }
}
