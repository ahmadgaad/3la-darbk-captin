import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../../../../core/temp/app_temp.dart';
import '../../repositories/repositories.dart';
import 'state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepository _ordersRepository;

  OrdersCubit(this._ordersRepository)
    : super(
        OrdersState(
          dates: dates,
          statuses: [
            MapEntry(0, AppStrings.pending),
            MapEntry(1, AppStrings.accepted),
            MapEntry(2, AppStrings.picked),
            MapEntry(3, AppStrings.delivered),
            MapEntry(4, AppStrings.notApproved),
            MapEntry(5, AppStrings.canceled),
          ],
        ),
      ) {
    getActiveOrders();
    getHistoryOrders();
  }

  getHistoryOrders() async {
    final result = await _ordersRepository.getHistoryOrders();
    result.fold(
      (l) {
        emit(state.copyWith(loading: false, success: true, historyOrders: l));
      },
      (r) {
        emit(state.copyWith(loading: false, error: r.message, success: false));
      },
    );
  }

  getActiveOrders() async {
    emit(state.copyWith(activeOrdersLoading: true, activeOrdersError: false));
    final result = await _ordersRepository.getActiveOrders();
    result.fold(
      (l) {
        emit(
          state.copyWith(
            activeOrders: l,
            activeOrdersLoading: false,
            activeOrdersError: false,
            success: true,
          ),
        );
      },
      (r) {
        emit(
          state.copyWith(
            activeOrdersError: true,
            activeOrdersLoading: false,
            error: r.message,
            success: false,
          ),
        );
      },
    );
  }

  applyFilter({
    String? startCity,
    String? destenationCity,
    String? date,
    int? status,
  }) {
    emit(
      state.copyWith(
        startCity: startCity ?? state.startCity,
        destinationCity: destenationCity ?? state.destinationCity,
        status: status ?? state.status,
        date: date ?? state.date,
      ),
    );
  }

  removeFilters() {
    emit(
      state.copyWith(
        startCity: null,
        destinationCity: null,
        date: null,
        status: null,
      ),
    );
  }
}
