import 'package:get/get.dart';
import 'package:sample/services/score_service.dart';
import 'package:sample/utils/overlay.dart';

class NotificationController extends GetxController {
  final _notifications = <Map<String, String>>[].obs;
  List<Map<String, String>> get notifications => _notifications;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  getNotifications() {
    // populate some sample data with title message and time
    _notifications.add({
      'title': 'Your New Drink',
      'message': 'New drink arrived',
      'time': '10:30 AM'
    });
    _notifications.add({
      'title': 'Preference',
      'message': 'Shuffle your preference',
      'time': '10:30 AM'
    });
    _notifications.add({
      'title': 'Chat with Sundane',
      'message': 'Get Personalized preference',
      'time': '10:30 AM'
    });
    try {
      // _notifications.clear();
      // final response = await _service.getNotifications();
      // _notifications.addAll(response.data);
    } catch (e) {
      print(e);
      Get.error('Notification', 'Error fetching notifications');
    }
  }
}
