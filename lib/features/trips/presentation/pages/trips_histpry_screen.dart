import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/style/app_text_styles.dart';
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
            child: CustomScrollView(
              slivers: [
                if (state.trips.isEmpty)
                  SliverToBoxAdapter(
                    child: Center(child: Text(AppStrings.noTrips)),
                  )
                else ...{
                  // SliverPadding(
                  //     padding: EdgeInsets.symmetric(
                  //         horizontal: 20.w, vertical: 24.h),
                  //     sliver: SliverToBoxAdapter(
                  //         child: _buildFilters(
                  //             context.read<TripsCubit>(), state))),
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
                              TripItem(tripModel: state.trips[index]),
                      separatorBuilder:
                          (BuildContext context, int index) => 15.verticalSpace,
                      itemCount: state.trips.length,
                    ),
                  ),
                },
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilters(TripsCubit cubit, TripsState state) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: 10.h,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(AppStrings.sortBy, style: AppTextStyle.font14black600),
          ),
          IconButton(
            icon: const Icon(Icons.highlight_remove_outlined),
            onPressed: () {
              cubit.removeFilters();
            },
          ),
        ],
      ),
      // Row(
      //   spacing: 10.w,
      //   children: [
      //     Expanded(
      //       child: DropdownButtonFormField<String>(
      //         hint: const Text(AppStrings.startCity),
      //         items: state.startCities
      //             .map<DropdownMenuItem<String>>(
      //                 (e) => DropdownMenuItem<String>(
      //                       value: e,
      //                       child: Text(e),
      //                     ))
      //             .toList(),
      //         onChanged: (city) {
      //           cubit.applyFilter(startCity: city);
      //         },
      //         value: state.startCity,
      //       ),
      //     ),
      //     Expanded(
      //       child: DropdownButtonFormField<String>(
      //         hint: const Text(AppStrings.destenationCity),
      //         items: state.startCities
      //             .map<DropdownMenuItem<String>>(
      //                 (e) => DropdownMenuItem<String>(
      //                       value: e,
      //                       child: Text(e),
      //                     ))
      //             .toList(),
      //         onChanged: (city) {
      //           cubit.applyFilter(destenationCity: city);
      //         },
      //         value: state.destinationCity,
      //       ),
      //     ),
      //   ],
      // ),
    ],
  );
}
