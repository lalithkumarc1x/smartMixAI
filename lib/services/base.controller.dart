import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample/common/service/api_client.dart';
import 'package:sample/common/service/shared_prefs.dart';
import 'package:sample/models/response/category.dart';
import 'package:sample/models/response/drink.dart';
import 'package:sample/services/api_service.dart';
import 'package:sample/utils/overlay.dart';
import 'package:http/http.dart' as http;

class BaseController extends GetxController {
  final SharedPrefsService _sharedPrefs = Get.find<SharedPrefsService>();
  getUserProfile() {
    var image =
        _sharedPrefs.getString('profile_image') ?? 'https://placehold.co/400';
    return image;
  }

  getUserName() {
    return _sharedPrefs.getString('name') ?? '';
  }

  logout() {
    _sharedPrefs.clear();
  }

  Future<void> updateProfile(XFile image) async {
    final url = Uri.parse("${ApiClient.baseUrl}/update-profile");
    final request = http.MultipartRequest('POST', url);
    request.files
        .add(await http.MultipartFile.fromPath('profile_picture', image.path));
    request.headers.addAll(await ApiClient.getHeaders());

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await http.Response.fromStream(response);
      final data = jsonDecode(responseData.body);
      print(data);
      await _sharedPrefs.setString(
          'profile_image', "${ApiClient.baseUrl}/${data['profile_image']}");
      update(['image']);
      Get.snackbar(
        'Success',
        data['message'].toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      final responseData = await http.Response.fromStream(response);
      final error = jsonDecode(responseData.body);
      Get.snackbar(
        'Error',
        error['error'].toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
