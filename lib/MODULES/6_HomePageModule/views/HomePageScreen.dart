import 'package:MediaPlus/MODULES/13_SearchEngineModule/views/SearchInputPageScreen.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/UserDrawerModule/views/UserDrawerScreen.dart';
import 'package:MediaPlus/MODULES/6_HomePageModule/views/NewsFeedPageScreen.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/controllers/MainNavigationController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/DataLoadingShimmerAnimations.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/KeepWidgetAliveModule/KeepWidgetAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';

//widget with [AutomaticKeepAliveClientMixin] having the tabbar view with
///[NewsFeedScreen],[VideoPageScreen],[NearYouPageScreen],[ContestPageScreen],
///[_HomeScreenState._appBarHeightHandler] to handle appbar height

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  AnimationController _animationController;
  // Animation<double> _animation;
  // GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final mainNavigationController = Get.find<MainNavigationController>();

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    // _animation =
    //     Tween<double>(begin: 100.0, end: 48.0).animate(_animationController);
    _animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Entypo.grid),
          onPressed: () {
            Get.to(() => UserDrawerScreen(),transition: Transition.leftToRightWithFade);
          },
        ),
        title: Text(
          "notify",
          style: TextStyle(
              fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Feather.search,
                size: 22.0,
              ),
              onPressed: () {
                Get.to(() => SearchInputPageScreen());
              }),
              IconButton(onPressed:(){
                Get.to(()=>DataLoadingShimmerAnimations(animationType: "post",));
              }, icon: Icon(Icons.color_lens)),
          Container(
            width: 3.0,
          )
        ],
      ),
      body: NewsFeedPageScreen(),
    );
  }

  // TabBar _tabBar = TabBar(
  //     indicatorSize: TabBarIndicatorSize.label,
  //     indicatorPadding: EdgeInsets.zero,
  //     tabs: [
  //       Tab(
  //         icon: Icon(Icons.rss_feed),
  //       ),
  //       Tab(
  //         icon: Icon(Icons.ondemand_video_sharp),
  //       ),
  //       Tab(
  //         icon: Icon(Icons.location_on),
  //       ),
  //       Tab(
  //         icon: Icon(Icons.emoji_events),
  //       )
  //     ]);
}
