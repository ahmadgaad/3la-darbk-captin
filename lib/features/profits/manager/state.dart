import 'package:equatable/equatable.dart';

import '../data/models/commission_model.dart';

class CommissionState extends Equatable {
  final bool loading;
  final CommissionModel? commission;
  final bool success;

  const CommissionState({
    this.commission,
    this.loading = false,
    this.success = false,
  });

  CommissionState copyWith({
    CommissionModel? commission,
    bool? loading,
    bool? logedOut,
    bool? success,
  }) => CommissionState(
    loading: loading ?? this.loading,
    commission: commission ?? this.commission,
    success: success ?? this.success,
  );

  @override
  List<Object?> get props => [commission, loading, success];
}
