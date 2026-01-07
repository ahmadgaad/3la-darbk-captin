import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/city_model.dart';
import '../../../data/model/trip_model.dart';
import '../../../data/repository/trips_repository.dart';
import 'state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripsRepository _tripsRepository;
  TripsCubit(this._tripsRepository) : super(const TripsState()) {
    getActiveTrips();
    getTrips();
  }

  applyFilter({
    CityModel? startCity,
    CityModel? destenationCity,
    String? date,
  }) {
    emit(
      state.copyWith(
        startCity: startCity ?? state.startCity,
        destenationCity: destenationCity ?? state.destenationCity,
        date: date ?? state.date,
      ),
    );
  }

  removeFilters() {
    emit(state.copyWith());
  }

  Future<void> getTrips() async {
    emit(state.copyWith(loading: true, error: false));
    await Future.delayed(const Duration(seconds: 2));
    final result = await _tripsRepository.getTrips();
    result.fold(
      (trips) {
        emit(state.copyWith(trips: trips, loading: false, error: false));
      },
      (error) {
        emit(state.copyWith(error: true, loading: false));
      },
    );
  }

  getActiveTrips() async {
    emit(state.copyWith(activeTripsLoading: true, activeTripsError: false));
    final result = await _tripsRepository.getActiveTrips();
    result.fold(
      (trips) {
        emit(
          state.copyWith(
            activeTrips: trips,
            activeTripsLoading: false,
            activeTripsError: false,
          ),
        );
      },
      (error) {
        emit(state.copyWith(activeTripsError: true, activeTripsLoading: false));
      },
    );
  }

  setTrip(TripModel? trip) {
    emit(state.copyWith(trip: trip, orders: []));
  }

  getTrip(int tripId) async {
    emit(state.copyWith(ordersLoading: true, ordersError: false));
    final result = await _tripsRepository.getTrip(tripId: tripId);
    result.fold(
      (trip) {
        emit(state.copyWith(trip: trip, loading: false));
      },
      (error) {
        emit(state.copyWith(error: true, loading: false, ordersLoading: false));
      },
    );
    if (!state.error) {
      getTripOrders(tripId);
    }
  }

  updateTrip(int status) async {
    if (state.trip == null || state.loading) return;
    emit(state.copyWith(loading: true));
    final result = await _tripsRepository.updateTrip(
      tripId: state.trip?.id ?? 0,
      status: status,
    );
    result.fold(
      (trip) {
        emit(state.copyWith(trip: trip, loading: false));
      },
      (error) {
        emit(state.copyWith(error: true, loading: false));
      },
    );
  }

  getTripOrders(int tripId) async {
    final result = await _tripsRepository.getTripOrders(tripId);
    result.fold(
      (orders) {
        emit(
          state.copyWith(
            orders: orders,
            ordersLoading: false,
            ordersError: false,
          ),
        );
      },
      (error) {
        emit(state.copyWith(ordersError: true, ordersLoading: false));
      },
    );
  }
}
