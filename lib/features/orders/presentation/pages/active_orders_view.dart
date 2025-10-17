import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            // Handle loading state
            if (state.activeOrdersLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator.adaptive(),
                    16.verticalSpace,
                    const Text(AppStrings.loadingOrders),
                  ],
                ),
              );
            }

            // Handle error state
            if (state.activeOrdersError) {
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
                      AppStrings.errorLoadingOrders,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed:
                          () => context.read<OrdersCubit>().getActiveOrders(),
                      child: const Text(AppStrings.retry),
                    ),
                  ],
                ),
              );
            }

            // Handle empty state
            if (state.activeOrders.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_shipping_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppStrings.noOrders,
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
                //     sliver: SliverToBoxAdapter(
                //         child:
                //             _buildFilters(context.read<OrdersCubit>(), state))),
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
                            OrderItem(orderModel: state.activeOrders[index]),
                    separatorBuilder:
                        (BuildContext context, int index) => 15.verticalSpace,
                    itemCount: state.activeOrders.length,
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
