import 'package:sample/models/response/category.dart';
import 'package:sample/common/service/api_client.dart';
import 'package:sample/models/response/drink.dart';
import 'package:sample/models/response/drink_detail.dart';
import 'package:sample/models/response/favorite.dart';
 
class ApiService extends ApiClient {
  Future<List<CategoryResponse>> getCategories() async => await getRequest('getcategories');
  Future<List<DrinkResponse>> getDrinks() async =>
      await getRequest('getdrinks');
  Future<Map<String, dynamic>> getProfile() async => await getRequest('getprofile');
  Future<Map<String, dynamic>> getSuggestions() async => await getRequest('getsuggestions');
  Future<List<dynamic>> getScore() async => await getRequest('getscore');
  Future<DrinkDetailResponse> getProduct(String productId) async =>
      await getRequest('getproduct/$productId');
  Future<List<dynamic>> getIngredients() async => await getRequest('getingredients');
  Future<List<FavoriteResponse>> getFavorites() async =>
      await getRequest('getfavorites');
  Future<List<dynamic>> getHistories() async => await getRequest('gethistories');
  
  Future<String> getResponse(String query, String token) async {
    final response = await postRequest('getresponse', {'query': query});
    return response['response'];
  }
}
