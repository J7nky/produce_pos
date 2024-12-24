// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';

class EmptyState extends StatelessWidget {
  final String image;
  final String heading;
  final String description;
  final Widget button;
  const EmptyState(
      {super.key,
      required this.image,
      required this.heading,
      required this.description,
      required this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding * 3),
              child: Image.asset(
                image,
                width: 500.w,
                height: 500.h,
              ),
            ),
          ),
          Text(
            heading,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center),
          ),
          Padding(
              padding: const EdgeInsets.only(top: AppDefaults.padding * 2.5),
              child: button)
        ],
      ),
    );
  }
}

navigationButtonWidget(String text) {
  return Container(
    padding: const EdgeInsets.only(
        right: AppDefaults.padding, left: AppDefaults.padding),
    height: 90.h,
    width: 500.w,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(300.r)),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withOpacity(0.6),
          blurRadius: 7,
          spreadRadius: 1,
        )
      ],
      color: AppColors.primary,
    ),
    child: Center(
        child: Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 50.sp, fontWeight: FontWeight.w500),
    )),
  );
}
