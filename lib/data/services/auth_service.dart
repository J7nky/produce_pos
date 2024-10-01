import 'package:produce_pos/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Step 1: Send OTP to the user's phone number
  Future<void> sendOtpToPhone(String phoneNumber) async {
    try {
      await _client.auth.signInWithOtp(phone: phoneNumber).then((v) {
        print("success");
      });
    } on AuthApiException catch (e) {
      print('Failed to send OTP: $e');

      Exception('Error sending OTP:$e');
    } catch (e) {
      print('Failed to send OTP: $e');
      throw Exception('Failed to send OTP: $e');
    }
  }

  // Step 2: Verify OTP and sign in
  Future<void> verifyOtpAndSignIn(String phoneNumber, String otp) async {
    try {
      final response = await _client.auth.verifyOTP(
        phone: phoneNumber,
        token: otp,
        type: OtpType.sms,
      );

      // If the response contains an error, handle it
      if (response.session == null) {
      } else if (response.session != null) {
        print('User signed in successfully!');
        // You can access session or user details if necessary
        print('Access Token: ${response.session!.accessToken}');
      } else {
        print('Verification failed, no session found.');
      }
    } catch (e) {
      throw Exception('Failed to verify OTP and sign in: $e');
    }
  }

  Future<List<Product>> fetchData(String tableName) async {
    List<Product> productList;
    try {
      final client = Supabase.instance.client;

      // Construct the query to select all data from the specified table
      final response = await client.from(tableName).select();
      productList =
          (response as List).map((item) => Product.fromJson(item)).toList();
    } on PostgrestException catch (error) {
      throw Exception('Failed to fetch data: ${error.message}');
    }

    return productList;
  }
}
