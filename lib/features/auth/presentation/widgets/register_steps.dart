import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/style/app_color.dart';

class RegisterSteps extends StatelessWidget {
  final int step;
  const RegisterSteps({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          _dotBuilder(step >= 0),
          Flexible(child: _lineBuilder()),
          _dotBuilder(step >= 1),
          Flexible(child: _lineBuilder()),
          _dotBuilder(step >= 2),
    
        ],
      ),
    );
  }

  Widget _lineBuilder() => Container(
        height: 2,
        color: AppColors.desSelected,
      );
  Widget _dotBuilder(bool isSelecet) => Container(
        width: 25.w,
        height: 25.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.desSelected, width: 2),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
              width: 15.w,
              height: 15.h,
              decoration: BoxDecoration(
                color: isSelecet ? AppColors.primary : Colors.transparent,
                shape: BoxShape.circle,
              )),
        ),
      );
}
