import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/controllers/CommonPostDisplayPageController.dart';
import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/DataLoadingShimmerAnimations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class CommonPostDisplayPageScreen extends StatelessWidget {
  final String title;
  final String apiUrl;
  final Map<String, dynamic> apiData;

  CommonPostDisplayPageScreen(
      {Key key, this.title, @required this.apiUrl, @required this.apiData})
      : super(key: key);
//   @override
//   _CommonPostDisplayPageScreenState createState() =>
//       _CommonPostDisplayPageScreenState();
// }

// class _CommonPostDisplayPageScreenState
//     extends State<CommonPostDisplayPageScreen> {
//   List data;
//   String title = "Posts";
//   @override
//   void initState() {
//     _getData();
//     if (widget.title != null) {
//       title = widget.title;
//     }
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    try {
       Get.delete<CommonPostDisplayPageController>();
    } catch (e) {
      print(e);
    }
    final controller = Get.put(CommonPostDisplayPageController());
    return GetBuilder<CommonPostDisplayPageController>(
      initState: (state) {
        controller.apiUrl = apiUrl;
        controller.apiData = apiData;
        if (title != null) {
          controller.title = title;
        }
        controller.initilialise();
      },
      dispose: (state) {
        controller.data = null;
        controller.apiUrl = null;
        controller.apiData = null;
        controller.title = null;
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: controller.data == null
            ? DataLoadingShimmerAnimations(animationType: "postOnly")
            : controller.data.length == 0
                ? Center(
                    child: Text("No post yet!!"),
                  )
                : ListView(
                    controller: controller.scrollController,
                    children: [
                      ContentDisplayTemplateProvider(
                        data: controller.data,
                        controller: controller,
                        useTemplatesAsPostFullDetails: false,
                      ),
                      controller.loadingMoreData
                          ? Container(
                              height: 30.0,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.blue,
                              )),
                            )
                          : Container(
                              height: 30.0,
                            ),
                    ],
                  ),
      ),
    );
  }
}
