import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/13_SearchEngineModule/controllers/SearchResultsDisplayPageController.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/controllers/ContentDisplayTemplateManager.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SearchResultsDisplayPageScreen extends StatelessWidget {
  final String searchedKeywords;

  SearchResultsDisplayPageScreen({Key key, this.searchedKeywords})
      : super(key: key);

  final _controller = Get.put(SearchResultsDisplayPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchResultsDisplayPageController>(
      initState: (state) {
        _controller.searchKeywords = searchedKeywords;
        _controller.intialise();
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              print("object");
              Get.back();
            },
            child: Container(
              height: 40.0,
              width: screenWidth,
              child: TextFormField(
                initialValue: searchedKeywords,
                readOnly: true,
              ),
            ),
          ),
        ),
        body: controller.searchResults == null
            ? Center(
                child: SpinKitPulse(
                color: Colors.blue,
              ))
            : controller.searchResults.length == 0
                ? Center(
                    child: Center(
                      child: Text("No results found"),
                    ),
                  )
                : ListView(
                    children: [
                      ContentDisplayTemplateProvider(
                        data: controller.searchResults,
                      )
                    ],
                  ),
      ),
    );
  }
}
