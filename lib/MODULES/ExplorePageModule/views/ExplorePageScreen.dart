import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ContestPostReferenceLayout.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/EventPostReferenceLayout.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ImagePostReferenceLayout.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/ProfileReferenceLayout.dart';
import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/views/ReferenceRelatedViews/TagsReferenceLayout.dart';
import 'package:MediaPlus/MODULES/ExplorePageModule/controllers/ExplorePageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class ExplorePageScreen extends StatelessWidget {
  final explorePageController = Get.put(ExplorePageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExplorePageController>(
      builder: (controller) => Scaffold(
            appBar: AppBar(
      elevation: 1.0,
      backgroundColor: Theme.of(context).primaryColor,
      title: Container(
        alignment: Alignment.centerLeft,
        height: 45.0,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).accentColor.withOpacity(0.8),width: 0.1),
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "  Search for people,hashtags.......",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 5.0),
              child: Icon(Icons.search),
            )
          ],
        ),
      ),
            ),
            body: controller.data.length == 0
        ? Center(
            child: SpinKitPulse(
              color: Colors.blue,
            ),
          )
        : ListView(
          children: [
            TagsReferenceLayout(),
            ImagePostReferenceLayout(),
            ContestPostReferenceLayout(),
            EventPostReferenceLayout(),
            ProfileReferenceLayout(),
            ContentDisplayTemplateProvider(data: controller.data)
          ],
        )),
    );
  }
}
