import 'package:MediaPlus/APP_CONFIG/ApiUrlsData.dart';
import 'package:MediaPlus/MODULES/14_MainNavigationModule/views/MainNavigation.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/Models/PrimaryUserDataModel.dart';
import 'package:MediaPlus/MODULES/7_UserAuthModule/userAuthVariables.dart';
import 'package:MediaPlus/SERVICES_AND_UTILS/ApiServices.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentProcessPageController extends GetxController {
  var promotionDetailsBeforePayment;
  int price;
  Razorpay razorpay;

  bool retryOption = false;
  bool paymentDone = false;

  @override
  void onInit() {
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }

  @override
  void onReady() {
    paymentOrder();
    super.onReady();
  }

  //paymanet order
  paymentOrder() async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.promotionPaymentOrder,
        {"promotionId": promotionDetailsBeforePayment["promotion"]["_id"]},
        userToken);
    print(response);
    if (response != "error") {
      if (response['status'].toString() == "success") {
        openCheckout(response["paymentData"]["id"]);
      } else {
        retryOption = true;
        update();
      }
    }
  }

  ///verify the payment from the backend
  verifyPayment(String razorpayPaymentId, String razorpaySignature) async {
    var response = await ApiServices.postWithAuth(
        ApiUrlsData.promotionPaymentVerify,
        {
          "promotionId": promotionDetailsBeforePayment["promotion"]["_id"],
          "razorpayPaymentId": razorpayPaymentId,
          "razorpaySignature": razorpaySignature
        },
        userToken);

    print(response);
    if (response["status"] == "success") {
      Get.offAll(() => MainNavigationScreen(
            tabNumber: 4,
          ));
    } else {
      Get.snackbar("Some error occured", "Some error occured");
    }
  }

  ///open the razorpay payment gateway ui to process the payment
  void openCheckout(String orderId) async {
    var options = {
      'key': promotionDetailsBeforePayment["key"],
      'amount': price * 100,
      'name': 'Mediaplus',
      'description': 'Post Promotion',
      "order_id": orderId.toString(),
      'prefill': {
        'contact': PrimaryUserData.primaryUserData.mobile,
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("success", "message");
    retryOption = false;
    update();
    print("signature " + response.signature.toString());
    print("paymentId" + response.paymentId.toString());
    verifyPayment(response.paymentId.toString(), response.signature.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("error", "message");
    retryOption = true;
    update();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("external wallet", "message");
  }

  @override
  void onClose() {
    super.dispose();
    razorpay.clear();
    super.onClose();
  }
}
