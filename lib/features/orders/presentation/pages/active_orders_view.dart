import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
 import '../manager/cubit.dart';
import '../manager/state.dart';
import '../widgets/order_item.dart';

class ActiveOrdersView extends StatelessWidget {
  const ActiveOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(AppStrings.availiableOrders),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return await context.read<OrdersCubit>().getActiveOrders();
        },
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                if (state.activeOrders.isEmpty)
                  const SliverToBoxAdapter(child: Center(child: Text(AppStrings.noOrders)))
            else...{    // SliverPadding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                //     sliver: SliverToBoxAdapter(
                //         child:
                //             _buildFilters(context.read<OrdersCubit>(), state))),
               
                SliverPadding(
                  padding: EdgeInsets.only(
                      left: 20.w, right: 20.w, top: 24.h, bottom: 80),
                  sliver: SliverList.separated(
                    itemBuilder: (BuildContext context, int index) =>
                        OrderItem(orderModel: state.activeOrders[index],),
                    separatorBuilder: (BuildContext context, int index) =>
                        15.verticalSpace,
                    itemCount: state.activeOrders.length,
                  ),
                )}
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilters(OrdersCubit cubit, OrdersState state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    AppStrings.filterBy,
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
            DropdownButtonFormField<int>(
              hint: const Text(AppStrings.status),
              items: state.statuses
                  .map<DropdownMenuItem<int>>((e) => DropdownMenuItem<int>(
                        value: e.key,
                        child: Text(e.value),
                      ))
                  .toList(),
              onChanged: (status) {
                cubit.applyFilter(status: status);
              },
              value: state.status,
            ),
          ]);
}
