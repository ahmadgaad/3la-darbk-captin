import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../../core/utils/app_utils/app_strings.dart';
import '../../../../../core/widgets/app_image_view.dart';
import '../../../../auth/presentation/widgets/blate_alpha_field.dart';
import '../../../../auth/presentation/widgets/blate_number_field.dart';
import '../../../../auth/presentation/widgets/car_model_field.dart';
import '../../../../auth/presentation/widgets/car_type_field.dart';
import '../../../../auth/presentation/widgets/manufacture_year_field.dart';
import '../../view_model/profile_cubit/cubit.dart';
import '../../view_model/profile_cubit/state.dart';

class EditCarScreen extends StatelessWidget {
  const EditCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.myCar), centerTitle: true),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final cubit = context.read<ProfileCubit>();
          return LoadingOverlay(
            isLoading: state.loading,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      cubit.pickCarImage();
                    },
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        AppImageView(
                          shape: BoxShape.circle,
                          url: state.currentUser?.imageCar?.firstOrNull,
                          file: cubit.imageCar,
                          width: 80.w,
                          height: 80.h,
                          fit: BoxFit.cover,
                          foregroundDecoration: const BoxDecoration(
                            color: Colors.black26,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const Icon(Icons.camera_alt, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                25.verticalSpace,
                Form(
                  key: cubit.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    spacing: 10.h,
                    children: [
                      CarTypeField(controller: cubit.carTypeController),
                      ManufactureYearField(
                        controller: cubit.manufactureYearController,
                      ),
                      CarModeField(controller: cubit.carModelController),
                      Row(
                        spacing: 15.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: BlateNumberField(
                              controller: cubit.blateNumberController,
                            ),
                          ),
                          Flexible(
                            child: BlateAlphaField(
                              controller: cubit.blateAlphaController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                ElevatedButton(
                  onPressed: () {
                    cubit.updateData();
                  },
                  child: Text(AppStrings.confirm),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
