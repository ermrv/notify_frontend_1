import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';

class SearchResultsDisplayPageController extends GetxController {
  String searchKeywords;
  String selectedSearchType = "people";

  //api response..........
  List searchResults;
  List peopleSearchResults;
  List postsSearchResults;
  List tagsSearchResults;

  intialise() async {
    updateSearchPage(selectedSearchType);
  }

  Future<dynamic> getData(String searchType) async {
    var response = await ApiServices.postWithAuth(ApiUrlsData.search,
        {"query": searchKeywords, "type": searchType}, userToken);

    if (response != "error") {
      print(response);
      return response;
    }
  }

  updateSearchPage(String searchType) async {
    switch (searchType) {
      case "all":
        {}

        break;
      case "people":
        {
          if (peopleSearchResults == null) {
            var _temp = await getData("people");
            peopleSearchResults = _temp["users"];
            searchResults = peopleSearchResults;
            update();
          } else {
            searchResults = peopleSearchResults;
            update();
          }
        }

        break;
      case "posts":
        {
          if (postsSearchResults == null) {
            var _temp = await getData("posts");
            postsSearchResults = _temp["posts"];
            searchResults = postsSearchResults;
            update();
          } else {
            searchResults = postsSearchResults;
            update();
          }
        }

        break;
      case "tags":
        {
          if (tagsSearchResults == null) {
            var _temp = await getData("tags");
            tagsSearchResults = _temp["tags"];
            searchResults = tagsSearchResults;
            update();
          } else {
            searchResults = tagsSearchResults;
            update();
          }
        }

        break;
      default:
        {
          if (peopleSearchResults == null) {
            var _temp = await getData("people");
            peopleSearchResults = _temp["users"];
            searchResults = peopleSearchResults;
            update();
          } else {
            searchResults = peopleSearchResults;
            update();
          }
        }
    }
  }

}
