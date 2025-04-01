import 'package:get/get.dart';
import 'package:sample/services/score_service.dart';
import 'package:sample/utils/overlay.dart';

class QuestionnaireController extends GetxController {
  final ScoreService _service = ScoreService();
  Future<void> saveScore(Map<int, int> scoreData) async {
    try {
      await _service.saveScore(scoreData);
      Get.success('Score', 'Score saved successfully');
      Get.toNamed('/dashboard');
    } catch (e) {
      print(e);
      Get.error('Score', 'Error saving');
    }
  }
}
