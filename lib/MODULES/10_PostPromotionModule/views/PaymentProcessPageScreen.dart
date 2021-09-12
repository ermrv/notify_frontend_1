import 'package:MediaPlus/MODULES/10_PostPromotionModule/controllers/PaymentProcessPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProcessPageScreen extends StatelessWidget {
  final promotionDetails;
  final int price;
  final _controller = Get.put(PaymentProcessPageController());
  PaymentProcessPageScreen(
      {Key key, @required this.promotionDetails, @required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentProcessPageController>(
      initState: (state) {
        _controller.promotionDetailsBeforePayment = promotionDetails;
        _controller.price = price;
      },
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Payment"),
        ),
        body:controller.paymentDone?Container(
          ///todo  implement paymen success
        ): Center(
          child: controller.retryOption
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Some error occured,please try again"),
                    TextButton(
                      onPressed: () {
                        controller.paymentOrder();
                      },
                      child: Text("Retry Payment"),
                    ),
                  ],
                )
              : Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitThreeBounce(
                        color: Colors.blue,
                        size: 18.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text("please wait.."),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
