import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../config/style/app_color.dart';
import '../../../../config/style/app_text_styles.dart';
import '../../../../core/widgets/app_image_view.dart';
import '../../../../core/widgets/app_toaster.dart';
import '../manager/register_cubit/cubit.dart';
import '../manager/register_cubit/state.dart';
import '../widgets/address_field.dart';
import '../widgets/bank_name_field.dart';
import '../widgets/bank_number_field.dart';
import '../widgets/birthday_field.dart';
import '../widgets/blate_alpha_field.dart';
import '../widgets/blate_number_field.dart';
import '../widgets/car_model_field.dart';
import '../widgets/car_type_field.dart';
import '../widgets/confirm_password_field.dart';
import '../widgets/id_number_field.dart';
import '../widgets/license_end_date_field.dart';
import '../widgets/manufacture_year_field.dart';
import '../widgets/name_field.dart';
import '../widgets/password_field.dart';
import '../widgets/phone_number_field.dart';
import '../../../../core/utils/app_utils/app_strings.dart';
import '../widgets/register_steps.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (BuildContext context, RegisterState state) {
        if (state.success) {
          AppToaster.show(AppStrings.registerSuccess, isError: false);
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoute.layout, (_) => false);
        }
      },
      builder: (context, state) {
        final registerCubit = context.read<RegisterCubit>();
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          children: [
            10.verticalSpace,
            RegisterSteps(step: state.step),
            15.verticalSpace,
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: [
                  _step1(registerCubit),
                  _step2(registerCubit),
                  _step3(registerCubit)
                ][state.step],
              ),
            ),
            if (state.step == 2)
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoute.termsAndConditions),
                  child: Text(
                    AppStrings.acceptPrivacyPolicy,
                    style: AppTextStyle.font16black500
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                ),
                value: registerCubit.isPrivacyPolicyAccepted,
                onChanged: registerCubit.checkPrivacyPolicy,
                controlAffinity: ListTileControlAffinity.leading,
              ),
            30.verticalSpace,
            Row(
              spacing: 15.w,
              children: [
                if (state.step > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        iconColor: AppColors.black,
                        iconSize: 25,
                        backgroundColor: AppColors.desSelected),
                    onPressed: () {
                      registerCubit.previousStep(state.step - 1);
                    },
                    child: const Icon(
                      Icons.arrow_back_outlined,
                    ),
                  ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.step == 2) {
                        registerCubit.register();
                      }else if(state.step==0){
                        registerCubit.checkUser();
                      } else {
                        registerCubit.nextStep(state.step + 1);
                      }
                    },
                    child: Text(
                        state.step < 2 ? AppStrings.next : AppStrings.signUp),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _step1(RegisterCubit registerCubit) => Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: registerCubit.formKey,
        child: Column(
          spacing: 25.h,
          children: [
            NameField(controller: registerCubit.nameController),
            PhoneNumberField(controller: registerCubit.phoneController),
            PasswordField(controller: registerCubit.passwordController),
            ConfirmPasswordField(
                controller: registerCubit.confirmPasswordController,
                password: registerCubit.passwordController),
          ],
        ),
      );
  Widget _step2(RegisterCubit registerCubit) => Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: registerCubit.formKey2,
        child: Column(
          spacing: 25.h,
          children: [
            IconButton(
              onPressed: () {
                registerCubit.pickImage();
              },
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  AppImageView(
                    shape: BoxShape.circle,
                    file: registerCubit.image,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                    foregroundDecoration: const BoxDecoration(
                        color: Colors.black26, shape: BoxShape.circle),
                  ),
                  const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            BirthdayField(controller: registerCubit.birthdayController),
            IdNumberField(controller: registerCubit.idNumberController),
            AddressField(controller: registerCubit.addressController),
            LicenseEndDateField(
                controller: registerCubit.licenseEndDateController),
            BankNameField(controller: registerCubit.bankNameController),
            BankNumberField(controller: registerCubit.bankNumberController),
          ],
        ),
      );
  Widget _step3(RegisterCubit registerCubit) => Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: registerCubit.formKey3,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 25.h,
          children: [
          
            CarTypeField(controller: registerCubit.carTypeController),
            ManufactureYearField(
                controller: registerCubit.manufactureYearController),
            CarModeField(controller: registerCubit.carModelController),
            Row(
              spacing: 15.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: BlateNumberField(
                        controller: registerCubit.blateNumberController)),
                Flexible(
                    child: BlateAlphaField(
                        controller: registerCubit.blateAlphaController)),
              ],
            ),
            Column(spacing: 5,children: [
              Text(AppStrings.carImage, style: AppTextStyle.font16black500),
                IconButton(
              onPressed: () {
                registerCubit.pickCarImage();
              },
              icon: Stack(
                alignment: Alignment.center,
                children: [
                  AppImageView(
                    radius: BorderRadius.circular(10),
                    shape: BoxShape.rectangle,
                    file: registerCubit.imageCar,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                        color: Colors.black26, shape: BoxShape.rectangle),
                  ),
                  const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            ],)
          ],
        ),
      );
}
