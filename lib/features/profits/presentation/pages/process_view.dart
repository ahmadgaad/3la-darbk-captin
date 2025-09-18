import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/process_item.dart';

class ProcessView extends StatelessWidget {
  const ProcessView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          itemBuilder: (context, index) => const ProcessItem(),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: 30);
  }
}