import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';

class User {
  num id;
  String name;
  String email;
  Restaurant restaurant;

  User({this.id, this.name, this.email, this.restaurant});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    restaurant = json['restaurant'] != null ? Restaurant.fromJson(json['restaurant']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant.toJson();
    }
    return data;
  }
}
