import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/common/config/routes.dart';
import 'package:sample/common/service/shared_prefs.dart';
import 'package:sample/screens/auth/chat.dart';
import 'package:sample/screens/favorite/view.dart';
import 'package:sample/screens/ingredients/view.dart';
import 'package:sample/screens/auths/login.dart';
import 'package:sample/screens/detail/view.dart';
import 'package:sample/screens/auths/onboard.dart';
import 'package:sample/screens/home/controller.dart';
import 'package:sample/screens/questionnare/questionnare.dart';
import 'package:sample/screens/auths/register.dart';
import 'package:sample/screens/auth/suggestion.dart';
import 'package:sample/screens/auth/user_profile.dart';
import 'package:sample/screens/home/view.dart';
import 'package:sample/screens/splash/view.dart';
import 'package:sample/services/api_service.dart';
import 'package:sample/services/base.controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SharedPrefsService().init(), permanent: true);
  Get.put(SharedPrefsService(), permanent: true);
  Get.put(BaseController(), permanent: true);
  Get.put(HomeController());
  Get.put(ApiService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: routes,
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  var screens = [
    SplashScreen(),
    LoginScreen(),
    RegisterScreen(),
    OnBoardScreen(),
    TastePreferenceScreen(),
    HomePage(),
    UserProfileScreen(),
    FavoritesScreen(),
    IngredientsScreen(),
    SuggestionScreen(),
    DrinkDetailScreen(id: '1', name: 'Margarita'),
    ChatScreen()
  ];
  var index = 0;
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        index = (index + 1) % screens.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return screens[index];
  }
}
