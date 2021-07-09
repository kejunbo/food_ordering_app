import 'dart:convert';
import 'dart:developer';
import 'package:food_ordering_app/screens/customer/retaurant/model/entity/food.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class FoodService {
  static Future<List<Food>> getAllFoodByRestaurantId(num id) async {
    var url = Uri.parse('$BASE_URL/getFoodByRestaurantId.php');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"restaurantId": id}),
      );
      // log("Response => ${response.body}");
      if (response?.body?.isNotEmpty ?? false) {
        var data = json.decode(response.body);
        if (data is List && (data?.isNotEmpty ?? false)) {
          return data.map((json) => Food.fromJson(json)).toList();
        }
      }
    } on Exception catch (e) {
      log("Exception @ FoodService.getAllFoodByRestaurantId -> $e");
    } catch (exp) {
      log("Exp caught @ FoodService.getAllFoodByRestaurantId -> $exp");
    }
    return [];
  }

  static Future deleteFood(num foodId) async {
    try {
      var url = Uri.parse('$BASE_URL/deleteFood.php');
      var body = jsonEncode({"food_id": foodId});
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      log("Body => $body");
      log("Response => ${response.body}");
      if (response?.body?.isNotEmpty ?? false) {
        var data = json.decode(response.body);
        return data["success"];
      }
    } on Exception catch (e) {
      log("Exception @ FoodService.deleteFood -> $e");
    } catch (exp) {
      log("Exp caught @ FoodService.deleteFood -> $exp");
    }
    return false;
  }

  static Future updateFood(Food food) async {
    try {
      var url = Uri.parse('$BASE_URL/updateFood.php');
      var body = jsonEncode({
        "food_id": food.id,
        "name": food.name,
        "description": food.description ?? "-",
        "imageUrl": food.imageUrl,
        "price": food.price,
      });
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      log("Body => $body");
      log("Response => ${response.body}");
      if (response?.body?.isNotEmpty ?? false) {
        var data = json.decode(response.body);
        return data["success"];
      }
    } on Exception catch (e) {
      log("Exception @ FoodService.updateFood -> $e");
    } catch (exp) {
      log("Exp caught @ FoodService.updateFood -> $exp");
    }
    return false;
  }

  static Future addFood(Food food, num restaurantId) async {
    try {
      var url = Uri.parse('$BASE_URL/createFood.php');
      var body = jsonEncode({
        "restaurant_id": restaurantId,
        "name": food.name,
        "description": food.description ?? "-",
        "imageUrl": food.imageUrl,
        "price": food.price,
      });
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      log("Body => $body");
      log("Response => ${response.body}");
      if (response?.body?.isNotEmpty ?? false) {
        var data = json.decode(response.body);
        return data["success"];
      }
    } on Exception catch (e) {
      log("Exception @ FoodService.addFood -> $e");
    } catch (exp) {
      log("Exp caught @ FoodService.addFood -> $exp");
    }
    return false;
  }
}
