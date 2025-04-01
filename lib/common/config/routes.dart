import 'package:sample/screens/auth/chat.dart';
import 'package:sample/screens/auths/profile.dart';
import 'package:sample/screens/dashboard.dart';
import 'package:sample/screens/detail/controller.dart';
import 'package:sample/screens/favorite/controller.dart';
import 'package:sample/screens/favorite/view.dart';
import 'package:sample/screens/ingredients/view.dart';
import 'package:sample/screens/detail/view.dart';
import 'package:sample/screens/auths/onboard.dart';
import 'package:sample/screens/home/controller.dart';
import 'package:sample/screens/notification/controller.dart';
import 'package:sample/screens/notification/notification.dart';
import 'package:sample/screens/questionnare/controller.dart';
import 'package:sample/screens/questionnare/questionnare.dart';
import 'package:sample/screens/auth/suggestion.dart';
import 'package:sample/screens/auth/user_profile.dart';
import 'package:sample/screens/auths/auth.controller.dart';
import 'package:sample/screens/auths/login.dart';
import 'package:sample/screens/auths/register.dart';
import 'package:sample/screens/home/view.dart';
import 'package:sample/screens/splash/view.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(name: '/splash', page: () => SplashScreen()),
  GetPage(name: '/dashboard', page: () => Dashboard()),
  GetPage(name: '/login', page: () => LoginScreen(), bindings: [
    BindingsBuilder(() {
      Get.lazyPut<AuthController>(() => AuthController());
    })
  ]),
  GetPage(name: '/register', page: () => RegisterScreen(), bindings: [
    BindingsBuilder(() {
      Get.lazyPut<AuthController>(() => AuthController());
    })
  ]),
  GetPage(name: '/onboard', page: () => OnBoardScreen()),
  GetPage(
      name: '/taste_preference',
      page: () => TastePreferenceScreen(),
      bindings: [
        BindingsBuilder(() {
          Get.lazyPut<QuestionnaireController>(() => QuestionnaireController());
        })
      ]),
  GetPage(name: '/home', page: () => HomePage(), bindings: [
    BindingsBuilder(() {
      Get.put<HomeController>(HomeController());
    })
  ]),
  GetPage(name: '/preference', page: () => UserProfileScreen()),
  GetPage(name: '/profile', page: () => ProfileScreen()),
  GetPage(name: '/notification', page: () => NotificationScreen(), bindings: [
    BindingsBuilder(() {
      Get.put<NotificationController>(NotificationController());
    })
  ]),
  GetPage(name: '/favorites', page: () => FavoritesScreen(), bindings: [
    BindingsBuilder(() {
      Get.put<FavoriteController>(FavoriteController());
    })
  ]),
  GetPage(name: '/ingredients', page: () => IngredientsScreen()),
  GetPage(name: '/suggestion', page: () => SuggestionScreen()),
  GetPage(name: '/chat', page: () => ChatScreen()),
  GetPage(
      name: '/detail',
      page: () => DrinkDetailScreen(
          id: Get.arguments['id'] ?? 'defaultId',
          name: Get.arguments['name'] ?? 'defaultName'),
      bindings: [
        BindingsBuilder(() {
          Get.put<DrinkDetailController>(DrinkDetailController());
        })
      ]),
];
