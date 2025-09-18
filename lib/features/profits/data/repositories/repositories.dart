import 'package:dartz/dartz.dart';

import '../../../../core/data/exceptions/exceptions.dart';
import '../../../../core/data/remote/api_client.dart';
import '../../../../core/data/remote/api_end_points.dart';
import '../models/commission_model.dart';

abstract class CommissionRepository {
  Future<Either<CommissionModel, AppException>> getCommission();
  Future<Either<void, AppException>> payCommission(String amount);
  Future<Either<void, AppException>> withDrawProfits(String amount);
}

class CommissionRepositoryImpl implements CommissionRepository {
  final ApiClient _apiClient;

  CommissionRepositoryImpl(this._apiClient);

  @override
  Future<Either<CommissionModel, AppException>> getCommission() async {
    try {
      final response = await _apiClient.get(endPoint: ApiEndPoints.commission);

      return Left(CommissionModel.fromJson(response.data));
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<void, AppException>> payCommission(String amount) async {
    try {
      await _apiClient.post(
        endPoint: ApiEndPoints.payCommission,
        data: {"paid_commission": amount},
      );
      return const Left(null);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<void, AppException>> withDrawProfits(String amount)  async {
    try {
      await _apiClient.post(
        endPoint: ApiEndPoints.withDrawProfits,
        data: {"withdrawprofit": amount},
      );
      return const Left(null);
    } on AppException catch (e) {
      return Right(e);
    }
  }
}
