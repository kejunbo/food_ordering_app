import 'dart:convert';
import 'dart:developer';
import 'package:food_ordering_app/screens/customer/dashboard/model/entity/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class RestaurantService {
  static Future updateRestaurantDetails(Restaurant restaurant) async {
    try {
      var url = Uri.parse('$BASE_URL/updateRestaurantDetails.php');
      var body = jsonEncode({
        "restaurant_id": restaurant.id,
        "address": restaurant.address,
        "name": restaurant.name,
        "description": restaurant.description,
        "imageUrl": restaurant.imageUrl,
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
        return data["success"] ?? false;
      }
    } on Exception catch (e) {
      log("Exception @ RestaurantService.updateRestaurantDetails -> $e");
    } catch (exp) {
      log("Exp caught @ RestaurantService.updateRestaurantDetails -> $exp");
    }
    return false;
  }
}
