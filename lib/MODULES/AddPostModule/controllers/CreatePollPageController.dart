import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/AddPostModule/views/PollPagePreviewScreen.dart';
import 'package:MediaPlus/MODULES/UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CreatePollPageController extends GetxController {
  bool isUploading = false;
  String title;
  String pollEndDate;
  List<String> options = ["", "", "", "", ""];
  TextEditingController titleController,
      option1Controller,
      option2Controller,
      option3Controller,
      option4Controller,
      pollEndDateController;

  @override
  void onInit() {
    titleController = TextEditingController();
    option1Controller = TextEditingController();
    option2Controller = TextEditingController();
    option3Controller = TextEditingController();
    option4Controller = TextEditingController();
    pollEndDateController = TextEditingController();

    super.onInit();
  }

  handlePreview() {
    title = titleController.text;
    if (option1Controller.text != "") options[0] = (option1Controller.text);
    if (option2Controller.text != "") options[1] = (option2Controller.text);
    if (option3Controller.text != "") options[2] = (option3Controller.text);
    if (option4Controller.text != "") options[3] = (option4Controller.text);
    print(options);
    if (title == "" && pollEndDate != null) {
      Get.snackbar("title", "message");
    } else if (option1Controller.text == "" || option2Controller.text == "") {
      Get.snackbar("title", "message");
    } else {
      Get.to(() => PollPagePreviewScreen());
    }
  }

  //post poll post
  uploadPollPost() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.addPollPost,
        {
          "description": titleController.text,
          "opOne": option1Controller.text,
          "opTwo": option2Controller.text,
          "opThree": option3Controller.text,
          "opFour": option4Controller.text,
          "endsOn": pollEndDate
        },
        userToken);

    if (response != "error") {
      isUploading = false;
      Get.snackbar("Uploaded", "Task Completed");
      update();
      // Get.to(() => UserProfileScreen());
    } else {
      isUploading = false;
      Get.snackbar("Error", "Error occured");
      update();
    }
  }
}
