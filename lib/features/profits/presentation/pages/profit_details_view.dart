import 'package:ala_darbak_captain/features/profits/manager/cubit.dart';
import 'package:ala_darbak_captain/features/profits/manager/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/style/app_color.dart';
import '../../../../config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../setttings_info/presentation/manager/cubit.dart';

class ProfitDetailsView extends StatelessWidget {
  const ProfitDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CommissionCubit>();
    final settingCubit = context.watch<SettingsInfoCubit>();
    final commission = cubit.state.commission;
    final percentCommission =
        settingCubit.state.settingsInfo?.percentCommission;

    return RefreshIndicator(
      onRefresh: () async {
        await cubit.getCommission();
        return;
      },
      child: BlocBuilder<CommissionCubit, CommissionState>(
        builder: (context, state) {
          // Handle loading state
          if (state.loading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator.adaptive(),
                  16.verticalSpace,
                  const Text(AppStrings.loadingProfits),
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
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.errorLoadingProfits,
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => cubit.getCommission(),
                    child: const Text(AppStrings.retry),
                  ),
                ],
              ),
            );
          }

          // Handle success state with data
          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              _buildStatCard(
                AppStrings.totalOrders,
                commission?.totalOrders ?? "0",
                showCurrency: false,
              ),
              _buildStatCard(
                AppStrings.totalCashOrders,
                commission?.totalWithCash ?? "0",
              ),
              _buildStatCard(
                AppStrings.totalCreditOrders,
                commission?.totalWithOnline ?? "0",
              ),
              _buildStatCard(
                AppStrings.appCommission,
                commission?.totalCommission ?? "0",
              ),
              _buildStatCard(
                AppStrings.totalEarnings,
                commission?.totalprofit ?? "0",
              ),
              _buildStatCard(
                AppStrings.currentCommission,
                commission?.currentCommission ?? "0",
              ),
              _buildStatCard(
                AppStrings.currentDues,
                commission?.avaliablewithdrawprofit ?? "0",
              ),
              _buildStatCard(
                AppStrings.percentCommission,
                "$percentCommission%",
                showCurrency: false,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value, {
    bool showCurrency = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: AppColors.desSelected),
      ),
      padding: EdgeInsets.all(8.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: AppTextStyle.font18secondary600,
                  textAlign: TextAlign.end,
                ),
              ),
              if (showCurrency)
                Text(
                  '  ${AppStrings.currency}',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),

          Text(
            label,
            style: AppTextStyle.font14black500.copyWith(height: 1.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
