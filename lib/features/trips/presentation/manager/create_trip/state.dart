import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../repositories/model/city_model.dart';

class CreateTripState extends Equatable {
  final CityModel? startCity;
  final CityModel? destinationCity;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final bool loading;
  final bool success;
  final bool error;

  const CreateTripState({
    this.startCity,
    this.destinationCity,
    this.loading = false,
    this.success=false,
    this.error=false,
    required this.dateController,
    required this.timeController,
  });

  CreateTripState copyWith({
    CityModel? startCity,
    CityModel? destinationCity,
    bool? loading,
    bool? success,
    bool? error,
  }) {
    return CreateTripState(
      startCity: startCity ?? this.startCity,
      destinationCity: destinationCity ?? this.destinationCity,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      dateController: dateController,
      timeController: timeController,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
        startCity,
        destinationCity,
        dateController,
        timeController,
        success,
        loading,
        error,
      ];
}
