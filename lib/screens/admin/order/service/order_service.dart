import 'dart:convert';
import 'dart:developer';
import 'package:food_ordering_app/screens/customer/order_history/model/entity/order.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class OrderService {
  static Future<List<Order>> getAllOrderByRestaurantId(num restaurantId) async {
    try {
      var url = Uri.parse('$BASE_URL/getAllOrderByRestaurantId.php');
      var body = jsonEncode({"restaurant_id": restaurantId});
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
        if (data["success"] && data["data"] is List) {
          return (data["data"] as List).map((json) => Order.fromJson(json)).toList();
        }
      }
    } on Exception catch (e) {
      log("Exception @ OrderService.getAllOrderByRestaurantId -> $e");
    } catch (exp) {
      log("Exp caught @ OrderService.getAllOrderByRestaurantId -> $exp");
    }
    return [];
  }

  static Future confirmPayment(num orderId) async {
    try {
      var url = Uri.parse('$BASE_URL/confirmPaymentByOrderId.php');
      var body = jsonEncode({"order_id": orderId});
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
        return data['success'] ?? false;
      }
    } on Exception catch (e) {
      log("Exception @ OrderService.confirmPayment -> $e");
    } catch (exp) {
      log("Exp caught @ OrderService.confirmPayment -> $exp");
    }
    return false;
  }
}
