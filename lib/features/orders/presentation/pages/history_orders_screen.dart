import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../manager/cubit.dart';
import '../manager/state.dart';
import '../widgets/order_item.dart';

class HistoryOrdersScreen extends StatefulWidget {
  const HistoryOrdersScreen({super.key});

  @override
  State<HistoryOrdersScreen> createState() => _HistoryOrdersScreenState();
}

class _HistoryOrdersScreenState extends State<HistoryOrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OrdersCubit>().getHistoryOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.ordersHistory)),
      body: RefreshIndicator(
        onRefresh: () async {
          return await context.read<OrdersCubit>().getHistoryOrders();
        },
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            return CustomScrollView(
              slivers: [
                // SliverPadding(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                //     sliver: SliverToBoxAdapter(
                //         child:
                //             _buildFilters(context.read<OrdersCubit>(), state))),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 24.h,
                  ),
                  sliver: SliverList.separated(
                    itemBuilder:
                        (BuildContext context, int index) =>
                            OrderItem(orderModel: state.historyOrders[index]),
                    separatorBuilder:
                        (BuildContext context, int index) => 15.verticalSpace,
                    itemCount: state.historyOrders.length,
                  ),
                ),
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
      DropdownButtonFormField<int>(
        hint: Text(AppStrings.status),
        items:
            state.statuses
                .map<DropdownMenuItem<int>>(
                  (e) =>
                      DropdownMenuItem<int>(value: e.key, child: Text(e.value)),
                )
                .toList(),
        onChanged: (status) {
          cubit.applyFilter(status: status);
        },
        initialValue: state.status,
      ),
    ],
  );
}
