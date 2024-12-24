import 'dart:async';

import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:produce_pos/core/routes/app_routes.dart';
import 'package:produce_pos/data/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthenticationStatus {
  authenticated,
  unauthenticated,
  unknown,
}

var supabase = Supabase.instance.client;

class AuthController extends GetxController {
  final User? user = supabase.auth.currentUser;
  final AuthService _authService;
  var isLoading = false.obs;
  var isOTPsent = false.obs;
  var canResendOTP = false.obs; // To control the button availability
  var countdown = 0.obs; // To display the remaining time
  Timer? _timer; // For managing the countdown
  var status = AuthenticationStatus.unknown.obs;
  void checkAuthStatus() {
    if (user != null) {
      status = AuthenticationStatus.authenticated.obs;
    } else {
      status = AuthenticationStatus.unauthenticated.obs;
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkAuthStatus(); //Initially, check user auth
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

  void login() {
    status.value = AuthenticationStatus.authenticated;
  }

  // Function to update the status to unauthenticated

  void logout() async {
    status.value = AuthenticationStatus.unauthenticated;
    try {
      isLoading(true); // Optional: Show a loading indicator

      // Sign out the user from Supabase
      final response = await supabase.auth.signOut();

      isLoading(false);

      // Clear any stored user data (if applicable)
      clearUserData();

      // Navigate to the login screen or welcome screen
      Get.offAllNamed(AppRoutes.entryPoint);

      Get.snackbar('Success', 'You have been logged out.');
    } catch (e) {
      isLoading(false);

      // Handle errors during logout
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }

  void clearUserData() {
    // Implement clearing of user data if needed, e.g., shared preferences
    // Example:
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.clear();
  }

  AuthController(this._authService);
  Future<void> sendOtpToPhone(String phoneNumber) async {
    isLoading(true);
    try {
      await _authService.sendOtpToPhone(phoneNumber);
      Get.snackbar(
          'Sucsess', 'OTP code verification sent to your mobile number');
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

      // Step 1: Verify OTP and sign in the user
      final response =
          await _authService.verifyOtpAndSignIn("+961" + phoneNumber, otp);
      var user = supabase.auth.currentUser;
      // Ensure the OTP is valid
      // if (response.user == null) {
      //   throw Exception("OTP verification failed.");
      // }

      final userId = user!.id; // Get the authenticated user ID

      // Step 2: Check if the user exists in the Auth table
      final userExists =
          await _authService.checkUserExistsInAuthTable("+961" + phoneNumber);

      isLoading(false);

      if (userExists) {
        // If the user exists, navigate to the home screen
        Get.snackbar('Success', 'You are logged in!');
        Get.offNamed(AppRoutes.entryPoint);
        login(); // Perform any additional login setup
      } else {
        // Step 3: Create an entry in the Auth table for the new user
        print("12312123 $phoneNumber");
        final authCreationSuccess = await _authService.createAuthEntry(
          userId,
          "961" + phoneNumber,
        );

        if (authCreationSuccess) {
          // Navigate to the registration form if creation is successful
          Get.snackbar('Welcome', 'Please complete your registration.');
          Get.offNamed(AppRoutes.registrationForm);
        } else {
          throw Exception("Failed to create user in Auth table.");
        }
      }
    } catch (e) {
      isLoading(false);

      if (e is AuthException) {
        // Handle authentication-related errors
        Get.snackbar(
            'Error', 'The OTP code you entered is invalid, try again.');
      } else {
        // Handle other exceptions
        Get.snackbar('Error', e.toString());
      }
    }
  }
}
