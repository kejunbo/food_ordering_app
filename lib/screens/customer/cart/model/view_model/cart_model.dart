import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/core/common/view_model.dart';
import 'package:food_ordering_app/screens/customer/cart/model/entity/cart_item.dart';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';

class CartModel extends ViewModel {
  Restaurant restaurant;
  List<CartItem> cartItemList = [];

  addFood(Food food, BuildContext context) async {
    // if (_validateFoodFromSameRestaurant(food)) {
      int index = cartItemList.indexWhere((cartItem) => cartItem.food.id == food.id);
      if (index > -1) {
        cartItemList[index].quantity += 1;
      } else {
        if (cartItemList.isEmpty) {
          restaurant = food.restaurant;
        }
        cartItemList.add(new CartItem(food: food, quantity: 1));
      }
      // log("cartitemList => ${cartItemList}");
      notifyListeners();
    // } else {
    //   await showDialog<void>(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('Cart Clear Confirmation'),
    //         content: SingleChildScrollView(
    //           child: ListBody(
    //             children: <Widget>[
    //               Text('You already have other food in your cart from other restaurant, do you wish to clear the cart?'),
    //             ],
    //           ),
    //         ),
    //         actions: <Widget>[
    //           TextButton(
    //             child: Text('Cancel'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           ),
    //           TextButton(
    //             child: Text('Confirm'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //               this.clear();
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  removeFood(Food food, BuildContext context) {
    int index = cartItemList.indexWhere((cartItem) => cartItem.food.id == food.id);
    if (index > -1 && cartItemList[index].quantity > 0) {
      if (cartItemList[index].quantity == 1) {
        cartItemList.removeAt(index);
      } else {
        cartItemList[index].quantity -= 1;
      }
    }
    if (cartItemList.isEmpty) {
      restaurant = null;
    }
    // log("cartitemList => ${cartItemList}");
    notifyListeners();
  }

  int getFoodCountById(int foodId) {
    CartItem item = cartItemList.firstWhere((item) => item?.food?.id == foodId, orElse: () => null);
    return item?.quantity ?? 0;
  }

  bool _validateFoodFromSameRestaurant(Food food) {
    return restaurant != null ? food.restaurant == restaurant : true;
  }

  clear() {
    restaurant = null;
    cartItemList = [];
    notifyListeners();
  }

  int get getTotalQuantity => cartItemList.fold(0, (lastItem, item) => lastItem + item.quantity);
  double get getTotalPrice => cartItemList.fold(0, (lastItem, item) => lastItem + item.food.price * item.quantity);
}
