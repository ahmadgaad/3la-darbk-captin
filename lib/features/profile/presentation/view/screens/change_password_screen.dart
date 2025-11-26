import 'package:ala_darbak_captain/core/utils/heplers/regex_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../../core/config/routes/app_routes.dart';
import '../../../../../core/db_injection.dart';
import '../../../../../core/utils/app_utils/app_strings.dart';
import '../../../../../core/widgets/app_toaster.dart';
import '../../../../auth/presentation/widgets/confirm_password_field.dart';
import '../../../../auth/presentation/widgets/password_field.dart';
import '../../view_model/change_password/cubit.dart';
import '../../view_model/change_password/state.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(sl()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.changePassword),
          centerTitle: true,
        ),
        body: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
          listener: (context, state) {
            if (state.isSuccess) {
              AppToaster.show(AppStrings.passwordChanged, isError: false);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoute.layout,
                (_) => false,
              );
            }
          },
          builder: (context, state) {
            final cubit = context.read<ChangePasswordCubit>();
            return LoadingOverlay(
              isLoading: state.loading,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                children: [
                  50.verticalSpace,
                  Form(
                    key: cubit.formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      spacing: 10.h,
                      children: [
                        PasswordField(
                          controller: cubit.oldPasswordController,
                          hintText: AppStrings.oldPassword,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return AppStrings.pleaseEnterPassword;
                            } else if (!RegexHelper.isPasswordValid(password)) {
                              return AppStrings.passwordNotValidDescription;
                            }
                            return null;
                          },
                        ),
                        PasswordField(controller: cubit.passwordController),
                        ConfirmPasswordField(
                          controller: cubit.confirmPasswordController,
                          password: cubit.passwordController,
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  ElevatedButton(
                    onPressed: cubit.changePassword,
                    child: Text(AppStrings.confirm),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
