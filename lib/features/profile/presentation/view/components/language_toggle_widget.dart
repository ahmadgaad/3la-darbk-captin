import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/profile_cubit/cubit.dart';
import '../../view_model/profile_cubit/state.dart';

class LanguageToggleWidget extends StatelessWidget {
  const LanguageToggleWidget({super.key});

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
        return ListTile(
          onTap: () => _toggleLanguage(context),
          leading: const Icon(Icons.language),
          title: Text('language'.tr()),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profileState.currentLanguage == 'en' ? 'English' : 'العربية',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              Icon(Icons.swap_horiz, size: 16, color: Colors.grey[600]),
            ],
          ),
        );
      },
    );
  }
}
