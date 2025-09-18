import 'package:dartz/dartz.dart';

import '../../../core/data/exceptions/exceptions.dart';
import '../../../core/data/remote/api_end_points.dart';
import '../../../core/data/remote/api_client.dart';
import '../../orders/repositories/model/order_model.dart';

abstract class OrderRepository {
  Future<Either<OrderModel?, AppException>> assignOrder(int orderId);
  Future<Either<OrderModel?, AppException>> updateOrder(
      {required int orderId, required int status});
  Future<Either<OrderModel?, AppException>> getOrder(int orderId);
  Future<Either<OrderModel?, AppException>> payOrder(int orderId);
}

class OrderRepositoryImpl implements OrderRepository {
  final ApiClient _apiClient;

  OrderRepositoryImpl(this._apiClient);

  @override
  Future<Either<OrderModel?, AppException>> assignOrder(int orderId) async {
    try {
      final response = await _apiClient.post(
        endPoint: "${ApiEndPoints.assignOrder}/$orderId",
        showErrorMessage: true,
        isFormData: true,
      );
      return Left(OrderModel.fromJson(response.data));
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<OrderModel?, AppException>> getOrder(int orderId) async {
    try {
      final response = await _apiClient.get(
        endPoint: '${ApiEndPoints.orders}/$orderId',
        showErrorMessage: false,
      );
      return Left(OrderModel.fromJson(response.data));
    } on AppException catch (e) {
      return Right(e);
    }
  }
  
  @override
  Future<Either<OrderModel?, AppException>> updateOrder({required int orderId, required int status}) async {
    try {
      final response = await _apiClient.post(
        endPoint: "${ApiEndPoints.updateOrder}/$orderId",
        showErrorMessage: true,
        isFormData: true,
        data: {"status": status.toString()},
      );
      return Left(OrderModel.fromJson(response.data));
    } on AppException catch (e) {
      return Right(e);
    }
  }
  
  @override
  Future<Either<OrderModel?, AppException>> payOrder(int orderId) async {
    try {
      final response = await _apiClient.post(
        endPoint: "${ApiEndPoints.payOrder}/$orderId",
        showErrorMessage: true,
        isFormData: true,
      );
      return Left(OrderModel.fromJson(response.data));
    } on AppException catch (e) {
      return Right(e);
    }
  }

}
