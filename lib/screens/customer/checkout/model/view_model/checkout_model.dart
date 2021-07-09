import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_ordering_app/core/auth/view_model/auth_model.dart';
import 'package:food_ordering_app/screens/customer/cart/model/view_model/cart_model.dart';
import 'package:food_ordering_app/screens/customer/checkout/service/checkout_service.dart';

class CheckoutModel {
  final AuthModel authModel;
  final CartModel cartModel;

  CheckoutModel({this.authModel, this.cartModel});

  checkout(String address, String type) async {
    EasyLoading.show();
    bool success = await CheckoutService.checkout(
      cartModel.cartItemList,
      cartModel.getTotalPrice,
      address,
      type,
      authModel.user.id,
    );
    if (success) {
      cartModel.clear();
      EasyLoading.dismiss();
    } else {
      EasyLoading.showError("An error has occured, please try again");
    }
    return success;
  }
}
