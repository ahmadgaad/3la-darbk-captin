import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/style/app_text_styles.dart';
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
      body: RefreshIndicator(
        onRefresh: () async {
          return await cubit.getActiveTrips();
        },
        child: BlocBuilder<TripsCubit, TripsState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state.activeTrips.isEmpty)
                  const SliverToBoxAdapter(child: Center(child: Text(AppStrings.noTrips)))
                else ...{
                  // SliverPadding(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  //     sliver:
                  //         SliverToBoxAdapter(child: _buildFilters(context.read<TripsCubit>(), state))),

                  SliverPadding(
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 24.h, bottom: 80),
                    sliver: SliverList.separated(
                      itemBuilder: (BuildContext context, int index) =>
                          TripItem(
                        tripModel: state.activeTrips[index],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          15.verticalSpace,
                      itemCount: state.activeTrips.length,
                    ),
                  )
                }
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilters(TripsCubit cubit, TripsState state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.sortBy,
                    style: AppTextStyle.font14black600,
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.highlight_remove_outlined),
                    onPressed: () {
                      cubit.removeFilters();
                    })
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
          ]);
}
