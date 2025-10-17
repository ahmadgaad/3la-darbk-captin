import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../auth/repositories/models/user_model.dart';

class ProfileState extends Equatable {
  final bool loading;
  final UserModel? currentUser;
  final bool success;
  final bool logedOut;
  final String currentLanguage;
  final Locale currentLocale;

  const ProfileState({
    this.logedOut = false,
    this.currentUser,
    this.loading = false,
    this.success = false,
    this.currentLanguage = 'en',
    Locale? currentLocale,
  }) : currentLocale = currentLocale ?? const Locale('en');

  ProfileState copyWith({
    UserModel? currentUser,
    bool? loading,
    bool? logedOut,
    bool? success,
    String? currentLanguage,
    Locale? currentLocale,
  }) => ProfileState(
    loading: loading ?? this.loading,
    logedOut: logedOut ?? this.logedOut,
    currentUser: currentUser ?? this.currentUser,
    success: success ?? this.success,
    currentLanguage: currentLanguage ?? this.currentLanguage,
    currentLocale: currentLocale ?? this.currentLocale,
  );

  @override
  List<Object?> get props => [
    currentUser,
    loading,
    logedOut,
    success,
    currentLanguage,
    currentLocale,
  ];
}
