import 'dart:convert';
import 'dart:developer';
import 'package:food_ordering_app/screens/admin/order_detail/model/entity/order_detail.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class OrderDetailService {
  static Future<List<OrderDetail>> getAllFoodByOrderId(num orderId) async {
    try {
      var url = Uri.parse('$BASE_URL/getAllFoodByOrderId.php');
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
        if (data["success"] && data["data"] is List) {
          return (data["data"] as List).map((json) => OrderDetail.fromJson(json)).toList();
        }
      }
    } on Exception catch (e) {
      log("Exception @ OrderDetailService.getAllFoodByOrderId -> $e");
    } catch (exp) {
      log("Exp caught @ OrderDetailService.getAllFoodByOrderId -> $exp");
    }
    return [];
  }
}
