import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../manager/trips/cubit.dart';
import '../manager/trips/state.dart';
import '../widgets/trip_item.dart';

class TripsHistoryScreen extends StatelessWidget {
  const TripsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripsCubit, TripsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(AppStrings.tripHistory),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return await context.read<TripsCubit>().getTrips();
            },
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, TripsState state) {
    // Handle loading state
    if (state.loading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator.adaptive(),
            16.verticalSpace,
            Text(AppStrings.loadingTrips),
          ],
        ),
      );
    }

    // Handle error state
    if (state.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
            16.verticalSpace,
            Text(
              AppStrings.errorLoadingTrips,
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
            24.verticalSpace,
            ElevatedButton(
              onPressed: () {
                context.read<TripsCubit>().getTrips();
              },
              child: Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    // Handle empty state
    if (state.trips.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64.sp, color: Colors.grey),
            16.verticalSpace,
            Text(
              AppStrings.noTrips,
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    // Handle success state with data
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 24.h,
            bottom: 80,
          ),
          sliver: SliverList.separated(
            itemBuilder: (context, index) {
              return TripItem(tripModel: state.trips[index]);
            },
            separatorBuilder: (context, index) => 15.verticalSpace,
            itemCount: state.trips.length,
          ),
        ),
      ],
    );
  }
}
