import 'dart:convert';
import 'dart:developer';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class AccountService {
  static Future updateAccountDetails(num customerId, String name, String email, {bool adminUpdate = false}) async {
    try {
      var url = Uri.parse('$BASE_URL/updateAccountDetails.php');
      var body = jsonEncode({
        "customerId": customerId,
        "name": name.trim(),
        "email": email.trim(),
        "role": adminUpdate ? "admin" : "customer",
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
        if (data["success"])
          return true;
        else {
          EasyLoading.showError(data["error"] ?? "An error has occurred please try again");
          return false;
        }
      }
    } on Exception catch (e) {
      log("Exception @ CheckoutService.checkout -> $e");
    } catch (exp) {
      log("Exp caught @ CheckoutService.checkout -> $exp");
    }
    return false;
  }
}
