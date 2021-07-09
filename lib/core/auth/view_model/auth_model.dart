import 'dart:developer';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_ordering_app/core/auth/entity/user.dart';
import 'package:food_ordering_app/core/auth/service/auth_service.dart';
import 'package:food_ordering_app/core/common/view_model.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';

class AuthModel extends ViewModel {
  User user;
  bool isAdmin = false;

  login(String email, String password, {bool adminLogin = false}) async {
    EasyLoading.show();
    user = await AuthService.login(email, password, adminLogin);
    if (user == null) {
      EasyLoading.showError("Your email and password may be incorrect, please try again");
    } else {
      log("True");
      isAdmin = adminLogin;
      EasyLoading.dismiss();
      notifyListeners();
    }
  }

  set restaurant(Restaurant restaurant) {
    user.restaurant = restaurant;
    notifyListeners();
  }

  logout() {
    user = null;
    isAdmin = false;
    notifyListeners();
  }
}
