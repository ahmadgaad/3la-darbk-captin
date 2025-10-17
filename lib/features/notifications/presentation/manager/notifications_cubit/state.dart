import 'package:equatable/equatable.dart';

import '../../../repositories/model/notifications_model.dart'
    show NotificationsModel;

class NotificationsState extends Equatable {
  final bool loading;
  final bool success;
  final bool error;
  final List<NotificationsModel> notifications;

  const NotificationsState({
    this.notifications = const [],
    this.loading = false,
    this.success = false,
    this.error = false,
  });

  NotificationsState copyWith({
    List<NotificationsModel>? notifications,
    bool? loading,
    bool? success,
    bool? error,
  }) {
    return NotificationsState(
      notifications: notifications ?? this.notifications,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [loading, notifications, success, error];
}
