import 'package:MediaPlus/MODULES/3_ContentDisplayTemplateMangerModule/views/ContentDisplayTemplateProvider.dart';
import 'package:MediaPlus/MODULES/4_ContestingModule/ContestHostingModule/controllers/ContestParticipantsPostScreenController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

///display all the contestpost related to the specific contestId
///uses [FullPostTemplate] from [ContentDisplayManagerModule]
class ContestParticipantsPostScreen extends StatelessWidget {
  final String contestId;
  final String contestName;
  final controller = Get.put(ContestParticipantsPostScreenController());

  ContestParticipantsPostScreen(
      {Key key, @required this.contestId, @required this.contestName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContestParticipantsPostScreenController>(
      initState: (state) {
        controller.contestId = contestId;
        controller.getData();
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text(contestName),
          ),
          body: controller.contestPosts == null
              ? Center(
                  child: SpinKitPulse(
                    color: Colors.blue,
                  ),
                )
              : controller.contestPosts.length == 0
                  ? Center(
                      child: Text("nothing is posted now"),
                    )
                  : ListView(
                      children: [
                        ContentDisplayTemplateProvider(
                            data: controller.contestPosts,controller: controller,)
                      ],
                    ),
        );
      },
    );
  }
}
