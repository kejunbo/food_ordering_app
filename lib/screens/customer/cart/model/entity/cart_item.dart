import 'dart:convert';

import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';

class CartItem {
  final Food food;
  int quantity;

  CartItem({this.food, this.quantity});

  @override
  String toString() {
      return quantity.toString();
    }
}
