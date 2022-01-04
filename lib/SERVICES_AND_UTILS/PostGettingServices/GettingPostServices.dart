import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/LocalDataFiles.dart';
import 'package:get/get.dart';

class GettingPostServices {
  ///get the recent post
  // static Future<List> getRecentPostsData(
  //     List initialData, String apiUrl) async {
  //   List _finalData;
  //   _finalData = initialData;
  //   var response;
  //   //if newsfeed data is null get all data from back end
  //   if (initialData == null || LocalDataFiles.refreshNewsFeedFile) {
  //     response = await ApiServices.postWithAuth(
  //         apiUrl, {"dataType": "latest"}, userToken);
  //   }
  //   //if list is empty get all data from backend
  //   else if (initialData.length == 0) {
  //     response = await ApiServices.postWithAuth(
  //         ApiUrlsData.newsFeedUrl, {"dataType": "latest"}, userToken);
  //   }
  //   //if newsfeed data is available, get only those data that is  recent
  //   else if (initialData.length >= 1) {
  //     String _firstPostId = getFirstPostId(initialData);
  //     response = await ApiServices.postWithAuth(ApiUrlsData.newsFeedUrl,
  //         {"dataType": "latest", "postId": _firstPostId}, userToken);
  //   }

  //   if (response != "error") {
  //     if (_finalData == null || LocalDataFiles.refreshNewsFeedFile) {
  //       _finalData = response;
  //       LocalDataFiles.setRefreshNewsFeedFile(false);
  //     } else {
  //       List _temp = response;
  //       _temp.addAll(initialData);
  //       _finalData.clear();
  //       _finalData.addAll(_temp);
  //       // update();
  //       // _handleLocalFile(newsFeedData);
  //     }
  //   } else {
  //     Get.snackbar("Cannot get the data", "some error occured");
  //   }

  //   return _finalData;
  // }

  ///to get the first post id from the [data]
  ///eturns the last post id if present or returns [null] if not present
  static String getFirstPostId(List data) {
    String _firstPostId;
    var length = data.length;
    if (length != 0) {
      try {
        var _lastPost = data.firstWhere((element) => element["_id"] != null);
        _firstPostId = _lastPost["_id"];
      } catch (e) {
        _firstPostId = null;
      }
    } else {
      _firstPostId = null;
    }

    return _firstPostId;
  }

  ///to get the last post id from the [data]
  ///returns the last post id if present or returns [null] if not present
  static String getLastPostId(List data) {
    String _lastPostId;
    var length = data.length;
    if (length != 0) {
      try {
        var _lastPost = data.lastWhere((element) => element["_id"] != null);
        _lastPostId = _lastPost["_id"];
      } catch (e) {
        _lastPostId = null;
      }
    } else {
      _lastPostId = null;
    }

    return _lastPostId;
  }
}
