import 'package:MediaPlus/MODULES/HomePageModule/UserDrawerModule/views/UserDrawerScreen.dart';
import 'package:MediaPlus/MODULES/HomePageModule/views/NewsFeedPageScreen.dart';
import 'package:MediaPlus/MODULES/MainNavigationModule/controllers/MainNavigationController.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/KeepWidgetAliveModule/KeepWidgetAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
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
  FSBStatus fsbStatus = FSBStatus.FSB_CLOSE;
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
    return FoldableSidebarBuilder(
      status: fsbStatus,
      drawer: UserDrawerScreen(),
      screenContents: Scaffold(
        
          // onDrawerChanged: (isOpened) {
          //   if (isOpened) {
          //     mainNavigationController.hide();
          //   }
          //   if (!isOpened) {
          //     mainNavigationController.show();
          //   }
          // },
          // key: _drawerKey,
          // drawer: Drawer(
          //   child: UserDrawerScreen(),
          // ),
          appBar: AppBar(
            centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            // _drawerKey.currentState.openDrawer();
            if (fsbStatus == FSBStatus.FSB_CLOSE) {
              fsbStatus = FSBStatus.FSB_OPEN;
              mainNavigationController.hide();
              setState(() {});
            } else {
              if (fsbStatus == FSBStatus.FSB_OPEN) {
                fsbStatus = FSBStatus.FSB_CLOSE;
                mainNavigationController.show();
                setState(() {});
              }
            }
          },
          // child: Stack(
          //   children: [
          //     Container(
          //       height: 35.0,
          //       width: 35.0,
          //       decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.grey),
          //       child: ClipRRect(
          //         borderRadius:
          //             BorderRadius.circular(30.0),
          //         child: PrimaryUserData.primaryUserData
          //                     .profilePic ==
          //                 null
          //             ? Image.asset("assets/person.jpg",
          //                 fit: BoxFit.fill)
          //             : CachedNetworkImage(
          //                 imageUrl: PrimaryUserData
          //                     .primaryUserData.profilePic
          //                     .toString(),
          //                 fit: BoxFit.fill,
          //               ),
          //       ),
          //     ),
          //     Positioned(
          //         bottom: 1.0,
          //         right: 0.0,
          //         child: Container(
          //           padding: EdgeInsets.all(1.0),
          //           // height: 15.0,
          //           // width: 15.0,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               shape: BoxShape.circle),
          //           child: Icon(
          //             Icons.menu,
          //             color: Colors.blue,
          //             size: 11.0,
          //           ),
          //         ))
          //   ],
          child: fsbStatus == FSBStatus.FSB_CLOSE
              ? Icon(Entypo.grid)
              : Icon(Icons.close),
        ),
        title: Text("mediaPlus",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(icon: Icon(Feather.search,size: 22.0,), onPressed:(){}),
          Container(width: 3.0,)
        ],
      ),
      body:KeepWidgetAliveWrapper(child: NewsFeedPageScreen()),),
      
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
