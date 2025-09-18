import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_utils/app_strings.dart';
import '../../../../../core/utils/heplers/image_picker.dart';
import '../../../../../core/widgets/app_toaster.dart';
import '../../../repositories/models/user_model.dart';
import '../../../repositories/repositories.dart';
import 'state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(const RegisterState());


  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> formKey3 = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();
  final TextEditingController licenseEndDateController =
      TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  final TextEditingController bankNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController carTypeController = TextEditingController();
  final TextEditingController carModelController = TextEditingController();
  final TextEditingController blateNumberController = TextEditingController();
  final TextEditingController blateAlphaController = TextEditingController();
  final TextEditingController manufactureYearController =
      TextEditingController();
  bool isPrivacyPolicyAccepted = false;
  File? image;
  File? imageCar;
  pickImage() async {
    image = await ImagePickerUtils.getImage();
    emit(state.copyWith());
  }

  pickCarImage() async {
    imageCar = await ImagePickerUtils.getImage();
    emit(state.copyWith());
  }

  checkPrivacyPolicy(bool? v) {
    isPrivacyPolicyAccepted = !isPrivacyPolicyAccepted;
    emit(state.copyWith());
  }

  void nextStep(int step) {
    if (state.step == 0 && !(formKey.currentState?.validate() ?? false)) {
      return;
    }
    if (state.step == 1 && (!(formKey2.currentState?.validate() ?? false)||image==null)) {
      if(image==null){
        AppToaster.show(AppStrings.imageRequired);
      }
      return;
    }
    if (state.step == 2 && !(formKey3.currentState?.validate() ?? false)) {
      return;
    }
    if (step > 2) {
      return;
    }

    emit(state.copyWith(step: step));
  }

  void previousStep(int step) {
    if (step < 0) {
      return;
    }
    emit(state.copyWith(step: step));
  }

  void checkUser() async {
    if(formKey.currentState?.validate() ?? false)
   { emit(state.copyWith(loading: true));
    final result = await _authRepository.checkUserExists(
      mobile: phoneController.text,
    );
    result.fold((userExist) {
      if (userExist) {
        AppToaster.show(AppStrings.userExist);
        emit(state.copyWith(loading: false, userExist: userExist));
      } else {
        emit(state.copyWith(loading: false, userExist: userExist, step: 1));
      }
    }, (r) => emit(state.copyWith(loading: false, success: false)));}
  }

  void register() async {
    if (formKey3.currentState!.validate() && isPrivacyPolicyAccepted
    &&imageCar!=null) {
      emit(state.copyWith(loading: true));

      final result = await _authRepository.register(UserModel.register(
          imageFile: image,
          name: nameController.text,
          password: passwordController.text,
          mobile: phoneController.text,
          address: addressController.text,
          dateOfBirth: birthdayController.text,
          nationalNumber: idNumberController.text,
          licenseExpiration: licenseEndDateController.text,
          nameBank: bankNameController.text,
          bankAccountNumber: bankNumberController.text,
          typeCar: carTypeController.text,
          categoryCar: carModelController.text,
          yearManufacture: manufactureYearController.text,
          platesNumber: blateNumberController.text,
          platesString: blateAlphaController.text,
          imageCarFile: imageCar));
      result.fold((l) => emit(state.copyWith(success: true, loading: false)),
          (r) => emit(state.copyWith(loading: false)));
    } else if (!isPrivacyPolicyAccepted) {
      AppToaster.show(AppStrings.acceptPrivacyPolicy);
    }else if(imageCar==null){
      AppToaster.show(AppStrings.imageCarRequired);
    }
  }
  @override
  Future<void> close() {
    phoneController.dispose();
    passwordController.dispose();
    addressController.dispose();
    nameController.dispose();
    birthdayController.dispose();
    idNumberController.dispose();
    licenseEndDateController.dispose();
    bankNameController.dispose();
    bankNumberController.dispose();
    confirmPasswordController.dispose();
    carTypeController.dispose();
    carModelController.dispose();
    blateNumberController.dispose();
    blateAlphaController.dispose();
    manufactureYearController.dispose();
    return super.close();
  }
}
