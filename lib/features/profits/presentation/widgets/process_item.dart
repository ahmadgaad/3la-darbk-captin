import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';

class ProcessItem extends StatelessWidget {
  const ProcessItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Row(
            children: [
              Text(AppStrings.processesNumber),
              const Text(": 561654654654"),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text(AppStrings.date), const Text(": 20/10/2024")],
          ),
        ),
      ],
    );
  }
}
