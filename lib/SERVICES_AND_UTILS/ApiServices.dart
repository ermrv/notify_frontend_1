import 'dart:convert';
import 'dart:io';

import 'package:MediaPlus/MODULES/7_UserAuthModule/views/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class ApiServices {
  //get request
  static get(String url) async {
    try {
      var response = await http.get(url);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginScreen());
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //post request
  static post(String url, var body) async {
    var dataToSend = json.encode(body);
    try {
      var response = await http.post(url,
          body: dataToSend, headers: {"content-type": "application/json"});
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginScreen());
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

  //post request with auth
  static postWithAuth(String url, var body, String token) async {
    var dataToSend = json.encode(body);
    try {
      var response = await http.post(url, body: dataToSend, headers: {
        "content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + token
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        Get.offAll(() => LoginScreen());
      } else {
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }
}
