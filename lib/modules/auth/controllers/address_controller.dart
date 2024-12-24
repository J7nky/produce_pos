import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddressController extends GetxController {
  RxBool isLoading = RxBool(false);
  Future<void> updateUserLocation(String firstName, String lastName,
      String email, String dob, String address, double lat, double long) async {
    try {
      // Start loading state
      isLoading.value = true;

      // Get current user
      final user = Supabase.instance.client.auth.currentUser;

      // Check if user is null
      if (user == null) {
        print("Error: No user is logged in.");
        isLoading.value = false;
        return;
      }

      // Perform update
      final response = await Supabase.instance.client
          .from('Auth')
          .update({
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "dob": dob,
            "address": address,
            'latitude': lat,
            'longitude': long
          })
          .eq('user_id', user.id)
          .select(); // Ensure you add .execute() to perform the query
      Get.snackbar("Success", 'Information saved successfully');
      
    } catch (e) {
      print("Exception caught: $e");
    } finally {
      // End loading state
      isLoading.value = false;
    }
  }
}
