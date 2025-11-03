import 'package:dartz/dartz.dart';
import '../../../../core/data/exceptions/exceptions.dart';
import '../../../../core/data/remote/api_end_points.dart';
import '../../../../core/data/remote/api_client.dart';
import '../../../orders/repositories/model/order_model.dart';
import '../model/city_model.dart';
import '../model/trip_model.dart';

abstract class TripsRepository {
  Future<Either<List<CityModel>, AppException>> getCities();
  Future<Either<List<TripModel>, AppException>> getActiveTrips();
  Future<Either<List<TripModel>, AppException>> getTrips();
  Future<Either<List<OrderModel>, AppException>> getTripOrders(int tripId);

  Future<Either<TripModel?, AppException>> createTrip(TripModel trip);
  Future<Either<TripModel?, AppException>> updateTrip(
      {required int tripId, required int status});
  Future<Either<TripModel?, AppException>> getTrip({required int tripId});
}

class TripsRepositoryImpl implements TripsRepository {
  final ApiClient _apiClient;

  TripsRepositoryImpl(
    this._apiClient,
  );

  @override
  Future<Either<List<CityModel>, AppException>> getCities() async {
    try {
      final response = await _apiClient.get(endPoint: ApiEndPoints.cities);
      final list =
          response.data?.map<CityModel>((e) => CityModel.fromJson(e)).toList();
      return Left(list);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<TripModel?, AppException>> createTrip(TripModel trip) async {
    try {
      final response = await _apiClient.post(
        endPoint: ApiEndPoints.trips,
        data: trip.toJson(),
      );

      final tripModel = TripModel.fromJson(response.data);
      return Left(tripModel);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<List<TripModel>, AppException>> getActiveTrips() async {
    try {
      final response = await _apiClient.get(endPoint: ApiEndPoints.activeTrips);
      final list =
          response.data?.map<TripModel>((e) => TripModel.fromJson(e)).toList();
      return Left(list);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<TripModel?, AppException>> getTrip(
      {required int tripId}) async {
    try {
      final response =
          await _apiClient.get(endPoint: '${ApiEndPoints.trips}/$tripId');
      final tripModel = TripModel.fromJson(response.data);
      return Left(tripModel);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<List<TripModel>, AppException>> getTrips() async {
    try {
      final response = await _apiClient.get(endPoint: ApiEndPoints.trips);
      final list =
          response.data?.map<TripModel>((e) => TripModel.fromJson(e)).toList();
      return Left(list);
    } on AppException catch (e) {
      return Right(e);
    }
  }

  @override
  Future<Either<TripModel?, AppException>> updateTrip(
      {required int tripId, required int status}) async {
    try {
      final response = await _apiClient.post(
        endPoint: '${ApiEndPoints.tripUpdate}/$tripId',
        data: {"status": status.toString()},
      );
      final tripModel = TripModel.fromJson(response.data);
      return Left(tripModel);
    } on AppException catch (e) {
      return Right(e);
    }
  }
  
  @override
  Future<Either<List<OrderModel>, AppException>> getTripOrders(int tripId)async {
   try {
     final response =await _apiClient.get(endPoint: ApiEndPoints.tripOrders(tripId));
     final list = response.data?.map<OrderModel>((e) => OrderModel.fromJson(e)).toList();
     return Left(list);
   } on AppException catch (e) {
     return Right(e);
   }
  }
}
