import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/modules/auth/controllers/auth_controller.dart';

class LandingRoute extends StatelessWidget {
  const LandingRoute({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual logic to check if user is authenticated
    Future.delayed(const Duration(seconds: 1), () {
      final authController = Get.find<AuthController>();
      switch (authController.status.value) {
        case AuthenticationStatus.authenticated:
          Get.offNamed(AppRoutes.entryPoint);
          break;
        case AuthenticationStatus.unauthenticated:
        case AuthenticationStatus.unknown:
          Get.offNamed(AppRoutes.introLogin);
          break;
        default:
          Get.offNamed(AppRoutes.errorPage);
          break;
      }
    });

    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator()), // or a branding image/logo
    );
  }
}
