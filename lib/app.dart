import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/admin/admin_home.dart';
import 'package:food_ordering_app/screens/customer/customer_home.dart';
import 'package:food_ordering_app/screens/customer/login/ui/page/login_screen.dart';
import 'package:provider/provider.dart';

import 'core/auth/view_model/auth_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthModel>(
      builder: (context, authModel, child) {
        log("authModel?.user == null => ${authModel?.user == null}");
        return authModel?.user == null
            ? LoginScreen()
            : authModel.isAdmin
                ? AdminHome()
                : CustomerHome();
      },
    );
  }
}