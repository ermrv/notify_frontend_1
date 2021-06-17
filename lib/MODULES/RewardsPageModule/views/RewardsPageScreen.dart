import 'dart:ui';

import 'package:flutter/material.dart';

class RewardaPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        children: [
          Card(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            elevation: 1.0,
            child: Container(
              color: Theme.of(context).backgroundColor,
              padding: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              height: 170.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).accentColor)),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 32.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Diamonds",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).accentColor)),
                          child: Center(
                            child: Text(
                              "3000",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 32.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Coins",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: Theme.of(context).accentColor)),
                          child: Center(
                            child: Text(
                              "16",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 32.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Coupons",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16.0),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 35.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Get More Coins"), Text(">>>")],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 35.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Redeem Coupons"), Text(">>>")],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 35.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Redeem Coins"), Text(">>>")],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
            child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 35.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Redeem Diamonds"), Text(">>>")],
                  ),
                )),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            height: 250.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text("How to earn Rewards??"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  height: 200.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (var i = 0; i < 11; i++)
                        Container(
                          margin: EdgeInsets.all(5.0),
                          height: 200.0,
                          width: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.2))),
                        )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
        elevation: 0.5,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(right: 8.0),
                    height: 35.0,
                    width: 35.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: Image.asset(
                        "assets/person.jpg",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Text(
                  "  Rewards",
                  style: TextStyle(),
                ),
              ],
            ),
            Container()
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: IconButton(
                icon: Icon(
                  Icons.history,
                ),
                onPressed: () {
                  print("sdfsdf");
                }),
          )
        ],
      );
}
