import 'package:flutter/material.dart';

import '../../../../core/utils/app_utils/app_strings.dart';

class ProcessItem extends StatelessWidget {
  const ProcessItem({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Row(
              children: [
                Text(AppStrings.processesNumber),
                Text(": 561654654654"),
              ],
            )),
        Align(
            alignment: Alignment.bottomLeft,
            child: Row(mainAxisAlignment:MainAxisAlignment.end,
              children: [
                Text(AppStrings.date),
                Text(": 20/10/2024"),
              ],
            )),
      ],
    );
  }
}
