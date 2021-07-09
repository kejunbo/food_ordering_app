import 'dart:convert';
import 'dart:developer';
import 'package:food_ordering_app/core/auth/entity/user.dart';
import 'package:http/http.dart' as http;
import 'package:food_ordering_app/constant/env.dart';

class AuthService {
  static Future login(String email, String password, bool adminLogin) async {
    try {
      var url = Uri.parse('$BASE_URL/login.php');
      var body = jsonEncode({"email": email.trim(), "password": password.trim(), "role": adminLogin ? "admin" : "customer"});
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      log("Data => $body");
      log("Response => ${response.body}");
      if (response?.body?.isNotEmpty ?? false) {
        var data = json.decode(response.body);
        if ((data?.isNotEmpty ?? false) && data['success']) {
          return User.fromJson(data["data"]);
        }
      }
    } on Exception catch (e) {
      log("Exception @ AuthService.login -> $e");
    } catch (exp) {
      log("Exp caught @ AuthService.login -> $exp");
    }
    return null;
  }
}
