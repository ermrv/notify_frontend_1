import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/13_SearchEngineModule/controllers/SearchResultsDisplayPageController.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceRelated/HorizontalProfileReferenceTemplate.dart';
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
                      for(var i in controller.searchResults)Container(
                        child:HorizontalProfileReferenceTemplate(userData:i),
                      ),
                    ],
                  ),
      ),
    );
  }


  
}


