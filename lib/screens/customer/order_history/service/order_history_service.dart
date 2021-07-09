import 'dart:convert';
import 'dart:developer';
import 'package:food_ordering_app/screens/customer/order_history/model/entity/order.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class OrderHistoryService {
  static Future<List<Order>> getOrderHistoryByCustomerId(num id) async {
    try {
      var url = Uri.parse('$BASE_URL/getOrderHistoryByCustomerId.php');
      var body = jsonEncode({"customerId": id});
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
        if (data["success"] && data['data'] is List && (data['data'] as List).isNotEmpty) {
          return (data['data'] as List).map((json) => Order.fromJson(json)).toList();
        }
      }
    } on Exception catch (e) {
      log("Exception @ OrderHistoryService.getOrderHistoryByCustomerId -> $e");
    } catch (exp) {
      log("Exp caught @ OrderHistoryService.getOrderHistoryByCustomerId -> $exp");
    }
    return [];
  }
}
