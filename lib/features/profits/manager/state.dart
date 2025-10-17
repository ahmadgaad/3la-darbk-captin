import 'package:equatable/equatable.dart';

import '../data/models/commission_model.dart';

class CommissionState extends Equatable {
  final bool loading;
  final CommissionModel? commission;
  final bool success;
  final bool error;

  const CommissionState({
    this.commission,
    this.loading = false,
    this.success = false,
    this.error = false,
  });

  CommissionState copyWith({
    CommissionModel? commission,
    bool? loading,
    bool? logedOut,
    bool? success,
    bool? error,
  }) => CommissionState(
    loading: loading ?? this.loading,
    commission: commission ?? this.commission,
    success: success ?? this.success,
    error: error ?? this.error,
  );

  @override
  List<Object?> get props => [commission, loading, success, error];
}
