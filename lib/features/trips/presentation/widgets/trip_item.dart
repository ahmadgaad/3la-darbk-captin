import 'package:ala_darbak_captain/features/trips/presentation/manager/trips/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/style/app_color.dart';
import '../../../../config/style/app_text_styles.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../../repositories/model/trip_model.dart';

class TripItem extends StatelessWidget {
  final TripModel? tripModel;
  const TripItem({super.key, this.tripModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.desSelected, width: 1),
          borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(FontAwesomeIcons.locationDot),
              Container(
                margin: EdgeInsets.symmetric(vertical: 7.5.h),
                width: 2,
                height: 40.h,
                color: AppColors.desSelected,
              ),
              const Icon(Icons.gps_not_fixed)
            ],
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.startCity,
                  style: AppTextStyle.font12desSelected600,
                ),
                7.5.verticalSpace,
                Text(
                  tripModel?.cityFrom?.name ?? "",
                  style: AppTextStyle.font14black600,
                  maxLines: 2,
                ),
                30.verticalSpace,
                Text(
                  AppStrings.destenationCity,
                  style: AppTextStyle.font12desSelected600,
                ),
                7.5.verticalSpace,
                Text(
                  tripModel?.cityTo?.name ?? "",
                  style: AppTextStyle.font14black600,
                  maxLines: 2,
                ),
              ],
            ),
          ),
          Column(
            spacing: 15.h,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${AppStrings.tripNumber} #${tripModel?.numTrip ?? ""}',
                style: AppTextStyle.font14black600,
              ),
              Text(
                '${tripModel?.date} ${tripModel?.time}',
                style: AppTextStyle.font14black600,
              ),
              ElevatedButton(
                onPressed: () {
                  final cubit = context.read<TripsCubit>();
                  cubit.setTrip(tripModel);
                  Navigator.pushNamed(context, AppRoute.tripDetails,
                      arguments: [cubit, tripModel?.id]);
                },
                style:
                    ElevatedButton.styleFrom(fixedSize: Size.fromHeight(40.h)),
                child: const Text(AppStrings.details),
              ),
            ],
          )
        ],
      ),
    );
  }
}
