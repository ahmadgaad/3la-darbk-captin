import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/config/style/app_text_styles.dart';
import '../../../../../core/widgets/app_image_view.dart';
import '../../view_model/profile_cubit/cubit.dart';
import '../../view_model/profile_cubit/state.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final user = state.currentUser;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            spacing: 15.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImageView(
                url:
                  user?.image ?? "no-image",
                shape: BoxShape.circle,
                width: 80.w,
                height: 80.w,
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
                  children: [
                    Text(
                      user?.name??"",
                      style: AppTextStyle.font16black600,
                    ),
                    Text(
                      "0.0",
                      style: AppTextStyle.font16primary600,
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      itemSize: 27,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    Text(
                      "تقييم 0 من المستخدمين",
                      style: AppTextStyle.font14desSelected500,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
