import 'package:get/get.dart';
import 'package:sample/common/service/shared_prefs.dart';
import 'package:sample/models/response/category.dart';
import 'package:sample/models/response/drink.dart';
import 'package:sample/services/api_service.dart';
import 'package:sample/services/base.controller.dart';
import 'package:sample/utils/overlay.dart';

class HomeController extends BaseController {
  final _categories = <UiCategory>[].obs;
  List<UiCategory> get categories => _categories;

  final _drinks = <UiDrink>[].obs;
  List<UiDrink> get drinks => _drinks;


  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchDrinks();
  }


  Future<void> fetchCategories() async {
    // send sample data
    _categories.value = [
      CategoryResponse(name: 'MARGARITA', url: 'cat-1'),
      CategoryResponse(name: 'GIMLET', url: 'cat-2'),
      CategoryResponse(name: 'MANHATTAN', url: 'cat-3'),
    ].map((e) => e.toUIType()).toList();
    return;
    try {
      final response = await Get.find<ApiService>().getCategories();
      _categories.value = response.map((e) => e.toUIType()).toList();
    } catch (e) {
      print(e);
      Get.error('Categories', 'Error fetching categories');
    }
  }

  Future<void> fetchDrinks() async {
    // send sample data
    _drinks.value = [
      DrinkResponse(
        name: 'MARGARITA',
        id: '1',
        details: {'image': 'cat-1', 'description': 'cat-1'},
        category: '1',
        ingredients: [],
      ),
      DrinkResponse(
        name: 'MARGARITA 1',
        id: '1',
        details: {'image': 'cat-1', 'description': 'cat-1'},
        category: '1',
        ingredients: [],
      ),
      DrinkResponse(
        name: 'MARGARITA 2',
        id: '3',
        details: {'image': 'cat-1', 'description': 'cat-1'},
        category: '1',
        ingredients: [],
      ),
      DrinkResponse(
        name: 'MARGARITA 4',
        id: '3',
        details: {'image': 'cat-1', 'description': 'cat-1'},
        category: '1',
        ingredients: [],
      ),
    ].map((e) => e.toUIType()).toList();
    return;
    try {
      final response = await Get.find<ApiService>().getDrinks();
      _drinks.value = response.map((e) => e.toUIType()).toList();
    } catch (e) {
      print(e);
      Get.error('Categories', 'Error fetching categories');
    }
  }

  void addToFavorite(UiCategory category) {
    if (!_categories.contains(category)) {
      _categories.add(category);
    }
  }
}
