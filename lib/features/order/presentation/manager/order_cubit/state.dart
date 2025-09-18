import 'package:equatable/equatable.dart';
import '../../../../orders/repositories/model/order_model.dart';


class OrderState extends Equatable {
  final OrderModel? orderModel;
  final bool loading;
  final bool success;
  final bool notApproved;

  const OrderState({
    this.orderModel,
    this.loading = false,
    this.success = false,
    this.notApproved = false,
  });

  OrderState copyWith(
      {
      OrderModel? orderModel,
      bool? loading,
      bool? success,
      bool? notApproved}) {
    return OrderState(
        orderModel: orderModel ?? this.orderModel,
        loading: loading ?? this.loading,
        success: success ?? this.success,
        notApproved: notApproved ?? this.notApproved);
  }

  @override
  List<Object?> get props => [
        loading,
        orderModel,
        success,
        notApproved
      ];
}
