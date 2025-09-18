import 'package:ala_darbak_captain/features/orders/repositories/model/order_model.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/model/city_model.dart';
import '../../../repositories/model/trip_model.dart';

class TripsState extends Equatable {
  final CityModel? startCity;
  final CityModel? destenationCity;
  final String? date;
  final TripModel? trip;
  final List<TripModel> trips;
  final List<TripModel> activeTrips;
  final List<OrderModel> orders;
  final bool loading;
  final bool error;

  const TripsState({
    this.trip,
    this.orders = const [],
    this.trips = const [],
    this.activeTrips = const [],
    this.startCity,
    this.destenationCity,
    this.date,
    this.loading = false,
    this.error=false,
  });

  TripsState copyWith({
    CityModel? startCity,
    CityModel? destenationCity,
    TripModel? trip,
    List<TripModel>? trips,
    List<TripModel>? activeTrips,
    List<OrderModel>? orders,
    String? date,
    bool? loading,
    bool? error,
  }) {
    return TripsState(
      trip: trip??this.trip,
      trips: trips ?? this.trips,
      activeTrips: activeTrips ?? this.activeTrips,
      orders: orders ?? this.orders,
      startCity: startCity,
      destenationCity: destenationCity,
      date: date,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        trip,
        trips,
        activeTrips,
        startCity,
        destenationCity,
        orders,
        date,
        loading,
        error,
      ];
}
