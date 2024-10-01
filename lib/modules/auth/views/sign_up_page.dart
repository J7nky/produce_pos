import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/components/high_lighted_button.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/core/utils/validators.dart';
import 'package:produce_pos/modules/auth/controllers/auth_controller.dart';
import '../../../core/constants/app_defaults.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _phoneController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 90.spMax,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppDefaults.padding, top: AppDefaults.padding * 2),
              child: Text("Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white)
                  // TextStyle(
                  //     fontWeight: FontWeight.w600,
                  //     fontSize: 30.spMax,
                  //     color: Colors.white),
                  ),
            ),
            SizedBox(
              height: 30.spMax,
            ),
            Expanded(
              child: Container(
                height: 0.5.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(100.r),
                    topRight: Radius.circular(100.r),
                  ),
                ),
                child: ListView(children: [
                  SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: AppDefaults.padding,
                        bottom: AppDefaults.padding / 2),
                    child: Text("Welcome Dear",
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: AppDefaults.padding),
                      child: Text(
                          "Join and have a wonderful shopping experince😄",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.grey))),
                  SizedBox(
                    height: 30.spMax,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppDefaults.padding),
                    child: Form(
                      key: _formKey, // GlobalKey for form state management

                      child: TextFormField(
                        validator: Validators.lebanesePhoneValidator,
                        textInputAction: TextInputAction.next,
                        cursorColor: Colors.green,
                        controller: _phoneController,
                        maxLength: 8,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          focusColor: Colors.green,
                          hintText: "Phone Number*",
                          hintStyle: Theme.of(context).textTheme.bodyLarge,
                          labelStyle: Theme.of(context).textTheme.displaySmall,
                          prefix: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flag.fromCode(
                                FlagsCode.LB,
                                height: 20.spMax,
                                width: 20.spMax,
                              ),
                              Text(
                                " +961 ",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    if (authController.isLoading.value) {
                      return AlertDialog(
                        content: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return highLightedButton(
                          text: "Sign In",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (authController.canResendOTP.value) {
                                await authController.sendOtpToPhone(
                                    "+961${_phoneController.text}");
                              } else {
                                Get.snackbar("Wait",
                                    "Please wait for the timer to finish.");
                              }
                              if (authController.isOTPsent == true) {
                                Get.toNamed(AppRoutes.numberVerification,
                                    arguments: "${_phoneController.text}");
                              }
                            }
                          });
                    }
                  }),
                  SizedBox(
                    height: 30.spMax,
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Alreay Registered??",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(
                            onPressed: () async {},
                            child: Text("Sign Up",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.green))),
                      ],
                    ),
                  ),
                ]),
              ),
            )
          ],

          // SignUpPageHeader(),
          // SizedBox(height: AppDefaults.padding),
          // SignUpForm(),
        ),
      ),
    );
  }
}
