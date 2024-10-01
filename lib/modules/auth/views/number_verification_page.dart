import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:produce_pos/modules/auth/components/otp_section.dart';
import 'package:produce_pos/modules/auth/components/verify_otp_section.dart';
import 'package:produce_pos/modules/auth/controllers/auth_controller.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_colors.dart';

class NumberVerificationPage extends StatefulWidget {
  const NumberVerificationPage({super.key});

  @override
  State<NumberVerificationPage> createState() => _NumberVerificationPageState();
}

class _NumberVerificationPageState extends State<NumberVerificationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a given duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
          seconds: 5), // Set to the total duration of your Lottie animation
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to animate to a specific time
  void animateToSpecificTime(double progress) {
    _controller.animateTo(progress); // progress should be between 0.0 and 1.0
  }

  // Function to animate from a specific time
  void animateFromSpecificTime(double progress) {
    // Set the starting point of the animation
    _controller.value = progress;
    // Start the animation from the given progress
    _controller.forward();
  }

  final formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = Get.arguments;
    final authController = Get.find<AuthController>();

    return Scaffold(
        backgroundColor: AppColors.scaffoldWithBoxBackground,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                LottieWidget(),
                OtpSection(
                    phoneNumber: phoneNumber,
                    formKey: formKey,
                    codeController: codeController),
                VerifyOtpSection(
                    authController: authController,
                    formKey: formKey,
                    codeController: codeController,
                    phoneNumber: phoneNumber),
              ],
            ),
          ),
        ));
  }

  LottieBuilder LottieWidget() {
    return LottieBuilder.asset(
      'assets/lottie/lock.json',
      height: 200.spMax,
      width: 200.spMax,
      controller: _controller,
      onLoaded: (composition) {
        animateToSpecificTime(0.5);
        // Set the animation duration based on the Lottie animation's duration
        _controller.duration = composition.duration;
      },
    );
  }
}
