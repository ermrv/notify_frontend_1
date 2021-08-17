import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

abstract class BackgroundTaskManager {
  static backgroundTaskManager(String task, var inputData) {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    switch (task) {
      case "uploadVideo":
        print("video is uploading");
        BackgroundTaskManager._uploadVideo(inputData);
        break;
      case "uploadImages":
        break;
      default:
    }
  }

  static _uploadVideo(var data) async {
    print("preparing upload");
    print(data);
    //create the request object
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(ApiUrlsData.addVideoPost),
    );

    //adding the headers
    request.headers["authorization"] =data["userToken"];
    request.headers["Content-type"] = "multipart/form-data";

    // adding body contents
    request.fields["aspectRatio"] = data["aspectRatio"];
    if (data["description"] != null) {
      request.fields["description"] = data["description"];
    }

    request.fields["postType"] = "video";
    // request.fields["location"] = location;

    //adding thumbnail file
    request.files.add(await http.MultipartFile.fromPath("postFile", data["postFile"],
        filename: data["filename"],
        contentType: MediaType("video", data["videoType"])));

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
  }
}
