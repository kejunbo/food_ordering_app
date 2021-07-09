import 'dart:convert';
import 'dart:developer';

import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class RestaurantService {
  static Future<List<Restaurant>> getAllRestaurants() async {
    var url = Uri.parse('$BASE_URL/getAllRestaurant.php');
    try {
      var response = await http.get(url);
      log("response -> ${response.body}");

      if (response?.body?.isNotEmpty ?? false) {
        var data = json.decode(response.body);
        if (data["success"] && data["data"] is List) {
          return (data["data"] as List).map((json) => Restaurant.fromJson(json)).toList();
        }
      }
    } on Exception catch (e) {
      log("Exception @ RestaurantService.getAllRestaurants -> $e");
    } catch (exp) {
      log("Exp caught @ RestaurantService.getAllRestaurants -> $exp");
    }
    return [];
  }
}
