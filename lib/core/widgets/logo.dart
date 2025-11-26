import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, this.size = 300});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/updated_splash.png",
      width: size.w,
      height: size.h,
    );
  }
}
