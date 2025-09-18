import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../repositories/model/city_model.dart';
import '../../../repositories/model/trip_model.dart';
import '../../../repositories/repositories.dart';
import 'state.dart';

class CreateTripCubit extends Cubit<CreateTripState> {
  final TripsRepository _tripsRepository;
  CreateTripCubit(this._tripsRepository)
      : super(CreateTripState(
            dateController: TextEditingController(),
            timeController: TextEditingController()));

  selectCities({
    CityModel? startCity,
    CityModel? destenationCity,
  }) {
    emit(state.copyWith(
      startCity: startCity,
      destinationCity: destenationCity,
    ));
  }

  creatTrip() async {
    if(state.loading) return;
    state.copyWith(loading: true);
    final result = await _tripsRepository.createTrip(TripModel(
      cityFromId: state.startCity?.id,
      cityToId: state.destinationCity?.id,
      date: state.dateController.text,
      time: state.timeController.text,
    ));
    result.fold(
        (trip) => emit(state.copyWith(
              success: true,
              loading: false,
            )),
        (error) => emit(state.copyWith(
              error: true,loading: false
            )));
  }
}
