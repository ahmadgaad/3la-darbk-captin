import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/repositories.dart';
import 'state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _orderRepository;
  OrderCubit(this._orderRepository) : super(const OrderState());

  getOrder(int orderId) async {
    final result = await _orderRepository.getOrder(orderId);
    result.fold(
        (order) => emit(state.copyWith(
            loading: false,
            success: true,
            orderModel: order,
            notApproved: false)),
        (error) => emit(state.copyWith(
            loading: false, success: false, notApproved: false)));
  }

  assignOrder() async {
    if (state.orderModel == null) return;
    emit(state.copyWith(loading: true));
    final result =
        await _orderRepository.assignOrder(state.orderModel?.id ?? 0);
    result.fold(
        (order) => emit(state.copyWith(
            loading: false,
            success: true,
            orderModel: order,
            notApproved: false)),
        (error) => emit(state.copyWith(
            loading: false, success: false, notApproved: false)));
  }
  payOrder() async {
    if (state.orderModel == null) return;
    emit(state.copyWith(loading: true));
    final result =
        await _orderRepository.payOrder(state.orderModel?.id ?? 0);
    result.fold(
        (order) => emit(state.copyWith(
            loading: false,
            success: true,
            orderModel: order,
            notApproved: false)),
        (error) => emit(state.copyWith(
            loading: false, success: false, notApproved: false)));
  }

  updateOrder(int status) async {
    if (state.orderModel == null) return;
    emit(state.copyWith(loading: true));
    final result = await _orderRepository.updateOrder(
        orderId: state.orderModel?.id ?? 0, status: status);
    result.fold(
        (order) => emit(state.copyWith(
            loading: false,
            success: true,
            orderModel: order,
            notApproved: false)),
        (error) => emit(state.copyWith(
            loading: false, success: false, notApproved: false)));
  }
}
