import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/repositories.dart';
import 'state.dart';

class CommissionCubit extends Cubit<CommissionState> {
  final CommissionRepository _commessionRepository;

  CommissionCubit(this._commessionRepository) : super(const CommissionState()) {
    getCommission();
  }

  getCommission() async {
    final result = await _commessionRepository.getCommission();
    result.fold(
      (l) => emit(state.copyWith(success: true, commission: l, loading: false)),
      (r) => emit(state.copyWith(success: false, loading: false)),
    );
  }

  payCommission(String amount) async {
    (await _commessionRepository.payCommission(amount)).fold(
      (l) => getCommission(),
      (r) {},
    );
  }

  withDrawProfits(String amount) async {
    (await _commessionRepository.withDrawProfits(amount)).fold(
      (l) => getCommission(),
      (r) {},
    );
  }
}
