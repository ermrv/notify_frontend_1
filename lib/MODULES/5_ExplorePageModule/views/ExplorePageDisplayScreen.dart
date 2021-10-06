import 'package:MediaPlus/MODULES/5_ExplorePageModule/views/ExplorePageScreen.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/KeepWidgetAliveModule/KeepWidgetAliveWrapper.dart';
import 'package:flutter/material.dart';

class ExplorePageDisplayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: KeepWidgetAliveWrapper(child: ExplorePageScreen()),
    );
  }
}
