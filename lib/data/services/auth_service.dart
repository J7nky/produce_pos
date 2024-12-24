import 'package:produce_pos/data/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Step 1: Send OTP to the user's phone number
  Future<void> sendOtpToPhone(String phoneNumber) async {
    try {
      await _client.auth.signInWithOtp(phone: phoneNumber);
    } on AuthApiException catch (e) {
      print('Failed to send OTP: $e');

      Exception('Error sending OTP:$e');
    } catch (e) {
      print('Failed to send OTP: $e');
      throw Exception('Failed to send OTP: $e');
    }
  }

  // Step 2: Verify OTP and sign in
  Future verifyOtpAndSignIn(String phoneNumber, String otp) async {
    try {
      final AuthResponse response = await _client.auth.verifyOTP(
        phone: phoneNumber,
        token: otp,
        type: OtpType.sms,
      );
    } on AuthException catch (e) {
      // Rethrow the AuthException to be caught by the caller
      throw e;
    } catch (e) {
      // Handle other exceptions if necessary
      throw e;
    }
  }

// Function to check if the user exists in the Auth table
  Future<bool> checkUserExistsInAuthTable(String phoneNumber) async {
    final response = await Supabase.instance.client
        .from('Auth') // Replace 'auth' with your actual table name
        .select('user_id')
        .eq('phone_number', phoneNumber)
        .maybeSingle();

    if (response != null) {
      return true;
    }

    // If data is null, user does not exist
    return false;
  }

  Future<bool> createAuthEntry(String userId, String phoneNumber) async {
    try {
      final response = await Supabase.instance.client.from('Auth').insert({
        'user_id': userId,
        'phone_number': phoneNumber,
      }).select();
    } catch (e) {
      print("Error creating auth entry: $e");
    }

    return true; // Successfully created
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
