import 'package:flutter/material.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/page/edit_food_screen.dart';
import 'package:food_ordering_app/screens/admin/shop/ui/page/shop_settings_screen.dart';
import 'package:food_ordering_app/screens/customer/account/ui/page/update_account_details_screen.dart';
import 'package:food_ordering_app/screens/customer/checkout/ui/page/checkout_screen.dart';
import 'package:food_ordering_app/screens/customer/forgot_password/ui/page/forgot_password_screen.dart';
import 'package:food_ordering_app/screens/customer/login/ui/page/login_screen.dart';
import 'package:food_ordering_app/screens/customer/register/ui/page/register_screen.dart';
import 'package:food_ordering_app/screens/customer/retaurant/ui/page/restaurant_screen.dart';
import 'package:food_ordering_app/screens/admin/order_detail/ui/page/order_detail_screen.dart';

class AppRouter {
  static final Function onGenerateRoute = (settings) {
    switch (settings?.name) {
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case ForgotPasswordScreen.routeName:
        final ForgotPasswordScreenArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen(args: args));
      case RestaurantScreen.routeName:
        final RestaurantScreenArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => RestaurantScreen(args: args));
      case CheckoutScreen.routeName:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      case UpdateAccountDetailsScreen.routeName:
        return MaterialPageRoute(builder: (_) => UpdateAccountDetailsScreen());
      case OrderDetailScreen.routeName:
        final OrderDetailScreenArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => OrderDetailScreen(args: args));
      case ShopSettingsScreen.routeName:
        final ShopSettingsScreenArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ShopSettingsScreen(args: args));
      case EditFoodScreen.routeName:
        final EditFoodScreenArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => EditFoodScreen(args: args));
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  };
}
