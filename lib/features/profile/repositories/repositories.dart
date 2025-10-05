import 'package:dartz/dartz.dart';

import '../../../core/data/exceptions/exceptions.dart';
import '../../../core/data/local/shared_preferences_service.dart';
import '../../../core/data/remote/api_client.dart';
import '../../../core/data/remote/api_end_points.dart';
import '../../../core/utils/app_utils/app_strings.dart';
import '../../../core/widgets/app_toaster.dart';
import '../../auth/repositories/models/user_model.dart';

abstract class ProfileRepository {
  Future<Either<void, AppException>> changePassword({
    required String oldPassword,
    required String password,
  });
  Future<Either<void, AppException>> logout();
  Future<Either<void, AppException>> delete();
  Future<Either<UserModel, AppException>> getDriverData();
  Future<Either<UserModel, AppException>> updateData(UserModel user);
  Future<Either<void, AppException>> available(int available);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiClient _apiClient;
  final SharedPreferencesService _sharedPreferences;

  ProfileRepositoryImpl(this._apiClient, this._sharedPreferences);
  @override
  Future<Either<void, AppException>> changePassword({
    required String oldPassword,
    required String password,
  }) async {
    try {
      await _apiClient.post(
        endPoint: ApiEndPoints.changePassword,
        showErrorMessage: false,
        data: {"old_password": oldPassword, "new_password": password},
      );
      return const Left(null);
    } on AppException catch (e) {
      if (e is ServerException && e.statusCode == 400) {
        AppToaster.show(AppStrings.oldPasswordUnvalid);
      }
      return Right(e);
    }
  }

  @override
  Future<Either<UserModel, AppException>> getDriverData() async {
    try {
      final response = await _apiClient.get(endPoint: ApiEndPoints.driverData);
      await _apiClient.post(
        endPoint: ApiEndPoints.updateFcmToken,
        data: {"device_token": "das342sxee"},
      );
      final userModel = UserModel.fromJson(response.data ?? {});
      return Left(userModel);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<UserModel, AppException>> updateData(UserModel user) async {
    try {
      final response = await _apiClient.post(
        isFormData: true,
        endPoint: ApiEndPoints.updateDriver,
        data: user.toJson(),
      );
      final userModel = UserModel.fromJson(response.data ?? {});
      return Left(userModel);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<void, AppException>> logout() async {
    try {
      await _sharedPreferences.removeToken();
      return const Left(null);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<void, AppException>> delete() async {
    try {
      await _apiClient.delete(endPoint: ApiEndPoints.driverData);
      await _sharedPreferences.removeToken();
      return const Left(null);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<void, AppException>> available(int available) async {
    try {
      await _apiClient.post(
        isFormData: true,
        endPoint: ApiEndPoints.available,
        data: {'work_valid': available},
      );
      return const Left(null);
    } on AppException catch (e) {
      return Right(e);
    }
  }
}
