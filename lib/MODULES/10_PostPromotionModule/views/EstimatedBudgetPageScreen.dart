import 'package:MediaPlus/APP_CONFIG/ScreenDimensions.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/controllers/EstimatedBudgetPageController.dart';
import 'package:MediaPlus/MODULES/10_PostPromotionModule/views/PromotedPostActionSelectorPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///entry point for the post promotion module
class EstimatedBudgetPageScreen extends StatelessWidget {
  final String postId;
  final _controller = Get.put(EstimatedBudgetPageController());
  EstimatedBudgetPageScreen({Key key, @required this.postId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EstimatedBudgetPageController>(
      initState: (state) {
        _controller.postId = postId;
      },
      builder: (controller) => Scaffold(
        bottomNavigationBar: Container(
          height: 40.0,
          child: TextButton(
            onPressed: () {
              Get.to(() => PromotedPostActionSelectorPage(
                  postId: controller.postId,
                  totalAudience: controller.totalTargatedAudience,
                  budget: controller.estimatedBudget,
                  duration: controller.duration));
            },
            child: Container(
                height: 40.0, alignment: Alignment.center, child: Text("Next")),
          ),
        ),
        appBar: AppBar(
          title: Text('Estimated Budget'),
        ),
        body: ListView(
          children: [
            //total targated audience
            //total estimated price container
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Text("Total Audience: ",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600)),
                  Text(
                    controller.totalTargatedAudience.toString(),
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            //total estimated price container
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Row(
                children: [
                  Text("Budget: ",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600)),
                  Text(
                    "Rs. " + controller.estimatedBudget.toString(),
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              height: 1.0,
              width: screenWidth,
              color: Theme.of(context).accentColor.withOpacity(0.6),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              height: 15.0,
              child: Text(
                "Filters:",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.0),
              ),
            ),
            //duration
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(
                          'Duration: ',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Text(controller.duration.toString() + " Hrs",
                            style: TextStyle(fontSize: 15.0))
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: Slider(
                value: controller.duration.toDouble(),
                onChanged: (value) {
                  controller.updateDuration(value);
                },
                min: 12.0,
                max: 240.0,
                divisions: 19,
              ),
            )
          ],
        ),
      ),
    );
  }
}
