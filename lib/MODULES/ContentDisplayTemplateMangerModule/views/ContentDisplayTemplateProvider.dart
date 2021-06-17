import 'package:MediaPlus/MODULES/ContentDisplayTemplateMangerModule/controllers/ContentDisplayTemplateManager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///all the content display templates is managed by this widget
///
///returns a column consisting of the related templates
///
///GIVEN list of data as input
///
///uses the postType key to find the corresponding template
class ContentDisplayTemplateProvider extends StatelessWidget {
  final List data;

  ContentDisplayTemplateProvider({Key key, @required this.data})
      : super(key: key);

  final ContentDisplayManager contentDisplayManager =
      Get.put(ContentDisplayManager());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentDisplayManager>(
        builder: (controller) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i in data) controller.getContentDisplayTemplate(i),
              ],
            ));
  }
}
