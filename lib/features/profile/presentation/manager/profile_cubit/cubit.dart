import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/config/routes/app_routes.dart';
import '../../../../../core/utils/app_utils/app_strings.dart';
import '../../../../../core/utils/heplers/image_picker.dart';
import '../../../../../core/widgets/app_toaster.dart';
import '../../../repositories/repositories.dart';
import 'state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _profileRepository;

  ProfileCubit(this._profileRepository) : super(const ProfileState());


   getProfile() async {
    final result = await _profileRepository.getDriverData();
    result.fold((l) {
      emit(state.copyWith(success: true, currentUser: l,loading: false,));
      _initFormField();
    }, (r) {
      if (r.message.contains('Unauthenticated')) {
        logout();
      }

      emit(state.copyWith( success: false,loading: false));
    });
  }

  void logout() async {
    final result = await _profileRepository.logout();
    result.fold((l) {
      AppRoute.pushNamedAndRemoveUntil(AppRoute.auth);
      emit(state.copyWith(success: true, logedOut: true, loading: false));
    }, (r) => emit(state.copyWith(loading: false, success: false)));
  }

  void delete() async {
    emit(state.copyWith(loading: true));
    final result = await _profileRepository.delete();
    result.fold((value) {
      AppToaster.show(AppStrings.deletedSuccessfully, isError: false);
      AppRoute.pushNamedAndRemoveUntil(AppRoute.auth);
      emit(state.copyWith(success: true, loading: false));
    }, (r) => emit(state.copyWith(loading: false, success: false)));
  }

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

  void _initFormField() {
    phoneController.text = state.currentUser?.mobile ?? "";
    addressController.text = state.currentUser?.address ?? "";
    nameController.text = state.currentUser?.name ?? "";
    birthdayController.text = state.currentUser?.dateOfBirth ?? "";
    idNumberController.text = state.currentUser?.nationalNumber ?? "";
    licenseEndDateController.text = state.currentUser?.licenseExpiration ?? "";
    bankNameController.text = state.currentUser?.nameBank ?? "";
    bankNumberController.text = state.currentUser?.bankAccountNumber ?? "";
    carTypeController.text = state.currentUser?.typeCar ?? "";
    carModelController.text = state.currentUser?.categoryCar ?? "";
    blateNumberController.text = state.currentUser?.platesNumber ?? "";
    blateAlphaController.text = state.currentUser?.platesString ?? "";
    manufactureYearController.text = state.currentUser?.yearManufacture ?? "";
    image=null;
    imageCar=null;
  }

  void updateData() async {
    if (state.currentUser == null) return;
    if (!formKey.currentState!.validate()) return;
    emit(state.copyWith(loading: true));
    final result = await _profileRepository.updateData(state.currentUser!
        .copyWith(
            imageFile: image,
            name: nameController.text,
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
    result.fold((value) {
      AppToaster.show(AppStrings.updatedSuccessfully, isError: false);
      emit(state.copyWith(success: true, currentUser: value, loading: false));
      _initFormField();
    }, (r) => emit(state.copyWith(loading: false, success: false)));
  }

  changeAvailablilty() async {
    final workValid = state.currentUser?.workValid == 1 ? 0 : 1;
    final result = await _profileRepository.available(workValid);
    result.fold((value) => emit(state.copyWith(
        success: true,
        currentUser: state.currentUser?.copyWith(workValid: workValid),
      )), (r) => emit(state.copyWith(success: false)));
  }
}
