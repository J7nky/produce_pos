import 'dart:async';

import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:produce_pos/data/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final AuthService _authService;
  var isLoading = false.obs;
  var isOTPsent = false.obs;
  var canResendOTP = false.obs; // To control the button availability
  var countdown = 0.obs; // To display the remaining time
  Timer? _timer; // For managing the countdown
  @override
  void onReady() {
    super.onReady();
    canResendOTP(true); // Initially, user can send OTP
  }

  @override
  void onClose() {
    _timer?.cancel(); // Make sure to cancel timer on controller disposal
    super.onClose();
  }

  void startTimer() {
    countdown(60); // Set initial countdown time
    canResendOTP(false);
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdown.value == 0) {
        timer.cancel();
        canResendOTP(true);
      } else {
        countdown(countdown.value - 1);
      }
    });
  }

  AuthController(this._authService);
  Future<void> sendOtpToPhone(String phoneNumber) async {
    isLoading(true);
    try {
      await _authService.sendOtpToPhone(phoneNumber);
      Get.snackbar('Sucsess', '');

      isLoading(false);
      isOTPsent(true);
      startTimer(); // Start the timer after sending OTP
      // Optionally handle the response if necessary
    } on AuthApiException catch (e) {
      Get.snackbar('Error', e.message);

      // Log the error or handle it accordingly
      throw Exception('Error sending OTP: ${e.message}');
    } catch (e) {
      // This catches any other exceptions that might not be specific to authentication
      Get.snackbar('Error', 'Failed to send OTP: $e');

      throw Exception('Failed to send OTP: $e');
    }
    isLoading(false);
  }

  void verifyOTP(String phoneNumber, String otp) async {
    try {
      isLoading(true);
      final response =
          await _authService.verifyOtpAndSignIn("+961" + phoneNumber, otp);

      isLoading(false);
      Get.snackbar('Success', 'You are logged in!');
      // Get.to(HomeScreen());
    } catch (e) {
      isLoading(false);

      if (e is AuthException) {
        String errorMessage;

        switch (e.code) {
          case 'invalid_otp':
            errorMessage = 'The OTP code you entered is invalid.';
            break;
          case 'account_locked':
            errorMessage = 'Your account is locked. Please contact support.';
            break;
          default:
            errorMessage = 'An unknown authentication error occurred.';
        }

        print('Error' + errorMessage);
      } else {
        // Handle other exceptions
        print('Error' + 'An unexpected error occurred: $e');
      }
    }
  }
}
