import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_utils/app_strings.dart';
import '../manager/profile_cubit/cubit.dart';
import '../manager/profile_cubit/state.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.deleteAccountTitle),
      content: Text(AppStrings.deleteAccountContent),
      actions: <Widget>[
        TextButton(
          child: Text(AppStrings.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.loading) {
              return const CircularProgressIndicator();
            }
            return TextButton(
              onPressed: context.read<ProfileCubit>().delete,
              child: Text(AppStrings.confirm),
            );
          },
        ),
      ],
    );
  }
}
