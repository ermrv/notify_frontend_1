import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';

class SearchResultsDisplayPageController extends GetxController {
  String searchKeywords;
  List searchResults;

  intialise() async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.search,
        {"query": searchKeywords, "type": "post"}, userToken);

    if (response != "error") {
      print(response);
      searchResults = response["search-results"];
      update();
    }
  }
}
