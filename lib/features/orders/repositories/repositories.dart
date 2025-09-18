import 'package:ala_darbak_captain/features/orders/repositories/model/order_model.dart';
import 'package:dartz/dartz.dart';
import '../../../core/data/exceptions/exceptions.dart';
import '../../../core/data/remote/api_end_points.dart';
import '../../../core/data/remote/api_client.dart';

abstract class OrdersRepository  {
  Future<Either<List<OrderModel>, AppException>> getHistoryOrders();
  Future<Either<List<OrderModel>, AppException>> getActiveOrders();
}

class OrdersRepositoryImpl implements OrdersRepository {
  final ApiClient _apiClient;


  OrdersRepositoryImpl(this._apiClient,);

  @override
  Future<Either<List<OrderModel>, AppException>> getHistoryOrders() async {
    try {
      final response = await _apiClient.get(endPoint: ApiEndPoints.orders);
      final list = response.data
          ?.map<OrderModel>((e) => OrderModel.fromJson(e))
          .toList();
      return Left(list);
    } on AppException catch (e) {
      return Right(e);
    }
  }
  
  @override
  Future<Either<List<OrderModel>, AppException>> getActiveOrders() async {
    try {
      final response = await _apiClient.get(endPoint: ApiEndPoints.activeOrders);
      final list = response.data
          ?.map<OrderModel>((e) => OrderModel.fromJson(e))
          .toList();
      return Left(list);
    } on AppException catch (e) {
      return Right(e);
    }
  }
}
