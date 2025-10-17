import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../manager/trips/cubit.dart';
import '../manager/trips/state.dart';
import '../widgets/trip_item.dart';

class ActiveTripsView extends StatelessWidget {
  const ActiveTripsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TripsCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.activeTrips),
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          return await cubit.getActiveTrips();
        },
        child: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, state) {
            // Handle loading state
            if (state.activeTripsLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator.adaptive(),
                    16.verticalSpace,
                    const Text(AppStrings.loadingTrips),
                  ],
                ),
              );
            }

            // Handle error state
            if (state.activeTripsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      AppStrings.errorLoadingTrips,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => cubit.getActiveTrips(),
                      child: const Text(AppStrings.retry),
                    ),
                  ],
                ),
              );
            }

            // Handle empty state
            if (state.activeTrips.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.directions_car_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppStrings.noTrips,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Handle success state with data
            return CustomScrollView(
              slivers: [
                // SliverPadding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                //     sliver:
                //         SliverToBoxAdapter(child: _buildFilters(context.read<TripsCubit>(), state))),
                SliverPadding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 24.h,
                    bottom: 80,
                  ),
                  sliver: SliverList.separated(
                    itemBuilder:
                        (BuildContext context, int index) =>
                            TripItem(tripModel: state.activeTrips[index]),
                    separatorBuilder:
                        (BuildContext context, int index) => 15.verticalSpace,
                    itemCount: state.activeTrips.length,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
