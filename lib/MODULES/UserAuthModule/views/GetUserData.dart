import 'package:MediaPlus/MODULES/UserAuthModule/controllers/GetUserDataController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class GetUserData extends StatelessWidget {
  final getUserDataController = Get.put(GetUserDataController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetUserDataController>(
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
            child: SpinKitThreeBounce(
          color: Colors.blue,
          size: 22.0,
        )),
      ),
    );
  }
}
