import 'package:MediaPlus/MODULES/13_SearchEngineModule/views/SearchResultsDisplayPageScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchInputPageController extends GetxController {
  TextEditingController textEditingController;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    super.onInit();
  }

  search() {
    if (textEditingController.text != "") {
      Get.to(() => SearchResultsDisplayPageScreen(
            searchedKeywords:textEditingController.text,
          ));
    } else {
      Get.snackbar("Ented serch query", "Enter search query");
    }
  }
 
}
