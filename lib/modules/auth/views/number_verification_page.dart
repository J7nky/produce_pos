import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/components/app_back_button.dart';

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
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(vsync: this);

    // Listen for when the animation reaches 50% and reset
    _controller.addListener(() {
      if (authController.status == AuthenticationStatus.authenticated) {
        _controller.forward();
      } else if (_controller.value >= 0.5) {
        _controller.reset();
        _controller.animateTo(1);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = Get.arguments;

    return Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: const Text('Verify OTP'),
        ),
        backgroundColor: AppColors.scaffoldWithBoxBackground,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.spMax,
              ),
              LottieWidget(),
              OtpSection(
                  phoneNumber: phoneNumber,
                  formKey: _formKey,
                  codeController: codeController),
              VerifyOtpSection(
                  authController: authController,
                  formKey: _formKey,
                  codeController: codeController,
                  phoneNumber: phoneNumber),
            ],
          ),
        ));
  }

  LottieBuilder LottieWidget() {
    return LottieBuilder.asset(
      'assets/lottie/lock.json',
      height: 250.spMax,
      width: 250.spMax,
      controller: _controller,
      repeat: false,
      onLoaded: (composition) {
        // Set the duration of the controller to match the animation's duration
        _controller.duration = composition.duration;

        // Start the animation
        _controller.forward(from: 0.0);
      },
    );
  }
}
