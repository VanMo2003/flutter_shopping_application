import 'dart:convert';

import 'package:shopping_application/models/token_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_application/models/user_model.dart';

class UserService {
  static const String url = "https://api.escuelajs.co/api/v1/auth";
  static Future<dynamic> login(String email, String password) async {
    Uri uri = Uri.parse('$url/login');

    Map<String, String> headers = {
      'Content-type': 'application/json; charset=UTF-8'
    };
    var body = jsonEncode(<String, dynamic>{
      "email": email,
      "password": password,
    });

    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 201) {
      TokenModel tokenModel = TokenModel.fromJson(jsonDecode(response.body));
      return tokenModel;
    } else {
      return null;
    }
  }

  static Future<UserModel> getUserWithSession(String? accessToken) async {
    Uri uri = Uri.parse('$url/profile');

    Map<String, String> headers = {"Authorization": "Bearer $accessToken"};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      return userModel;
    } else {
      throw Exception("error: ${response.statusCode}");
    }
  }
}
