import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/common/service/shared_prefs.dart';
import 'package:sample/screens/auths/onboard.dart';
import 'package:sample/screens/auths/login.dart';
import 'package:sample/services/auth_service.dart';
import 'package:sample/utils/overlay.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userName = ''.obs;

  final AuthService _authService = AuthService();
  final SharedPrefsService _sharedPrefsService = Get.find<SharedPrefsService>();

  Future<void> register(
      String name, String password, String email, String phone) async {
    try {
      Map<String, dynamic> response =
          await _authService.signUp<Map<String, dynamic>>(
              name: name, email: email, phone: phone, password: password);
      // Print the entire response for debugging
      print('Response: $response');

      // Print the status value for debugging
      print('Status: ${response['status']}');

      // Check if the response contains the 'status' key and its value is 'success'
      if (response.containsKey('status') &&
          response['status']?.trim().toLowerCase() == 'success') {
        // Save the token to shared preferences
        await _sharedPrefsService.setString('token', response['token']);

        // Show success message and navigate to login screen
        Get.snackbar('Success', 'Registered successfully');
        Get.offAllNamed('/login');
      } else {
        // Show error message
        Get.snackbar('Error', response['message']);
      }
    } catch (e) {
      // Handle any exceptions that occur during the sign-up process
      print('Error during sign-up: $e');
      Get.snackbar('Error', 'An error occurred during sign-up');
    }
  }

  Future<void> login(String email, String password) async {
    try {
      Map<String, dynamic> response = await _authService
          .signIn<Map<String, dynamic>>(email: email, password: password);
      if (response['success'] == true) {
        await _sharedPrefsService.setString('token', response['token']);
        // Save user name to shared preferences 
        await _sharedPrefsService.setString('name', response['name']);
        // Save user email to shared preferences
        await _sharedPrefsService.setString('email', response['email']);
        // Save user profile image to shared preferences
        await _sharedPrefsService.setString(
            'profile_image', response['profile_image']);
        Get.to(OnBoardScreen());
      } else {
        Get.snackbar('Signin Failed', 'Invalid Credentials',
            backgroundColor: Colors.redAccent.shade100);
      }
    } catch (e) {
      print(e);
      Get.snackbar('Signin Failed', 'Invalid Credentials');
    }
  }
}
