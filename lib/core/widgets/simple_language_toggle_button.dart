import 'package:ala_darbak_captain/features/profile/presentation/manager/profile_cubit/state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/profile/presentation/manager/profile_cubit/cubit.dart';

class SimpleLanguageToggleButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final Color? color;

  const SimpleLanguageToggleButton({
    super.key,
    this.icon,
    this.text,
    this.color,
  });

  Future<void> _toggleLanguage(BuildContext context) async {
    final profileCubit = context.read<ProfileCubit>();
    await profileCubit.toggleLanguage();
    if (context.mounted) {
      context.setLocale(profileCubit.state.currentLocale);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, ProfileState profileState) {
        return IconButton(
          onPressed: () => _toggleLanguage(context),
          icon: Icon(icon ?? Icons.language, color: color),
          tooltip: text ?? 'language'.tr(),
        );
      },
    );
  }
}
