import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/13_SearchEngineModule/controllers/SearchResultsDisplayPageController.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/ProfileReferenceTemplate.dart';
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
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color:
                              Theme.of(context).accentColor.withOpacity(0.8))),
                ),
                height: 25.0,
                width: screenWidth,
                child: Text(
                  searchedKeywords,
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                )),
          ),
          bottom: PreferredSize(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              controller.selectedSearchType == "people"
                                  ? MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey[800])
                                  : MaterialStateProperty.resolveWith(
                                      (states) => Colors.transparent)),
                      onPressed: () {
                        controller.updateSearchType("people");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.2,
                        child: Text("People"),
                      )),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              controller.selectedSearchType == "posts"
                                  ? MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey[800])
                                  : MaterialStateProperty.resolveWith(
                                      (states) => Colors.transparent)),
                      onPressed: () {
                         controller.updateSearchType("posts");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.2,
                        child: Text("Posts"),
                      )),
                  TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              controller.selectedSearchType == "tags"
                                  ? MaterialStateProperty.resolveWith(
                                      (states) => Colors.grey[800])
                                  : MaterialStateProperty.resolveWith(
                                      (states) => Colors.transparent)),
                      onPressed: () {
                         controller.updateSearchType("tags");
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: screenWidth * 0.2,
                        child: Text("Tags"),
                      ))
                ],
              ),
            ),
            preferredSize: Size.fromHeight(40.0),
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
                      for (var i in controller.searchResults)
                        Container(
                          child: ProfileReferenceTemplate(
                              showVerticalTemplate: false, userData: i),
                        ),
                    ],
                  ),
      ),
    );
  }
}

class TagsSearchResultsDisplayTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("tags"),
    );
  }
}
