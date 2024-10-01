import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:produce_pos/core/constants/app_colors.dart';

class highLightedButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const highLightedButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.spMax),
        child: Card(
          elevation: 1,
          child: Container(
            height: 45.spMax,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(-1, -1),
                      color: Colors.transparent.withOpacity(0.1))
                ],
                color: AppColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(30.r))),
            child: Center(
                child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
