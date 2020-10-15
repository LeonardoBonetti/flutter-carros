import 'dart:convert';

import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;

import '../api_response.dart';

class LoginApi {
  static Future<ApiResponse<Usuario>> login(login, password) async {
    try {
      var url = 'https://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      final params = {
        "username": login,
        "password": password,
      };

      String body = json.encode(params);
      var response = await http.post(url, body: body, headers: headers);
      Map mapResponse = json.decode(response.body);
      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();
        return ApiResponse.ok(user);
      }
      return ApiResponse.error(mapResponse["error"]);
    } catch (error, exception) {
      return ApiResponse.error("Não foi possível realizar o login");
    }
  }
}
