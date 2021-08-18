import 'package:get/get.dart';

class EstimatedBudgetPageController extends GetxController {
  String postId;

  int estimatedBudget = 500;
  int totalTargatedAudience = 500;
  int duration = 12;

  updateDuration(double value) {
    duration = value.toInt();
    totalTargatedAudience = 500 * duration;
    estimatedBudget = totalTargatedAudience;
    update();
  }
}
