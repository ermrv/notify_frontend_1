import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/SpecificPostRelated/controllers/SpecificPostDisplayPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SpecificPostDisplayPageScreen extends StatelessWidget {
  final String postId;

  SpecificPostDisplayPageScreen({Key key, @required this.postId})
      : super(key: key);
  final controller = Get.put(SpecificPostDisplayPageController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecificPostDisplayPageController>(
        initState: (state) {
          print(postId);
          controller.specificPostId = postId;
          controller.initialise();
        },
        builder: (controller) => Scaffold(
              body: controller.specificPostData == null
                  ? Center(
                      heightFactor: 5.0,
                      child: SpinKitPulse(
                        color: Colors.blue,
                      ),
                    )
                  : ListView(
                      children: [
                        ContentDisplayTemplateProvider(
                            data: [controller.specificPostData],
                            controller: controller),
                        Container(
                          child:
                              Text(" shared contents will be displayed here"),
                        ),
                        controller.recommendedPostData == null
                            ? Container()
                            : controller.recommendedPostData.length == 0
                                ? Container()
                                : ContentDisplayTemplateProvider(
                                    data: controller.recommendedPostData,
                                    controller: controller)
                      ],
                    ),
            ));
  }
}
