import 'dart:convert';
import 'dart:developer';
import 'package:food_ordering_app/screens/customer/cart/model/entity/cart_item.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class CheckoutService {
  static Future checkout(List<CartItem> cartItemList, double totalPrice, String address, String type, num userId) async {
    try {
      var url = Uri.parse('$BASE_URL/checkout.php');
      var body = jsonEncode({
        "total_price": totalPrice,
        "address": address,
        "type": type,
        "customer_id": userId,
        "restaurant_id": cartItemList.first.food.restaurant.id,
        "food_list": cartItemList.map((cartItem) => {"id": cartItem.food.id, "quantity": cartItem.quantity}).toList(),
      });
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      log("body => $body");
      log("Response => ${response.body}");
      if (response?.body?.isNotEmpty ?? false) {
        var data = json.decode(response.body);
        return data["success"] ?? false;
      }
    } on Exception catch (e) {
      log("Exception @ CheckoutService.checkout -> $e");
    } catch (exp) {
      log("Exp caught @ CheckoutService.checkout -> $exp");
    }
    return false;
  }
}
