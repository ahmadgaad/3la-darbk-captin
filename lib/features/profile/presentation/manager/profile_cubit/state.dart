

import 'package:equatable/equatable.dart';

import '../../../../auth/repositories/models/user_model.dart';

class ProfileState  extends Equatable{
  final bool loading;
  final UserModel? currentUser;
  final bool success;
  final bool logedOut;

  const ProfileState(
      {this.logedOut = false, this.currentUser, this.loading = false, this.success = false});

  ProfileState copyWith(
          {UserModel? currentUser,
          bool? loading,
          bool? logedOut,
          bool? success}) =>
      ProfileState(
          loading: loading ?? this.loading,
          logedOut: logedOut ?? this.logedOut,
          currentUser: currentUser ?? this.currentUser,
          success: success ?? this.success);
          
            @override
            List<Object?> get props => [currentUser,loading,logedOut,success];
          
}
