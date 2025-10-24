import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_utils/app_strings.dart';
import '../../view_model/profile_cubit/cubit.dart';
import '../../view_model/profile_cubit/state.dart';

class Avaliability extends StatelessWidget {
  const Avaliability({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return ListTile(
          title: Text(AppStrings.areYouReady),
          trailing: SizedBox(
            height: 30.h,
            child: FittedBox(
              child: Switch(
                value: state.currentUser?.workValid == 1,
                onChanged: (value) {
                  context.read<ProfileCubit>().changeAvailablilty();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
