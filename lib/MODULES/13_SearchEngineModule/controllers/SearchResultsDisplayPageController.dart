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

  ///update search result type
  updateSearchType(String searchType) {
    selectedSearchType = searchType;
    update();

    ///TODO: call the function to update the body of the screen
  }

  updateSearchPage(String searchType) async {
    switch (searchType) {
      case "all":
        {}

        break;
      case "people":
        {
          if (peopleSearchResults == null) {
            await getData("user").then((value) {
              if (value["search-results"] != null) {
                try {
                  peopleSearchResults = value["search-results"];
                  searchResults = peopleSearchResults;
                  update();
                } catch (e) {
                  Get.snackbar("Something wrong", "cannot get the data");
                }
              } else {
                Get.snackbar("Something wrong", "cannot get the data");
              }
            });
          } else {
            searchResults = peopleSearchResults;
            update();
          }
        }

        break;
      case "posts":
        {
          if (postsSearchResults == null) {
            await getData("post").then((value) {
              if (value["search-results"] != null) {
                try {
                  postsSearchResults = value["search-results"];
                  searchResults = postsSearchResults;
                  update();
                } catch (e) {
                  Get.snackbar("Something wrong", "cannot get the data");
                }
              } else {
                Get.snackbar("Something wrong", "cannot get the data");
              }
            });
          } else {
            searchResults = postsSearchResults;
            update();
          }
        }

        break;
      case "tags":
        {
          if (tagsSearchResults == null) {
            await getData("hashtag").then((value) {
              if (value["search-results"] != null) {
                try {
                  tagsSearchResults = value["search-results"];
                  searchResults = tagsSearchResults;
                  update();
                } catch (e) {
                  Get.snackbar("Something wrong", "cannot get the data");
                }
              } else {
                Get.snackbar("Something wrong", "cannot get the data");
              }
            });
          } else {
            searchResults = tagsSearchResults;
            update();
          }
        }

        break;
      default:
        {
          if (peopleSearchResults == null) {
            await getData("user").then((value) {
              if (value["search-results"] != null) {
                try {
                  peopleSearchResults = value["search-results"];
                  searchResults = peopleSearchResults;
                  update();
                } catch (e) {}
              } else {
                Get.snackbar("Something wrong", "cannot get the data");
              }
            });
          } else {
            searchResults = peopleSearchResults;
            update();
          }
        }
    }
  }
}
