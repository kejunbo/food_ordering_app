import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';

class Food {
  num id;
  String name;
  num price;
  String description;
  String imageUrl;
  Restaurant restaurant;

  Food({this.id, this.name, this.price, this.description, this.imageUrl, this.restaurant});

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    restaurant = Restaurant.fromJson(json['restaurant'] ?? {});
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    data['imageUrl'] = this.imageUrl;
    data['restaurant'] = this.restaurant.toJson();
    return data;
  }
}
