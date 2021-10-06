import 'package:MediaPlus/MODULES/8_UserProfileModule/ProfileCommonModules/controllers/UserFollowingsListPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

/// stlful widget--Listview which contains all the list of Followings
class UserFollowingsListPageScreen extends StatelessWidget {
  final String userId;

  UserFollowingsListPageScreen({Key key, @required this.userId})
      : super(key: key);

  final controller = Get.put(UserFollowingsListPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserFollowingsListPageController>(
      initState: (state) {
        controller.profileId = userId;
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          title: Text(
            "Followings",
          ),
        ),
        body: controller.requestProcessed
            ? controller.data.length == 0
                ? Center(
                    child: Text("No Followings!"),
                  )
                : ListView.builder(
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 25.0,
                          ),
                          title: Text("Name of User"),
                          subtitle: Text("userName"),
                          trailing: controller
                              .getFollowButton(controller.data[index]["_id"]),
                        ),
                      );
                    },
                  )
            : Center(
                child: SpinKitThreeBounce(
                  size: 22.0,
                  color: Colors.blue,
                ),
              ),
      ),
    );
  }
}
