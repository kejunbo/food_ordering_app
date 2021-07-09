import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';

class OrderDetail {
  num orderId;
  Food food;
  num quantity;

  OrderDetail({this.orderId, this.food, this.quantity});

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    food = new Food.fromJson(json);
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    if (this.food != null) {
      data['food'] = this.food.toJson();
    }
    data['quantity'] = this.quantity;
    return data;
  }
}