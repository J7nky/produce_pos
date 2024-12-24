import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget dragHandle() {
  return Center(
    child: Container(
      height: 15.h,
      width: 90.w,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(12)),
    ),
  );
}
