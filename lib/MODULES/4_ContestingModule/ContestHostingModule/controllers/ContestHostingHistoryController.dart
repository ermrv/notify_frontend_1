import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ContestHostingHistoryController extends GetxController {
  List contestHostingHistoryData;

  @override
  void onInit() {
    getContestHostingHistoryData();
    super.onInit();
  }

  getContestHostingHistoryData() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.contestsOrganised, {}, userToken);
    if (response != "error") {
      contestHostingHistoryData = response;
      print(contestHostingHistoryData);
      update();
    } else {
      print("error in contest hositng hostory");
    }
  }
}
