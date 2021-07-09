import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_ordering_app/screens/customer/cart/model/view_model/cart_model.dart';
import 'package:food_ordering_app/util/router/router.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'constant/color.dart';
import 'core/auth/view_model/auth_model.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthModel>(create: (_) => AuthModel()),
        ChangeNotifierProvider<CartModel>(create: (_) => CartModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Ubuntu",
          primaryColor: CustomColor.dark_blue,
          appBarTheme: AppBarTheme(
            backgroundColor: CustomColor.dark_blue,
          ),
          scaffoldBackgroundColor: CustomColor.light_dark_blue
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        home: App(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
