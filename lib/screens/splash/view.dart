
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/common/service/shared_prefs.dart';
import 'package:sample/screens/auths/login.dart';
import 'package:sample/screens/home/view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  SharedPrefsService sharedPrefsService = Get.find<SharedPrefsService>();

  @override
  void initState() {
    super.initState(); 
    if (sharedPrefsService.getString("token") != null) {
      Timer(Duration(seconds: 1), () {
        Get.offAndToNamed('/dashboard');
      });
    } else {
    Timer(Duration(seconds: 1), () {
      Get.offAndToNamed('/login');
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/bg.png",fit: BoxFit.fill,),
          Center(
            child: Image.asset("assets/logo.png"),  // Your logo/image
          ),
        ],
      ),
    );
  }
}
