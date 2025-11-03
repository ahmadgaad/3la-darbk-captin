import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/city_model.dart';
import '../../../data/model/trip_model.dart';
import '../../../data/repository/trips_repository.dart';
import 'create_trip_states.dart';

class CreateTripCubit extends Cubit<CreateTripState> {
  final TripsRepository _tripsRepository;
  CreateTripCubit(this._tripsRepository)
    : super(
        CreateTripState(
          dateController: TextEditingController(),
          timeController: TextEditingController(),
        ),
      );

  selectCities({CityModel? startCity, CityModel? destenationCity}) {
    emit(
      state.copyWith(startCity: startCity, destinationCity: destenationCity),
    );
  }

  Future<void> creatTrip() async {
    if (state.loading) return;
    emit(state.copyWith(loading: true));
    await Future.delayed(const Duration(seconds: 1));
    // use startCity latitude and longitude
    final result = await _tripsRepository.createTrip(
      TripModel(
        cityFromId: state.startCity?.id,
        cityToId: state.destinationCity?.id,
        date: state.dateController.text,
        time: state.timeController.text,
        latitude: state.startCity?.latitude,
        longitude: state.startCity?.longitude,
      ),
    );
    result.fold(
      (trip) => emit(state.copyWith(success: true, loading: false)),
      (error) => emit(state.copyWith(error: true, loading: false)),
    );
  }
}
