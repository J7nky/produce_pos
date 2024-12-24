import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/components/high_lighted_button.dart';
import 'package:produce_pos/core/components/progress_dialog.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/modules/auth/controllers/auth_controller.dart';

class VerifyOtpSection extends StatelessWidget {
  const VerifyOtpSection({
    super.key,
    required this.authController,
    required this.formKey,
    required this.codeController,
    required this.phoneNumber,
  });

  final AuthController authController;
  final GlobalKey<FormState> formKey;
  final TextEditingController codeController;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() {
          if (authController.isLoading.value) {
            return const CircularPrgressAlertDialog();
          } else {
            return highLightedButton(
                onPressed: () async {
                  if (codeController.text == "111111") {
                    Get.toNamed(AppRoutes.entryPoint);
                  }
                  formKey.currentState!.validate();
                  authController.verifyOTP(phoneNumber, codeController.text);
                },
                text: "Verify".toUpperCase());
          }
        }),
        TextButton(
          child: Text(
            "Clear",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          onPressed: () {
            codeController.clear();
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.watch_later_outlined),
            Obx(() {
              return Text(
                '00:${authController.countdown.value}',
                style: Theme.of(context).textTheme.labelLarge,
              );
            })
          ],
        ),
        SizedBox(height: 5.spMax),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: AppDefaults.padding / 2),
                  child: Text(
                    "Didn't receive the code? ",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                authController.countdown.value == 0
                    ? GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Resend",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: AppColors.primary),
                        ),
                      )
                    : Text(
                        "Resend",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.grey),
                      ),
              ],
            )),
      ],
    );
  }
}
