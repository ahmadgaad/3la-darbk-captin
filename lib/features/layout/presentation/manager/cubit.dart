import 'package:ala_darbak_captain/features/layout/presentation/widgets/profile_waiting_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/presentation/view_model/profile_cubit/cubit.dart';
import 'state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit(BuildContext context) : super(const LayoutState()){
    init(context);
  }

  init(BuildContext context) async {
    final profileCubit = context.read<ProfileCubit>();
    await profileCubit.getProfile();
    if (profileCubit.state.currentUser?.status == 0) {
      showDialog(
          context: context, builder: (context) => const ProfileWaitingReview());
    }
  }

  void changeIndex(int index) {
    emit(LayoutState(index: index));
  }
}
